Return-Path: <netdev+bounces-138102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B4C9ABFA5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053B2285884
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 07:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF33146A62;
	Wed, 23 Oct 2024 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7svjOqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92C3A8D0
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666992; cv=fail; b=DzQDvI4h+m5kTu7Yy7EhBdWmcwcTe8JuHsDJRrG/4BKkfm8n3RxK0xKBmc2Q6DawhcyRvmUciB9n3FFmr01fRSgLvXhINfaikC40KLandRmUD0zd/ycxKwkyWjz+RY2JlGP4nRzUcH2E0Q/mViOF6+0nhmFVfEdTwqIXjC+vAGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666992; c=relaxed/simple;
	bh=d1RGTg5KA183+IlZMjZ+Z8RmhL+9W4CkGtGSOOAmRSo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oAcqRgNSGEqKHA+e/EgPVBDZljh5OMjdfZe6ZVniKd23LS61SOSNauFLdgIf/GEWsbK3RCEv4In8gUrFsJxy0dsWGd2NgrMuuDJfmjkS/sLxMumzJhOljUv/anakHBWL6j778V/zCKAy9I79XCY7NWrjt+FQITg2/ojHs69I58k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7svjOqJ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729666989; x=1761202989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d1RGTg5KA183+IlZMjZ+Z8RmhL+9W4CkGtGSOOAmRSo=;
  b=b7svjOqJCDcdQ3lpyyIObcfZXuEXY9gSZYekBfmtUU+3d7cbcpgOkcz2
   aAnnVbaeLAAJK2/TAIPe3bl0tRLIV+6WAh9rf1PaCm52fubFfCPHFd13Z
   7vZdUf/7X4mp7ac/CxsfjrxYzM2NtpBkzg0xGZuwlif8s5vNcYbn1zn8u
   Dsq1tVg3anCAjRWMwBgCvVKwLoYnzpX7P9hd9bqcnRzjDxp6JOTkui0OI
   Fw+8mVR4SKmxb1RbwVEpBnzDz43nuCbWMFSjfia5K9N+IKNMcxx/cgbmE
   cKW2+uXgktrRt+DSc+AYZ+LFgyIFs4IlBnoGUQK1U3xL22CD+p+CX3Y4Q
   A==;
X-CSE-ConnectionGUID: e0Y6K99zQcyeS4n3Esf4tw==
X-CSE-MsgGUID: gLWczP/uSu+/5KiLemw6jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28698829"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="28698829"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 00:03:08 -0700
X-CSE-ConnectionGUID: H9QD7vPuTrS1N6qTy1uS2g==
X-CSE-MsgGUID: U59TPovUQTucazq2FgEXHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84723857"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 00:03:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 00:03:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 00:03:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 00:03:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAeOgZEPZg3CACzL23E2W2CbcIgfO6Okfef5q5vGS8/5MCLQy4mTehrc/EunqG0gwhE0qubj7KHyATZJiBHkaVA49TRMF3E1ItJL/W2ZNJWuO3Igm1tNdzK9Iq/Mt+ADDXgEJLozUMeWqcqTpw+++dLxAypifzCJdTm4OHPY0CYlULV1yX5cwuvK9McDobYkxp193tFY3RQuEKym0VMjVqIsPc4/W7OVwUUx3bZdzLXbWftbXbK7Ko1/D1NxvuLyc23b8DtzqNCy3tl9Pepr/c5hhdACUHL9w+6P5EUJjmo3MRXqF4W925fbP9UHvV/3GmyjeYYdVw/apwwXJQnntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRutVW9A89ShHZJdbALaRsn7qI3QLLCzYOMoQSRAZLY=;
 b=MyBxY5e5MD+X3lS0PPUWCdBKRw4ikIDS8AUGnNT96iETjto9FQyTw9CXeLHPvzhw4RZoc9C2OnC+hUTs1nO81Q2kE9gDqEk+D8zn4F0Tcr3qrrPooc7lSTBR1oBEUZmrCzQFxMcV1oCF0ti0qOeQIcU0s3OAw9v8sm2HIRQRhcbIotTpYIjoBPgW9+/oGZAnhLSLbLE5qTgn+b8vR0FyGRbSHC4XSwo1pLF7XQ1aA5m7GXJ3ku/UmuJPfaaX38WTFDPdTqodhaEfJA9J//uy0LdXOwb8S6GIlT8Fqbih/fDAdjWu7z3sHPIS8p/rU3GqPYlIxprQmf5tr+EWVrOykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7526.namprd11.prod.outlook.com (2603:10b6:806:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Wed, 23 Oct
 2024 07:03:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 07:03:01 +0000
