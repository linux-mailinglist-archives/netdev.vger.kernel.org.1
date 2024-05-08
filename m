Return-Path: <netdev+bounces-94641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BD88C0099
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F19B1F22981
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDC8126F32;
	Wed,  8 May 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdu2NKzE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7986ADB
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180817; cv=fail; b=Egdz0vVEK9WVB6PGO/VjFBhBg4zOfjYTGII1tB10187Z976Gn18oZJxeBQx85DmnYm8kiNWBi5LD7TPNjR3HPoagzVtEhvo8Pld+qby4CZzsx5Y+/LItGNQQXc5OfHXX17rF9OzHDFTiT/IhGDk/WMeCdRTs3tiixRzoilMIm54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180817; c=relaxed/simple;
	bh=C0VkBVwhtMxXoh9UGDk+F++gv/YG7uDTPJtOYnT9yy4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AU4jGgpST9NeFpfDFelziqT2uog9co4GqNHdwH+OkZC+uh6rWADA+lt0BfpUt/KTb6Etx1btIRrYK2WdbjqwMo/K+7zkuDn3SvHKVGahCSqCP3SOXG3QpJNy6E4HcwYfuB+ReuxnI9j8Q0gBqlgCIMyNy4BX9JxdCW6HrjkUha8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdu2NKzE; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715180817; x=1746716817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C0VkBVwhtMxXoh9UGDk+F++gv/YG7uDTPJtOYnT9yy4=;
  b=gdu2NKzEsyWGwrnY58iz7izZmhvsRS+HlfdN7lrUCuXe5SQa3lXhCvrA
   dwpj5zJtlR7ma0pFlSTEkxPnYudR9nqHlWSjPVv9tui7SiqHhPAA2FalN
   Efs0k9ByCV08RwbqyjCr+ridXaTZbFmDQq5+MupDzRSIiHgKxHmRlvlgh
   on9jStcJIOCNckuPLayPEA88QhPsz9aqhVRZeJivuJb3DjysDYEfIBl4s
   Q5S9jk42xCOaGD47rbVYMj+oOGXIh7yzS5IEkAQeAPCH4zDJsKGRt+fGs
   lKaADOF3dIlFMbNsbCF6x7swx2X7zOUY+3l0M6xJeiS/k1BtZqD5jiwzf
   A==;
