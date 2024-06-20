Return-Path: <netdev+bounces-105279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD339105AE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B0F1C20CD5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF61ACE96;
	Thu, 20 Jun 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c10mNMkK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795131ACE93;
	Thu, 20 Jun 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889604; cv=fail; b=Okrn+4aNEQWpQvuZKq+Ey1QWqGjajpKf58YuTJU8CDJWsHMJcHJ5qKIMGV0cgQ2HielPFz3lFi9tL3s3RD8sQTYAVEp86RQXmSdIy9DKgdlgMSpG07uUDhE+lKJhwscv91S2mlnN0xXXM3/kJ2N9Ag/HzWT7Bu9m3gLQvvpTBo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889604; c=relaxed/simple;
	bh=me+tlBbSI24PccsBHk3hHVmAbYt4jhSSA2GEVDKEuVw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AqM4IuoSs056g4U1iZbzYpLlGU9nHXfHdkc3Qkj5En4ZpAKs3A/J+eaVsySFwhunZNLqAIBrweuivJiFiYiZlPoDkpvaWjeaF+B5ePasHPSw51a0cRNyB/CrEyXna0fbJBRBHuqMUvUMPlqsqCKpI6t2NzKpq7Yk+oXRbrVTiSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c10mNMkK; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718889602; x=1750425602;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=me+tlBbSI24PccsBHk3hHVmAbYt4jhSSA2GEVDKEuVw=;
  b=c10mNMkK3tCTjkF3rDliWPI+liJ21HbYLbbU2hVWUVH6g/f83rhMGI2r
   7UhhMNru2yNmSWlIl/GGrb4EiN+Z+P7Eb53PBulDe9E8KKm7OkCOSLxoh
   coAP22qqj6rAJCsr1Nb7KVDzDz6O8ehjZxwiaKnJLL56RKyV7okIzCenH
   8hVvaGfCBe9THy7ACaLbxrbOptnv8b/xy0VQb+0jZDwXAA1wL83Bn+U0U
   pFoISf2wdgZg1sQDzFyaBKW5IT4Zy2GXxUpjcxM1/Lst/MsCJfEaGioVh
   BbQSdMrBzra9V2W8ap2h6XzrK3qc5phMxrlGxDAQXTIVYPedn9MkMcF03
   A==;
X-CSE-ConnectionGUID: /V+YAOvySZWmh5pHk31mdA==
X-CSE-MsgGUID: PjPOxfR6TGy4QUgLYcAOSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="19742180"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="19742180"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:20:01 -0700
X-CSE-ConnectionGUID: fPfYuhLrR8iGS72fzjtLsQ==
X-CSE-MsgGUID: n+kXf5FlSZK1WD6rvKc0QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42344992"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 06:20:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 06:20:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 06:20:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 06:20:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeQOca6i4/zO+C4gkOXcoqjzjC7YjMIeDUoYxMum7NWQZIGxWtPyn49GoLoNi5LK7Qo/yRplKxG6z2aJUTKCc4aB7rUZcB12VOuw9Sa1ficH/LR7kEU9s4aeagnwSVFelnUJn8pxBfwZJLuSbDsAOjbJ1MNKp2Ki9jHO00jzPv6iG6RU2XdFp4Gw1XV7KAlIgf1pmlaoDR3sB1Kq8P56ozhP77QBQPegmk5Q+95NXrOD9kslaZgyG8OqUD1Ycap8karpaKTzT169ouHqoT+bKeKdbv5thV6xoSDYRfXTEEdZWzVP9SqCR7ZH2CwzKMdrLfbbGTWKfFGTBTI38IPsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1Fzq40fFPYfs1551r2uSPp22B/Ig1trnLNC/asycGE=;
 b=E3kqNJOlAtjRXDuRDvST5w0VeiXZxnw6RghqF5GFLGZusjNGZ5lY8NFUEmPH3neHEXE7CMcHOnaKIi3Un0E+8SlaRs5lFfAe25AfUiqDCft3ArJRqvn3tHcooEs3d67gqLmo7bNeRknN+zr0B4Ij+VdUsBbxbHASgBj+rVxgWRmr+q/mmSdx0OIBRSj26DMPRt+tGGCWsrKbreRZJonIcqVnU4t/zrW64dP0KchgNDbGQ72CDseYPVaoynhc6PLGPVGaQmRl9urABWgERqw5AiYmyjBmHXyHpkFzkVHkXlY/KW3s6WZUGY/mdGqEYrS/1sJVQsAl2GmonKs54vajyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Thu, 20 Jun 2024 13:19:58 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%7]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 13:19:58 +0000