Date: Wed, 23 Oct 2024 15:02:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ignat Korchagin <ignat@cloudflare.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet
	<edumazet@google.com>, <netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [net]  18429e6e0c:
 WARNING:at_net/socket.c:#__sock_create
Message-ID: <202410231427.633734b3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb3c21a-3abe-4e3b-3f91-08dcf330bb90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ljZ8iIrKKfcEf3fooGqavkGy7ohmA4jRrK/oWUmijuEoNCrvRFyvo96bTpKr?=
 =?us-ascii?Q?kFHyQyohoD7w45z6PKtZR52ccnnuFPswX7XF35VkoDQtqWuZ2A2UjwxZJXD5?=
 =?us-ascii?Q?ygP7qtVMsN5p0AOEhO/BGDx10xZvF6k7GA8DN5gX8200oDh4v7FqmwCnJaaG?=
 =?us-ascii?Q?dFOPl8kLiypYMpBGU8T8v/JpHLf2vgleuOe/3ZCm71fMuioXLcZjKafzPphv?=
 =?us-ascii?Q?fVOA8UkOz1iwCxxfQsGy3TFqfkzxo7FywZanydYOtGj+ZFxmoGQ+mjfx2jeU?=
 =?us-ascii?Q?k6ywiFEABSs+DTL/EGLGI14q5MhgGK18JIU3A9rZTuC6r9pyV3j/71p2rAtp?=
 =?us-ascii?Q?jngbl34SJSI20WVXPV2DAQ0fidWwW/dDi519oySBSbqC4NVFFYNuZJgp6wPu?=
 =?us-ascii?Q?0jFbDOIx0ZP5wgtvYKJHkq0ONBf+ankexLhMRIc13bEAoilHnSfJFUbcrT4Q?=
 =?us-ascii?Q?gSYxHTEO41KsFtvKW1WTWsmDuVQfPV7c5HCjtJ6FAQ/5+IP5d10Vpv16qWRV?=
 =?us-ascii?Q?W0b5RmY/S2AHSTYwbxavowLOfT6OgIFWjtOXrHecWEIBKPtUi80cBPar9aaH?=
 =?us-ascii?Q?u3nX+LPpPi0/Hcr+/OTN7YeS9uIt3hEOP/0CCBq81sGn6BF95S/HS4mAx5vN?=
 =?us-ascii?Q?I9Vyk+of46fwfFWBXD55SA7DQL7MT7hh94iLgBSl3M8esCd7hu1yUPl4zmq4?=
 =?us-ascii?Q?Qm9tgNeYXt+vT1CV+pzVGK/pVN0OTn6dw2WHS8fK67WiWq4akM/YBObusLH0?=
 =?us-ascii?Q?zVH5yh8p7V8IZqxk+32yNhf1xY3oGel2VJSDmJeNFw4rI1T21ot5UxcqBqbQ?=
 =?us-ascii?Q?Acm38nMOwCyOVd5gOWilrSEbjBMomd/ltjS0SXjq70RvvjZCJpPY0uKzCqCO?=
 =?us-ascii?Q?ijYykhIAQOIfpEtsz9jOq5XrnRvAvZs+g9tY+ngTzjwiwyfV2pwZCvfMQkja?=
 =?us-ascii?Q?bfobWBvggzSNMxqYRCyhkxNb+G2WNTLGF1dyQhnN1QbOLqCBlbMkMkkNwolM?=
 =?us-ascii?Q?uYU+clrZ1AiVWw8Xg4rj6PfaHpYXT9csB5RNY2TJriXIn9eOT8+YCNWQWPHi?=
 =?us-ascii?Q?Dik3NfHrUIbxHF/Aq3BltSxs2I47PtqQOffWiVlCRVH6Eu8MgCCw8N8tjOjQ?=
 =?us-ascii?Q?Sw1GoTeZzHw0HS43xbF06VTypdW8xJGC0aTRjFPPal6lklIffPq+on6ppn0N?=
 =?us-ascii?Q?cLx6HnLYn7zDb+/3oYGdGK5bp1U4sP9diTFQ3oXZ1xAvD35aaiAsr3GU5sIx?=
 =?us-ascii?Q?esx4phWZUeSAA9fYrWaHDGhlPyO6ipG9//d446uRtw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owWSvyugv0bZdtW6N0ul/+32oks590MXxKOXxcCqCeEqrPksyXcHxM/+eXC1?=
 =?us-ascii?Q?8qMFceP1VsLQ2mIpKACdPioNP/groEii4u3ngXHQI+7FDvyBZC75Qu25OhsC?=
 =?us-ascii?Q?aeU4yBwjukKf1AGSKnWO0F5qwCkbmGB/997JlYObIVkT8c3Hik+Qq9sgSwy3?=
 =?us-ascii?Q?oyzFFzfxPG0WL51Tp4etwc1DckYVNouN/P9ydY4Q4nC8gFEHeRL4v4r96C3e?=
 =?us-ascii?Q?hiCOeqiJJf84wTAgKz5ly1G3XMdAXQFxSTFQZGhGgxjTI8FZLOj//e0ASrZE?=
 =?us-ascii?Q?lHWxV/wcDb99JFqdhWyCpcb95E0x2J2ByD8HC4Y6urQyrMPXfjsgdQ8QrPPG?=
 =?us-ascii?Q?8IXc5UjuqT9dtd98TddgdMx14Db4d4ELWpNx7rE1RvOeWjxW9IwDdjwlkxcE?=
 =?us-ascii?Q?UbM/anyFF6jHJWWntOyZoLWysTNcAFEJ+XiEbUDpIFClVKw3VV3XmEy/mdA3?=
 =?us-ascii?Q?l2XzKQsc8I/ION+7CbzmbM6HdoE3Z3rctKZGHQbbvxx4YDtnGQaZha994hSp?=
 =?us-ascii?Q?+rE2vGe/2Gs5EJEk6bDrmWaJUSuNCzp6JHyHMTtv3mncksaeANc0L0x4mLKi?=
 =?us-ascii?Q?GBoU0f52Pdfd13jTdimJoZ7XAeZOCGnirbyerwKl9gIPmp9zOzHi0fSlcB2r?=
 =?us-ascii?Q?q4vpQAye7jl30Ul351ylKzEplfotIu2ncl+ex5yZWpyl3Kz+cPdlsBGjoZLd?=
 =?us-ascii?Q?WC90/KQVbzBDLXzHbZ1K18t400wZOLV2E1YwJFYF74X176QqNwqT91cDL0cC?=
 =?us-ascii?Q?vEj95fdluB+o3AImvMOqjtc7lhsWGCOgGVAwB8ybF+g7NwjM+FV9edpkO7Dx?=
 =?us-ascii?Q?GivCYiKDiAzB53FTASmMGJdxkquRpaG/+iWc3ifOpg/8PivIAwLLUlQY96am?=
 =?us-ascii?Q?R83ORDynK1mYXJpZQUIdrQOz4dybgqRA5sL5nBBdxVxXcPNVspYobnTBwg6f?=
 =?us-ascii?Q?+EHxRsSC3ma4CQSZj2NuJkx+zJikSTg0lH/FYei8HfX0q+aKCMzdCLs+BOCL?=
 =?us-ascii?Q?72f/90YOJ6X397boBdzAucSDJHPAiryW7jTL9N09qQWa+IwaAhcZwpfB8wVs?=
 =?us-ascii?Q?5WWI4lAM3XFv5akqm4Jg9TyrYg0r4+51+5HioNoUWO8ZsRq+K6TA+F0tISLL?=
 =?us-ascii?Q?lOeAN07L9gr9S57PziFrmsMn9o4qwWBtjFFl2hf0o8JV8oDMvakj90/cMuCY?=
 =?us-ascii?Q?hinB/e2JhSrDiUyBsranNNZxxAOggAN7u/w/VAIoN5kHkuuoQh9t+s+K2nld?=
 =?us-ascii?Q?hBEcZt68/C2bTIHJPVvykp6feXYZSKNgoSn0ElatTia0j08R+MMVsoIOEPLD?=
 =?us-ascii?Q?aGAmtcWZL3zasHuI0U+RLrpvelt9vsSVsq1r0d5PcLINjfbm8nP4wSwY3EOR?=
 =?us-ascii?Q?A+YiyhIOCcNnsBa8RgKHApWmY1ZVtl7FCzo5MxaiWrUue0JnbOrLZPdgRhz9?=
 =?us-ascii?Q?HhtTJB466g3rWZqSHV0uQnBdY+hCWjurA2JABcOZRsSjkJv9E9hZq9JRorzx?=
 =?us-ascii?Q?QBNTCotFbawrRhCBcO976+x3cmXehC5J3+qPoOR8sGGTUZGWucBtpjJ+p4yD?=
 =?us-ascii?Q?d+BwuM7R0Mw8l9imJA+goVlxBpdPmm1+RtfeeE+vJFdQaOSYbc1MnQ5+RhUu?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb3c21a-3abe-4e3b-3f91-08dcf330bb90
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:03:01.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEdHLNlhnFsA8EvvvGw21tAS3fcM8Ps+KfCCqkKjMvJhd914i3qyWWHoP9enHX0qp3lUaiOSywYa7SBLTlbzIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7526
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_net/socket.c:#__sock_create" on:

commit: 18429e6e0c2ad26250862a786964d8c73400d9a0 ("Revert "net: do not leave a dangling sk pointer, when socket creation fails"")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master f2493655d2d3d5c6958ed996b043c821c23ae8d3]

in testcase: trinity
version: 
with following parameters:

	runtime: 600s



config: x86_64-randconfig-072-20241019
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | 48156296a0 | 18429e6e0c |
+------------------------------------------------+------------+------------+
| WARNING:at_net/socket.c:#__sock_create         | 0          | 23         |
| RIP:__sock_create                              | 0          | 23         |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410231427.633734b3-lkp@intel.com


[   81.874092][  T849] ------------[ cut here ]------------
[ 81.874427][ T849] WARNING: CPU: 0 PID: 849 at net/socket.c:1581 __sock_create (net/socket.c:1581 (discriminator 1)) 
[   81.874997][  T849] Modules linked in:
[   81.875214][  T849] CPU: 0 UID: 8192 PID: 849 Comm: trinity-c5 Not tainted 6.12.0-rc2-00650-g18429e6e0c2a #1
[ 81.875701][ T849] RIP: 0010:__sock_create (net/socket.c:1581 (discriminator 1)) 
[ 81.876000][ T849] Code: e9 19 fd ff ff e8 a3 16 d7 fd e9 4f f9 ff ff 41 bd 9f ff ff ff e9 b8 fa ff ff 41 bd ea ff ff ff e9 ad fa ff ff e8 83 95 9c fd <0f> 0b e9 72 ff ff ff e8 77 95 9c fd e8 62 72 12 00 31 ff 89 c3 89
All code
========
   0:	e9 19 fd ff ff       	jmp    0xfffffffffffffd1e
   5:	e8 a3 16 d7 fd       	call   0xfffffffffdd716ad
   a:	e9 4f f9 ff ff       	jmp    0xfffffffffffff95e
   f:	41 bd 9f ff ff ff    	mov    $0xffffff9f,%r13d
  15:	e9 b8 fa ff ff       	jmp    0xfffffffffffffad2
  1a:	41 bd ea ff ff ff    	mov    $0xffffffea,%r13d
  20:	e9 ad fa ff ff       	jmp    0xfffffffffffffad2
  25:	e8 83 95 9c fd       	call   0xfffffffffd9c95ad
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 72 ff ff ff       	jmp    0xffffffffffffffa3
  31:	e8 77 95 9c fd       	call   0xfffffffffd9c95ad
  36:	e8 62 72 12 00       	call   0x12729d
  3b:	31 ff                	xor    %edi,%edi
  3d:	89 c3                	mov    %eax,%ebx
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 72 ff ff ff       	jmp    0xffffffffffffff79
   7:	e8 77 95 9c fd       	call   0xfffffffffd9c9583
   c:	e8 62 72 12 00       	call   0x127273
  11:	31 ff                	xor    %edi,%edi
  13:	89 c3                	mov    %eax,%ebx
  15:	89                   	.byte 0x89