X-CSE-ConnectionGUID: SwIjHadHTlaxe70ShzpmLQ==
X-CSE-MsgGUID: aacbB3FHSGSH5Tt7xiFwfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="10884497"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10884497"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:06:55 -0700
X-CSE-ConnectionGUID: mqAaVLhkTJewZzRjS76W/A==
X-CSE-MsgGUID: 88/J2UseQMqJ96MofXusIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29011354"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 08:06:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 08:06:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 08:06:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 08:06:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 08:06:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVoA46OVomn196johycAjXzTWYunFflG/qLC1drOQ12ug53ZDTOrNvyqmnTbQacJR1eteGWpR7KB8RNTreJSrkasE17WEPsDgpYkrWC6QHRcISWFy8Zhme6aWhDCZwpDz5e0bCbml4IK09p7m21Mc/v00roK/edv1ts1Z+w29cjySLfHKhnNuxsMlWzvZPJDAWOYFTL54r+xd9xWsbJNw2KuYFAzq1ZQdtmXwv6ruDZAZtBm69ZwWRNUEGEvM6htI2wgWV3xLYNgeCxV0qSQCyp+W8TwIxOvnWXzLX5L8cohFMeEGquZU6GBGRhlasS54KeSsnfCl51zdi7DGqo9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxDh6LsHVm6Z65BM4+72aj/hKmkrzw6Q0fGWSNCM9zM=;
 b=Qc/HHI8nbREU4g9sZKTxMIcWqZ2rs1Nwe+CKuqInu/1plQVUg+IaZA4GIpv2lbvYhDFI2yIPD8Rnb6UcyIE/AMBiZXbZ7YzgGPOrYgoMJ0leyRL0x2bv50J+uHVnFVyCTOLDh9S7vs4OfYfACbbuUi4bXflLxouV+5If+tF+LDzwVUq+5H8xs6XeDjMULvR3lC2fQOcpy8eYUaiBgC+V/Cp3t8JDPJfyjBQV8zYC0pTR2im0ImKb48g8O/yY4k5v5Y7KZypZinrHhVl2035pTCA94dQKzrehwyTL1EPKwnqTA26dG8GQ18PYE3pPNvqDHX2QnGcQvxZoUzsF5+Jv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by BL3PR11MB6505.namprd11.prod.outlook.com (2603:10b6:208:38c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 15:06:51 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 15:06:50 +0000
Date: Wed, 8 May 2024 17:06:42 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] ipv6: prevent NULL dereference in ip6_output()
Message-ID: <ZjuVAnjhYNomU/4J@lzaremba-mobl.ger.corp.intel.com>
References: <20240507161842.773961-1-edumazet@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240507161842.773961-1-edumazet@google.com>
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|BL3PR11MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: 767ec2e9-df10-4666-53d0-08dc6f707d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9M/lHNPltZedGaqOFojTF6eoy5PlEKL71+T76CLyCWuTjM9rJR3ou96tCGPY?=
 =?us-ascii?Q?ZYeAj5qVPGtEMfjt5a5e2cmMsFZqi2QfaWoMt8M5VfGowT7ZJsT/H20ihsKu?=
 =?us-ascii?Q?FlTDi6799IlpMNYh6NqsHPZYECsDm1smega9FlN6Tq4vE2GA1g6lI63LNTqH?=
 =?us-ascii?Q?HzFNz0FOjwXVfeNOvfsPi9a+Xd7lFlwaWsEUqvj5btXy0d24XS/0X2RE0fOl?=
 =?us-ascii?Q?D9reGzmTgHTewBfkh/FuB540CjWCTkitUqA7gesRjKDQxgEixg4yqOaI4Sas?=
 =?us-ascii?Q?CKkF50CrfXM562zA588h1rR9aptCoZLpoHtc9bBAyBILvyHBo18DM2l4at3c?=
 =?us-ascii?Q?fwIT2t9QSAljeD/u1UrXm+en4XWuB91RmIWaJc5ZuAIisF2ohCit/2DlhffE?=
 =?us-ascii?Q?JeIyShE6vlaS3gavke1g9efruPnH2nn/tOU7PvrOJuOY2DjqMF5vG7zGgNdp?=
 =?us-ascii?Q?fD0cCOXYUYJjZ6iq8ecS+JZ3iCZDC6vfe70L8nEcJbZt+1uVx+aNgle84j6z?=
 =?us-ascii?Q?CZ3N7dS7jKeSALBr5sbQ7bSoPzaak4l2OxgX57iiOq+y3FhUBjjZFUUs0lHS?=
 =?us-ascii?Q?QbwjtZeNXMTSsdGLYrWrgq7s8cmC+4ZLkiF3+Inp8pctDVfsU6AZRf5551/Z?=
 =?us-ascii?Q?Wxm3V6SRH9j2ePLNHFvUA8g0WaFYgieUlIUeII+kkkeLz6dzrB+qR30nHstr?=
 =?us-ascii?Q?HlXFRYT91NnxM1cXA2bGm+0k1nzQSY6lPuZJmbOqMxgLasFSZthDFFPfh92H?=
 =?us-ascii?Q?WqNAEL9DFkzPGHkQyXba4HgttfkBDfS8F8SNwMxHcWPo0MC6veZN4SINc+HF?=
 =?us-ascii?Q?LKGBBnUaFsQxkehMFQQZ3+hKAEax7C/shCTfzgNAa8u86sW+qJRnmSjosLyP?=
 =?us-ascii?Q?qvUGn2B9+rbeppiaYH0A0YE5UF6hMxQ1gCC1MvVSuOvRK+wvN8b7Q7s8yLQW?=
 =?us-ascii?Q?M5IrcQ2qXJ6vuHpu1e+SzK4Q9XgaPkGCkTjWagn2uCuhidMmn33wyHXTkv9R?=
 =?us-ascii?Q?rCSNs9ryLapX+Dn3fg3SmI/Cb2l2PHED8J+xc7MxOmnQwdiqugsVeImIMsay?=
 =?us-ascii?Q?t2ESKVBPJDvKlaOSVSQpyJiBcQaptohR9og3KtDWSY9fiQMjleLJz3R7kT3Q?=
 =?us-ascii?Q?hdZfTHX5R43uNYfq8bLGyBCjCuVjarfOUNEnk/JmO6Vae7WTrGbb1I1f64DG?=
 =?us-ascii?Q?2elKq/YM21YRoZcUNhLXONPldcBuAsNCnNfHxVbSgemVZwinYN7KKBYcwVwB?=
 =?us-ascii?Q?2kbITqyutVD1DlGAqWGteMZFGz1wtzRP6sekNqZ4GA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmAIq2YTnFmP5gtHhN0AkRlxjwzBy6BqqDLWXiSqv90YLYY6QQuJLzC7xKTH?=
 =?us-ascii?Q?7TtKHUKaGdeTRxXKfTF9Yk5EeSzZ+jeGm1dCGM05t7Pemjb/eB8ytwJ9wrNk?=
 =?us-ascii?Q?ALgdbdqytlkSSIIRtWEUSbNnXeNXhpT2mCv2tTpjP9U/qg31t70XsVKUbgSq?=
 =?us-ascii?Q?zmRwmbDzbm3FMvOGXEaCNfE7THmHNEGMpiQGfDpp3WvnsYYdNS1HHZ2TVn/A?=
 =?us-ascii?Q?Z6rwg2W0i0Dliy1svoSgRWgdN9dFNtfvnhoUWdhvnqhLDpaDtCaHsaOn7OiU?=
 =?us-ascii?Q?RIBmNtB31fsvByuRiIyu4WYZENDzQUapxfTdmIegQqApSMti2yT72phHrIcH?=
 =?us-ascii?Q?2y3RY2Ll1dcOcA6Do4Da7gQItp1rCUeF80NRzweJ2Ir7rrkOIrCvw9+p5O8X?=
 =?us-ascii?Q?UfGDOBSHDcwTGNY98VkrXiW/LC+88/m3s8FAo6qGRAyljiE1UNvV80GUHe0z?=
 =?us-ascii?Q?1UaX3byxQmQ3Ok2c+ASzVpmq7URjweIJS9sf1e9X1FgNnTgOGjPSTuhUoslu?=
 =?us-ascii?Q?s8lyW56IJsxGngKUTc0rRTwhlyuQ4dAOtlEw8/TOpJR0fk9qdsyJyibi6WWx?=
 =?us-ascii?Q?HjKoHmak7yEo3Dzt4qIvw8KFsIFwmnNAWIJTjyAM0aSj+Ijx/F+NqKnyvmjM?=
 =?us-ascii?Q?9/kxZn9fMGswzjU19Bv4IuK0QjDWPw8dYEYyKkmzNM1R9gkwyq9nQ3rIDOHs?=
 =?us-ascii?Q?H9FVYwelF7nHHOzLGyQCgatWXpQR+SSArVWgEWHlxzrcJspf6NNlx27MxL4z?=
 =?us-ascii?Q?PJXi4UKAzYOj7vBsMqKm67MnC4AfIsKJFqKq4aJcfvK1wbUz0+fV6Rh7E1HM?=
 =?us-ascii?Q?EGpeIesY05kmpmBcVqMRNz3szdovyZ8c8KHBnuNyAThEy4gs3sRU1NYyyaUG?=
 =?us-ascii?Q?7Ozd2aR82+22WG73G+CSQ5dRCUmNIGkUJsdSbRBYqFobhsqVY007/G03mUNx?=
 =?us-ascii?Q?aQxF5EXCQxJ0qB3B3c1EQ3DDEV3mSQd5Q0tqmVPVYi2tcgz/JO/MpWLgnV7D?=
 =?us-ascii?Q?bUaxnFnfdrvkOTyp2VSHDzMAs4ifUtTzFwT2u9SWaj0ee6i1A+KCo/NN5Jxl?=
 =?us-ascii?Q?Hhv+GiLdaVsL3NJwc561AGNFh/UTu/5eUHtCPKRQ/i5jbeJ1n4oKACCY86+r?=
 =?us-ascii?Q?SI3URuUg9A3oifZs/vcLwja4wwbn4m4i/SuRGYmk1pa0w2oWb9bSGk9TPDPS?=
 =?us-ascii?Q?J9c8UsDotEeclKwCeasKC9EFMV1r8Lo2YAMewV1ZuV4mnZxIy4PDpQvoKSTv?=
 =?us-ascii?Q?926bnyxdGLlM6PlWm+DuCFBJnS6Tt6d2bN7n1Td4jBp4Ni1NtgtlZDRLoFFu?=
 =?us-ascii?Q?eSwx3ArdwU0L1V/lwIZkrKJ5iUk55fwPpk/PMuT5hgt0vTlvMLOkmQlUCcCh?=
 =?us-ascii?Q?CNLB8QnGMRWfZmVcmXHJgBAdiMW7Mc+0Kk0+Q40VJ465SpG5S/i7Eb2EQUoZ?=
 =?us-ascii?Q?4grdzOJFU4FFDhocgQnrFqjDGoQLHq0qNGUdRowE8G0Tp+sc4S/vnwJ1qQ7F?=
 =?us-ascii?Q?t+P+zGZYR+Il4cgTD9mZBa2r+tXrxyLcJ7X3oaEDOSsTcEe097ysvKanvX90?=
 =?us-ascii?Q?FPFtOhSFl9Z8bWWT7T9RZCN8/FRq4G/GZhG4A8IocDwY0xEBSWRKBLxNMvBp?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 767ec2e9-df10-4666-53d0-08dc6f707d33
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:06:50.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /akoWTU57K791e34My3N3nskIGhHis6rbmaIwtpCvZCEPUh1T3colSm8w4oqYHR5AJb0BnsAC0IJ34obTB7QMMPDyqSA6bWT0Nq6HBmNbW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6505
X-OriginatorOrg: intel.com