Date: Thu, 20 Jun 2024 15:19:51 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Luiz Capitulino <luizcap@redhat.com>
CC: <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<poros@redhat.com>, <netdev@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <magnus.karlsson@intel.com>
Subject: Re: [BUG] ice driver crash on arm64
Message-ID: <ZnQsdxzumig7CD7c@boxer>
References: <8f9e2a5c-fd30-4206-9311-946a06d031bb@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8f9e2a5c-fd30-4206-9311-946a06d031bb@redhat.com>
X-ClientProxiedBy: ZR2P278CA0059.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 74837425-8686-4968-0ef4-08dc912baeb5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dkrxywX4CLljE7gUDOYsEKfLQSHNSROrffiSxj4iUVLFYoGYeQJIx4DfD6Ia?=
 =?us-ascii?Q?enUAhRjZX9TPbrvgpGze+HBoXKYVgbqxI4vuGafNHD6X9irjG+3ErLEAzMar?=
 =?us-ascii?Q?FrwlzOR0RoZ7sRs/IuDq5narHPfn7H0twwn64gzAbjJs72JSBKx6KKxLIhJm?=
 =?us-ascii?Q?gmEzqMB2Jcn3+llZPxpqNfwR5VunsmNlZkJeIxNQJ6WXyzOfOtNFdDbUXMD1?=
 =?us-ascii?Q?01wxrBkCCxag1wGONm73btQmoLP9vCdUibJzp84hkMRgrBhAKLwVEKl1uTkW?=
 =?us-ascii?Q?OmmAC/joxDcsEbp0K+iHM5FLPxTfFvVy+LU+Fark6C1TJ6GV96vvVxFPk2FO?=
 =?us-ascii?Q?JTDRM32kmI42bWHAm5wKEydZcxWb20X6fCFKyf95i59kVd8qPtdSchT9h/rh?=
 =?us-ascii?Q?UP6tb6mOdTiDm3FyKNY5SVybPPZ6+2b4OM0rdsD6iRuBin9fR77EoT7fwImj?=
 =?us-ascii?Q?iZV9uOdhYsn081lHh2lOj9Z9sFHDxXqRBDsWjIG7cwdepEyBjvLQBZfeUJIU?=
 =?us-ascii?Q?UjWWs9z0nyM5tDBNb4MIRkgXJFSoTOsJJ2f26SxrBx381GxEIC/XGKds8PuT?=
 =?us-ascii?Q?5SIcbotunYxCEAqHBbAIe79oZmTUAHUkkEqBFGWmGbOqiF48L4GFJT4gw/n3?=
 =?us-ascii?Q?+OhNUV5qAGkkJ1V4Yuwgpm8z0/pXudGedD8/apBfOEXweMy2VeSEc7+tf5V9?=
 =?us-ascii?Q?KBlYGKCEeAxS9OQSn0qUwWt7oskVtdf5D8QpEPEPedOP0HANnwjn9R0IyqG5?=
 =?us-ascii?Q?E6ESt1uzfJ1dy4dcq0A9PrQnHJTezwa09LA/LyP/4zcnWDwXyLYHA4bJ69+k?=
 =?us-ascii?Q?YV4ad0xxswDPaYEW6taJOOal6/eS/1MYe/YeWcmEry07d+Kv5uGuCeDUb/AL?=
 =?us-ascii?Q?hBT2+WKWXDh1VDayxu7PBae7HQ9n2Y9XjYjttEQJIgO5G7ywn+Dl6p0iOQiq?=
 =?us-ascii?Q?+S0dOVNyWVpD+0izcpYiiUj8J7Q3VHw1WAlQPVa9bsZPBypk1EU8J7CVd/sp?=
 =?us-ascii?Q?zQgJEZ+J+tCJTnHlz4pcdwD2t5DJSjQvwlXiIbAUeMpkuWnQAHs6aebsEh24?=
 =?us-ascii?Q?EDcMRBndyPLiTfsZs4BYIN8Un8WWMGISIerc6erYLGgI3lypQ4tP/1UAKXPT?=
 =?us-ascii?Q?CNTbypWgCrT+yVx0MCqknCbn71YZqrBzaRtA0RYl8JKzyXw+ZdjI6goVdKFF?=
 =?us-ascii?Q?K0zk2s71XpoQTq+7jJZJ94KZRHn6bMbZakul5EbL8VAL/cnXODIUe7wIMdc1?=
 =?us-ascii?Q?zOn7ZHu/Ho2GyqFEw8mB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bSPmHUtVSOVDM8zPizNh9jTUfWSuznT8idbZqTBvznHhntf3H57m2k1K9jBN?=
 =?us-ascii?Q?IBmO6uSZLtpP87zIQ7oOobCfw/0HNcFOa5PHNYHve261jvSTSuJligvR+tKn?=
 =?us-ascii?Q?vYgp6zJshiJwhCJbwi7wU3AXWgbwELlanj/R6eVgMpuI++ydM9GoaxUJTbsd?=
 =?us-ascii?Q?nU+xhKzf9ZzdbxeMfB1tPMbFCUE+3qlgz8j1YbDW+J8P4ARL36Ax6D+Viptr?=
 =?us-ascii?Q?mtIn+n8Il5Sp3pWXJ2LCmCaITm8k/GUE35YKlTzKRkPZxxAikkDHgFYGm4da?=
 =?us-ascii?Q?WnhmfT338WilqerOZulaeWq6o1SJlIzGWjEJNufAZnf4s0cqPxaZNCTWXK5O?=
 =?us-ascii?Q?W1FaK+HR5OsVamm8jAfN4rFFFQH1kxQODCgKsvKzTsnO2sjsdNnqXsj8Lexr?=
 =?us-ascii?Q?f2jraBGsWI7nS4Y/bTMPDUWvKGG+quzoa0953c3JwEsIhHNvUhuZvvRpRZkf?=
 =?us-ascii?Q?whInsGghsewYvsMGdm08hJhmsXTSxFUOgriOuyadH4V9ltDP9ow2BRAz0pHc?=
 =?us-ascii?Q?9Ln2T60gnc4zUtO1QXOpCMLcqPWjqw419DkDms0S1lwOaa51DpiGiJcTCOYV?=
 =?us-ascii?Q?Jtz4Ac05POs+FOp8ka8L6f8xpsPttPk1F3Oxp/041F7lzsNKWu7F8febei5F?=
 =?us-ascii?Q?f4xK6emwU8leKGXfOVbY2+IgNCy+4BMFAve8H93JX3wrviLdDdknkOudUrRl?=
 =?us-ascii?Q?cCar5j/eDpBtltKiK0PbnpPy5l76FeCv+wf+6qZHWTSqbjzQV6kQrzyfDhYe?=
 =?us-ascii?Q?Ka9olBVaSZVsb3LOgywCEQt54GbSPPNScNoWqECslabmsf4DXOomAfTjUzc/?=
 =?us-ascii?Q?tSFGugJDgzXXQlvjR+I/FB6tRMrIX8G5+Z0tjUd4O559GaynTK3w+ZnY7c5P?=
 =?us-ascii?Q?YPZDy+CiwtyXkfb8kYQL5GWaqHYRbu6HyBYYmxvCo0TGj0UES+hO7v1nZAAX?=
 =?us-ascii?Q?H6BnScIPbwQ4cUpbX1vBtkyqLqNqKxasSXniI2RhsyDru2nG1n34JTLgiRMj?=
 =?us-ascii?Q?I+vcSMrCPeCz7qvKmg1EWdy67guu/XN50tU/1vf0UoCRMck3tpZvwi6sX9dS?=
 =?us-ascii?Q?L1TwoIvVYwCYX3e1KkTBob0xi16DuBClmatOCV5Mn9BA+LX7AMvQXn96V0ar?=
 =?us-ascii?Q?1YxMU9vmTB2+3g8E0Od7Zk42VfhA+FZUPVi0xLVieEpIWVcNNO5PM4n4AV3j?=
 =?us-ascii?Q?wLHnvp2wwvUWmXofk9YQiUm8sKgs06nojOiL6evrOOjTPf6+QjpETRFS/zla?=
 =?us-ascii?Q?mPT16oeV3WJujxHFcWMLGukhFyhpi05SA6V42MihLozxkhMUgZQ2LKja40qu?=
 =?us-ascii?Q?Dny1TpMGBBrzrEITOAhCnOLjL1JkdNKs71QtEpSP01qu7ulKrd64jCMr8eh+?=
 =?us-ascii?Q?3mKfiYSFEIR1XJch18drJGeS8+Ibsbi9sXSRcsFGN70AcLGc7R89tUHKdT6x?=
 =?us-ascii?Q?QiOMBcllYTBptXQR9FIUuzOPp8Oi52LSSpbqsTGqrDFRI3/ZVYVkdV/WaoMW?=
 =?us-ascii?Q?5I7u4Y+EVefUXLQnaIjC1NQTG3930ukN5kiKG07ac1Pgfy5yuC6iyql64NTB?=
 =?us-ascii?Q?/LqkzTT67eQJW3QKkYjF3P6kmZzSrXX1NLEy0VfosTJBTc/7MJWyrj4u+hdR?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74837425-8686-4968-0ef4-08dc912baeb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:19:58.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kApHKYNW+oMqy0Zs7/8jp2Hlxb/rp4+ZJsgUab8KkPnGp8xwcvuTz23yRTCz1vZI/anHcwjiSHM+kri1Fbzz93xr3pOklrudK7dTdHxuvZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com