[   81.876952][  T849] RSP: 0018:ffffc9000258fe30 EFLAGS: 00010246
[   81.877269][  T849] RAX: 0000000000000000 RBX: ffffffffa5f74260 RCX: 0000000000000000
[   81.877658][  T849] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   81.878082][  T849] RBP: ffff88819ba2db40 R08: 0000000000000000 R09: 0000000000000000
[   81.878476][  T849] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa5f74270
[   81.878891][  T849] R13: 00000000ffffff9f R14: 0000000000000001 R15: ffff8881be116040
[   81.879282][  T849] FS:  000000002fd71880(0000) GS:ffff8883a4800000(0000) knlGS:0000000000000000
[   81.879717][  T849] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.880065][  T849] CR2: 0000000030013f60 CR3: 00000001be0e0000 CR4: 00000000000406b0
[   81.880459][  T849] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   81.880901][  T849] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   81.881295][  T849] Call Trace:
[   81.881474][  T849]  <TASK>
[ 81.881634][ T849] ? __sock_create (net/socket.c:1581 (discriminator 1)) 
[ 81.881908][ T849] ? __warn (kernel/panic.c:748) 
[ 81.882130][ T849] ? __sock_create (net/socket.c:1581 (discriminator 1)) 
[ 81.882395][ T849] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 81.882655][ T849] ? handle_bug (arch/x86/kernel/traps.c:285) 
[ 81.882910][ T849] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1)) 
[ 81.883164][ T849] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 81.883446][ T849] ? __sock_create (net/socket.c:1581 (discriminator 1)) 
[ 81.883725][ T849] __sys_socket (net/socket.c:1670 net/socket.c:1716) 
[ 81.883995][ T849] ? update_socket_protocol+0x20/0x20 
[ 81.884432][ T849] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
[ 81.885031][ T849] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:57 kernel/trace/trace_irqsoff.c:613) 
[ 81.885310][ T849] __ia32_sys_socket (net/socket.c:1728) 
[ 81.885863][ T849] do_int80_emulation (arch/x86/entry/common.c:165 arch/x86/entry/common.c:253) 
[ 81.886413][ T849] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[   81.886672][  T849] RIP: 0033:0x407ebc
[ 81.886895][ T849] Code: 83 c0 01 41 89 80 40 30 00 00 8b 44 24 04 4c 89 d1 48 8b 54 24 08 4c 89 de 4c 89 e7 55 41 50 41 51 41 52 41 53 4c 89 cd cd 80 <41> 5b 41 5a 41 59 41 58 5d 48 3d 7a ff ff ff 49 89 c4 0f 87 5c 01
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
[   81.887825][  T849] RSP: 002b:00007ffe58347588 EFLAGS: 00000202 ORIG_RAX: 0000000000000167
[   81.888240][  T849] RAX: ffffffffffffffda RBX: 000000000000002b RCX: 0000000000080801
[   81.888635][  T849] RDX: 0000000000000001 RSI: 000000000000090f RDI: ffffffffffffffff
[   81.889192][  T849] RBP: fffffffffffffffc R08: 00007f033ef64000 R09: fffffffffffffffc
[   81.890059][  T849] R10: 0000000000080801 R11: 000000000000090f R12: ffffffffffffffff
[   81.890776][  T849] R13: 00007f033ec4a058 R14: 000000002fd71850 R15: 00007f033ec4a000
[   81.891191][  T849]  </TASK>
[   81.891352][  T849] irq event stamp: 158255
[ 81.891568][ T849] hardirqs last enabled at (158263): __up_console_sem (kernel/printk/printk.c:344 (discriminator 1)) 
[ 81.892047][ T849] hardirqs last disabled at (158272): __up_console_sem (kernel/printk/printk.c:342 (discriminator 1)) 
[ 81.892515][ T849] softirqs last enabled at (157948): handle_softirqs (kernel/softirq.c:401 kernel/softirq.c:582) 
[ 81.893166][ T849] softirqs last disabled at (157939): irq_exit_rcu (kernel/softirq.c:589 kernel/softirq.c:428 kernel/softirq.c:637 kernel/softirq.c:649) 
[   81.894135][  T849] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241023/202410231427.633734b3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