On Tue, May 07, 2024 at 04:18:42PM +0000, Eric Dumazet wrote:
> According to syzbot, there is a chance that ip6_dst_idev()
> returns NULL in ip6_output(). Most places in IPv6 stack
> deal with a NULL idev just fine, but not here.
> 
> syzbot reported:
> 
> general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
> CPU: 0 PID: 9775 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller-00157-g6a30653b604a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>  RIP: 0010:ip6_output+0x231/0x3f0 net/ipv6/ip6_output.c:237
> Code: 3c 1e 00 49 89 df 74 08 4c 89 ef e8 19 58 db f7 48 8b 44 24 20 49 89 45 00 49 89 c5 48 8d 9d e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 4c 8b 74 24 28 0f 85 61 01 00 00 8b 1b 31 ff
> RSP: 0018:ffffc9000927f0d8 EFLAGS: 00010202
> RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000040000
> RDX: ffffc900131f9000 RSI: 0000000000004f47 RDI: 0000000000004f48
> RBP: 0000000000000000 R08: ffffffff8a1f0b9a R09: 1ffffffff1f51fad
> R10: dffffc0000000000 R11: fffffbfff1f51fae R12: ffff8880293ec8c0
> R13: ffff88805d7fc000 R14: 1ffff1100527d91a R15: dffffc0000000000
> FS:  00007f135c6856c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000080 CR3: 0000000064096000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   NF_HOOK include/linux/netfilter.h:314 [inline]
>   ip6_xmit+0xefe/0x17f0 net/ipv6/ip6_output.c:358
>   sctp_v6_xmit+0x9f2/0x13f0 net/sctp/ipv6.c:248
>   sctp_packet_transmit+0x26ad/0x2ca0 net/sctp/output.c:653
>   sctp_packet_singleton+0x22c/0x320 net/sctp/outqueue.c:783
>   sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
>   sctp_outq_flush+0x6d5/0x3e20 net/sctp/outqueue.c:1212
>   sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
>   sctp_do_sm+0x59cc/0x60c0 net/sctp/sm_sideeffect.c:1169
>   sctp_primitive_ASSOCIATE+0x95/0xc0 net/sctp/primitive.c:73
>   __sctp_connect+0x9cd/0xe30 net/sctp/socket.c:1234
>   sctp_connect net/sctp/socket.c:4819 [inline]
>   sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
>   __sys_connect_file net/socket.c:2048 [inline]
>   __sys_connect+0x2df/0x310 net/socket.c:2065
>   __do_sys_connect net/socket.c:2075 [inline]
>   __se_sys_connect net/socket.c:2072 [inline]
>   __x64_sys_connect+0x7a/0x90 net/socket.c:2072
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 778d80be5269 ("ipv6: Add disable_ipv6 sysctl to disable IPv6 operaion on specific interface.")
> Reported-by: syzbot <syzkaller@googlegroups.com>

'Closes:' tag would be nice.

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/ip6_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index b9dd3a66e4236fbf67af75c5f98c921b38c18bf6..8f67a43843bbf856ac706fc7cbb28cc08ea0e6d0 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -234,7 +234,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	skb->protocol = htons(ETH_P_IPV6);
>  	skb->dev = dev;
>  
> -	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
> +	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
>  		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
>  		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
>  		return 0;
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 
> 