On Tue, Jun 18, 2024 at 11:23:28AM -0400, Luiz Capitulino wrote:
> Hi,
> 
> We have an Ampere Mount Snow system (which is arm64) with an Intel E810-C
> NIC plugged in. The kernel is configured with 64k pages. We're observing
> the crash below when we run iperf3 as a server in this system and load traffic
> from another system with the same configuration. The crash is reproducible
> with latest Linus tree 14d7c92f:
> 
> [  225.715759] Unable to handle kernel paging request at virtual address 0075e625f68aa42c
> [  225.723669] Mem abort info:
> [  225.726487]   ESR = 0x0000000096000004
> [  225.730223]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  225.735526]   SET = 0, FnV = 0
> [  225.738568]   EA = 0, S1PTW = 0
> [  225.741695]   FSC = 0x04: level 0 translation fault
> [  225.746564] Data abort info:
> [  225.749431]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  225.754906]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  225.759944]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  225.765250] [0075e625f68aa42c] address between user and kernel address ranges
> [  225.772373] Internal error: Oops: 0000000096000004 [#1] SMP
> [  225.777932] Modules linked in: xfs(E) crct10dif_ce(E) ghash_ce(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) sbsa_gwdt(E) ice(E) nvme(E) libie(E) dimlib(E) nvme_core(E) gnss(E) nvme_auth(E) ixgbe(E) igb(E) mdio(E) i2c_algo_bit(E) i2c_designware_platform(E) xgene_hwmon(E) i2c_designware_core(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
> [  225.807902] CPU: 61 PID: 7794 Comm: iperf3 Kdump: loaded Tainted: G            E      6.10.0-rc4+ #1
> [  225.817021] Hardware name: LTHPC GR2134/MP32-AR2-LT, BIOS F31j (SCP: 2.10.20220531) 08/01/2022
> [  225.825618] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  225.832566] pc : __arch_copy_to_user+0x4c/0x240
> [  225.837088] lr : _copy_to_iter+0x104/0x518
> [  225.841173] sp : ffff80010978f6e0
> [  225.844474] x29: ffff80010978f730 x28: 0000000000007388 x27: 4775e625f68aa42c
> [  225.851597] x26: 0000000000000001 x25: 00000000000005a8 x24: 00000000000005a8
> [  225.858720] x23: 0000000000007388 x22: ffff80010978fa60 x21: ffff80010978fa60
> [  225.865842] x20: 4775e625f68aa42c x19: 0000000000007388 x18: 0000000000000000
> [  225.872964] x17: 0000000000000000 x16: 0000000000000000 x15: 4775e625f68aa42c
> [  225.880087] x14: aaa03e61c262c44f x13: 5fb01a5ebded22da x12: 415feff815830f22
> [  225.887209] x11: 7411a8ffaab6d3d7 x10: 95af4645d12e6d70 x9 : ffffba83c2faddac
> [  225.894332] x8 : c1cbcc6e9552ed64 x7 : dfcefe933cdc57ae x6 : 0000fffde5aa9e80
> [  225.901454] x5 : 0000fffde5ab1208 x4 : 0000000000000004 x3 : 0000000000016180
> [  225.908576] x2 : 0000000000007384 x1 : 4775e625f68aa42c x0 : 0000fffde5aa9e80
> [  225.915699] Call trace:
> [  225.918132]  __arch_copy_to_user+0x4c/0x240
> [  225.922304]  simple_copy_to_iter+0x4c/0x78
> [  225.926389]  __skb_datagram_iter+0x18c/0x270
> [  225.930647]  skb_copy_datagram_iter+0x4c/0xe0
> [  225.934991]  tcp_recvmsg_locked+0x59c/0x9a0
> [  225.939162]  tcp_recvmsg+0x78/0x1d0
> [  225.942638]  inet6_recvmsg+0x54/0x128
> [  225.946289]  sock_recvmsg+0x78/0xd0
> [  225.949766]  sock_read_iter+0x98/0x108
> [  225.953502]  vfs_read+0x2a4/0x318
> [  225.956806]  ksys_read+0xec/0x110
> [  225.960108]  __arm64_sys_read+0x24/0x38
> [  225.963932]  invoke_syscall.constprop.0+0x80/0xe0
> [  225.968624]  do_el0_svc+0xc0/0xe0
> [  225.971926]  el0_svc+0x48/0x1b0
> [  225.975056]  el0t_64_sync_handler+0x13c/0x158
> [  225.979400]  el0t_64_sync+0x1a4/0x1a8
> [  225.983051] Code: 78402423 780008c3 910008c6 36100084 (b8404423)
> [  225.989132] SMP: stopping secondary CPUs
> [  225.995919] Starting crashdump kernel...
> [  225.999829] Bye!
> 
> I was able to find out this is actually a regression introduced in 6.3-rc1
> and was able to bisect it down to commit:
> 
> commit 1dc1a7e7f4108bad4af4c7c838f963d342ac0544
> Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date:   Tue Jan 31 21:44:59 2023 +0100
> 
>     ice: Centrallize Rx buffer recycling
> 
>     Currently calls to ice_put_rx_buf() are sprinkled through
>     ice_clean_rx_irq() - first place is for explicit flow director's
>     descriptor handling, second is after running XDP prog and the last one
>     is after taking care of skb.
> 
>     1st callsite was actually only for ntc bump purpose, as Rx buffer to be
>     recycled is not even passed to a function.
> 
>     It is possible to walk through Rx buffers processed in particular NAPI
>     cycle by caching ntc from beginning of the ice_clean_rx_irq().
> 
>     To do so, let us store XDP verdict inside ice_rx_buf, so action we need
>     to take on will be known. For XDP prog absence, just store ICE_XDP_PASS
>     as a verdict.
> 
>     Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>     Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>     Link: https://lore.kernel.org/bpf/20230131204506.219292-7-maciej.fijalkowski@intel.com
> 
> Some interesting/important information:
> 
>  * Issue doesn't reproduce when:
>     - The kernel is configured w/ 4k pages
>     - UDP is used (ie. iperf3 -c <server> -u -b 0)
>     - legacy-rx is set
>  * The NIC firmware is version 4.30 (we haven't figured out how to update it from arm)
> 
> By taking a quick look at the code, ICE_LAST_OFFSET in ice_can_reuse_rx_page() seems
> wrong since Rx buffers are 3k w/ bigger page sizes but just changing it to
> ICE_RXBUF_3072 doesn't fix the issue.
> 
> Could you please help taking a look?

Thanks for the report. I am on sick leave currently, will try to take
alook once I'm back.

> 
> Thanks!
> 

