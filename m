Return-Path: <netdev+bounces-129165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382697E0B6
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05ADA1F211D9
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BF13174B;
	Sun, 22 Sep 2024 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOFIcdRR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DEE6F2F7;
	Sun, 22 Sep 2024 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726997237; cv=fail; b=UcMOWOBNo+Fqssv144i2N9xMZb46a90TVNn6zdjmQKKHqpm2fX34gt6WuMb34xBz3lnhhraZOeaT7/RsTP050NO2EIBoCErGCXKzQda4d11+7Uj4htxm+1qw4R0d5NwcVBmL3JCFhIoUuARTDt+Ugxsb+0r37ej2kv8meHbREms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726997237; c=relaxed/simple;
	bh=SVTwwK4SwCBKZRuswX7/JoWvoFROZNL84blzBTbpWjo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JvpuVzdCvapfhT1d8BqtBQyjrjAuGZQcVGCHQvvUT3jwZSJV4n289OzZ21euQo7PHnIlP4E1wWpkmxW5n01oKwRAAzp+IiDztJIlnYF1l3DMJHf+TUf8poXQcOGqeuTlZ+hIN+xwFCarFaLR6TDHvcbAYCXhT9ICEO7fTpCJuMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOFIcdRR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726997236; x=1758533236;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=SVTwwK4SwCBKZRuswX7/JoWvoFROZNL84blzBTbpWjo=;
  b=NOFIcdRRh7mMYe4JurjVLLPxjYyapedQvTWMU6KSKmX1cUCMGbCXqHl7
   piB3sm1NRjN+srLV5Ei44X+2IKYnB+TUCDRfs3NmRzhQ95t3ce92GP5iF
   itkItBqlFH92bEQZWn770WwjMUQ/Rm/Q89iZr7FUNsfKHyEnd9d3ChE16
   sBKQlIqw68NInpzG95vJeNWnZ7SdWEJys4pSg7SVPD52Drta9jZLf7rlS
   bHoCvqP1stV1DkBwGpSBdp9oz4YIos5/O2RE96r9r/jz4Dmff/8Lp1Gzt
   8KA+TMXEXqMuI11C6YG1qq19QFZ2+1KfX93skYUGU/Ehkw/O1TyNk1uB9
   w==;
X-CSE-ConnectionGUID: CXomuxz2R4qbijb8oEfYzQ==
X-CSE-MsgGUID: 9C/c6xIeSyiTE21jtRLhRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="48482023"
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="48482023"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 02:27:15 -0700
X-CSE-ConnectionGUID: ZkcIsomgRoKnLtwqBHQOug==
X-CSE-MsgGUID: aiReq19ETDCOAOgCsdBuFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,249,1719903600"; 
   d="scan'208";a="75546162"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2024 02:27:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 02:27:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 02:27:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 22 Sep 2024 02:27:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 22 Sep 2024 02:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRuHMeF1objtWUpTyQOr94LRobi3YEyMu1JjI4oOS/GlrBo6/+peInm+rffNc1lfR2xnmXPWcyUGUjaStPcBdpSY2YdnSpyxCjVev6VIIV07o8EYr45Kd54BrH4HwCmX5u7EbFpsAm5NbzDcwGX17TS+7igDqh5s4G2UYwfjuM0p7jrVWYDz30SZPrMvlEvGgAtMNHmZI+tQm3QqoB30OuVJIxGJguTR75ky5EE0enh1LHKS8e6YVNA2+vhCDBLyEsQG0C431dy9dxhr1bQ1fwqq9dRcFEkKmpoMY8wmmtMSv/LtyHMEdCXoaei3jbF24Khth+gWrK5ll2GrAgsctg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbapDU5raQ9tKqdc83rS29EmYjMlCe5glu8yr0Zj5QA=;
 b=Fu48D/54zptR1+2/KfJmXZxGRbZ8tIrlFO5rZ7irZA91LRKf4B8d0TSxFK7RkJGx7MgslsU9QjbdNHJEHC1LDAAiVPBEnBx3+Rar3+MvE/r7D9/IytnaIX2h2ZA8UkZCr3KMPt7w7tBBiH01VcdI0KfBrLvURoJm8wjYRIO9cj59zRX2TZNHJXySElMlb0DLLLh5pjVjGnRHFFTEjueNMSfTJarHZLsQ2eTsXQrCsAqd5TVJ4JNUz7tPTM45ZUfL12oQWdz8dbNvNOciaP96+tEInvudXvomgaMjg/CKBGEjNLAIZ2th/HZy3RnuZQbpal0FW68YPImPRxwxcftdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Sun, 22 Sep
 2024 09:27:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Sun, 22 Sep 2024
 09:27:10 +0000
Date: Sun, 22 Sep 2024 17:26:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: AnantaSrikar <srikarananta01@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>,
	<alibuda@linux.alibaba.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<dust.li@linux.alibaba.com>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <pabeni@redhat.com>,
	<schnelle@linux.ibm.com>, <srikarananta01@gmail.com>,
	<syzkaller-bugs@googlegroups.com>, <wenjia@linux.ibm.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] net/ipv4: Fix circular deadlock in do_ip_setsockop
Message-ID: <202409221753.e29d62c8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240917235027.218692-2-srikarananta01@gmail.com>
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c839843-70db-4417-53fe-08dcdae8bc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YhRahlJoCcIAL1m8vtNwdFXYjUk3qGrDlOqwzM68IJu/WzxNcrNU9VfRPv1f?=
 =?us-ascii?Q?ws3Hw0/lSuTzAgQI+4hvNaRYPH2ZpYorjzGaJYKwY807DiX/td5AfoV8Uqna?=
 =?us-ascii?Q?hcIrsAgsT5sLDClBeeUd23ZjufCKkLFd1Ocy5n+DDDE3GGUPcq4VOnkLCANi?=
 =?us-ascii?Q?wo1HFXPI7Ec6mNwkb9ZXdc01WRk0TWckR1nwX+o5z90TPD235g6d1aTxPvVB?=
 =?us-ascii?Q?DBlHy94Pke7vhP4qFHGSsSsvMujosLcJBncS1cGI2uYbH3D+t6WiMmybX/xi?=
 =?us-ascii?Q?Q5qkC3c6tmUQYPENqzRIuCTWHCXVOaWLsJUwwoU0m22jmY6gUUV1vEKyg1wv?=
 =?us-ascii?Q?2mlylziQKnLPEDN6FgfFTEdAxF8DH65laI/RKhkVGrPvc46brL7qYR7Y7/Tg?=
 =?us-ascii?Q?huiP9qbhOIogjPkFZtr362iDvgDTXHup9yxL3Lx7mwTWIZ7rjIrlTuL2VQfk?=
 =?us-ascii?Q?jJKq9MMMI3nHkkG1//whWXWfzJPt1Hsbl8C7LrlnQ2UuX7N7U3cwAwYRZhDV?=
 =?us-ascii?Q?5If3VpLzDItGgU6pGtBqSlebRZaf/UUXzXV7J9U8AAW7rZih7fID1h5Grg08?=
 =?us-ascii?Q?xQcP2ptvW4excFxHp69gAUFk1d+2nR5e068d0jKyFAWpBH/jbEwHa7zerlpW?=
 =?us-ascii?Q?k76GJ6bI1XoeYM2syLXanKeeXiNorLNJ/nLKQnbiTTdhtJvoAwiXyb24Tghq?=
 =?us-ascii?Q?UUU8euJUkj9wEjC6GCH7qHxMW8g4UZso+43N9xPUM5633vgKM/iKUMkMw4nJ?=
 =?us-ascii?Q?jvkAV4ktKllMdRObE0JgpZEkXKwfkEfXxWRo25c+Z+93WVgSXYmluafkpbXQ?=
 =?us-ascii?Q?6DqlxAA5fpGCsMsZt0P4aWaKh/EKg7tjv9DHBObnG6CKCgk55/hk8jlLtx1B?=
 =?us-ascii?Q?/N0MdO1ZiQ1rNmQ5jz0nDHKpHRrcAJ0G/bH60zifZ4uxAYcrS44zKLujckHE?=
 =?us-ascii?Q?kqHXMWtL7HP2mWNvQPsaQQeSIaSpQdpEKfqdgrWwLNeuriCY9WkQFdjPscRR?=
 =?us-ascii?Q?DDrUtF1ijEdYs+f5qv9vKdIhGhSPD6tJIo0d1v/07Qv8T+9wiMlLxN+voozH?=
 =?us-ascii?Q?i2Fame031j66h/rDzDKZHCGRxN1jAiEC6+/k5fxAIUpf+DXjFuefCtv/sIPi?=
 =?us-ascii?Q?UQYsx2MCbvqSvs1Gp4+Ve7lv5GIDMTpR2Vj0OaCzqCSQkmitAKCuHAb++t4C?=
 =?us-ascii?Q?OLirjM03Ms+2siUNetU1gs3MYunjwxT6LwegQPzLApp8gXRlDSRd4VV495DK?=
 =?us-ascii?Q?oZApwA7b6CcLCtFaG+S78Aac2OVA+BkXi89w9polXOTWQCgFzl5OHmsLmKdn?=
 =?us-ascii?Q?JObisTaSl2hX+XbLkU4eg9oJ4AymGuL23E9MXLgNYlbX1+aFvd3JlyrTxbEV?=
 =?us-ascii?Q?j7M6XBU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?akYAj7XDW25jriEF4Ce/PGnrXOXXeyrososKZbn2aKf206UT/tAfsodrb6Vm?=
 =?us-ascii?Q?wpRs28ak1f3o6Dj4IGnR/fNI68/jCfdh+wY90MH5qEXV8v7PXCbmre07f7Pg?=
 =?us-ascii?Q?Pp+lplMJIoGUjhngdue+ADixjYjON3iHbiCdN3DayZ79bCpdZnwvygpSNF3D?=
 =?us-ascii?Q?Wk/+mdtHOpOIVa4mUi6EpdayKdbIukOF0dEbTFldGFZCnb7SRMCGtx8uCi5W?=
 =?us-ascii?Q?JaCPrHrTCsYH6TUuE0AmezYj3PTSm3IYLmgXdoejKaabqe4fvsGWZ1bNS/ca?=
 =?us-ascii?Q?TI18aRSq3XD+b3ign7oDnmKqyZP8A8TAndAt0PZZ78ExOSltT+eN6xhA+ezE?=
 =?us-ascii?Q?JQO6QcYHHPqCqMkeVRMwl+zdfkQ5G6eYGHjc5SiaJjKwHqE57Tc1Ck7HWXdP?=
 =?us-ascii?Q?0ii6bZe7il3CRdlcsqdj/aNZn+IsjncrTzzWXWTgVhQfKvV6OLcae6j/XgqP?=
 =?us-ascii?Q?C/dWkNdC9G/LRO6uSsb54X8vAK245A6gQNEEjwL1GNliKVtQCmmNSK4fX1ld?=
 =?us-ascii?Q?QjOsh5plZaMolOC3XToefTgoV9SvzcIHFajYRD8S9hBlQ5S9gX0Yjle6+8r5?=
 =?us-ascii?Q?+ZEuPoaVedGOikxhPOpUH65sZtlEjcrkYVtT7mMRMoTtE75eYHiUI+Ft86Px?=
 =?us-ascii?Q?TKJwkhZ52gC5XU6RlhMUes9745fwM9wmjKeXjaKb0dW0T5uQqE2rJwOpsHcZ?=
 =?us-ascii?Q?Lx62canweP/J7bG12emkK3E+eWJv0D/lOP9YkhMfO/7j21We+Frr/aIkpGjB?=
 =?us-ascii?Q?1QC35St7CCnUEiZkF3rv3IouVlNuuitnUZVE5+vZzOfTsBz86CZBrIC8KsvH?=
 =?us-ascii?Q?XQusmcCkPenYaI0JkXtEhk+CJblqWFkpx/i7A9v5kDMFSPHAXZkbOjv0u5MY?=
 =?us-ascii?Q?toX2r5NiJCP/V62C78v+eBDl+0aVd04gfZ6CcOiFx/+g+xNB4yXOcN4wm4m0?=
 =?us-ascii?Q?AKTsQd06luXrndfeVeAbkJwN9Js4c5M9mQi4VVfOPyRknHSaFoD1PzbDKNzB?=
 =?us-ascii?Q?3eDyRjbNVgXIxrQVvrEt6BG9eAWCJwicIe2ycIgJAjsInhOax1qisdkW6UwZ?=
 =?us-ascii?Q?piyD/xO1ERPxyDAYeiKz6biLKZbGjGeuYWPvTe9SmW2zBveAyvuhV8JqMx2a?=
 =?us-ascii?Q?N79yt3/WtYs0LWWMQL3gM9hH9mUIQWSv2EPvzBrBjRYAgY4t6Pyk5L/9e1JH?=
 =?us-ascii?Q?jQWJDRzCovfdhm0OO0K5lvVpfuLJG7VTB8qxbB4y7GepGVp83gY8vzEDsR+U?=
 =?us-ascii?Q?UVSncqpITLskqTiFSs4qzr+loarRPjdd/ytjHl+D3JQJD1AB1WYe+da1WfVp?=
 =?us-ascii?Q?wrkoMFEoUAJURpITuzId4imn73kHL7vx64Fi+pGik+HfrFz6Snz5YR0aKtL0?=
 =?us-ascii?Q?U5hbIOb219i63Y917H/YZDF0EyatY5GwbNs7LoHZQWsuF46mYf9UAfF53Z7W?=
 =?us-ascii?Q?t0RXN+8BOJopfBhcqGFoo4ccS2y3U3V/2Hxuv3unfObHsTQY5wtQz8Ol/2oZ?=
 =?us-ascii?Q?2wvp179sJZqMDONqTiIMThFDRGR8dsza2Dxd3QLvvGBKG2MtmsvvPG9TyT6M?=
 =?us-ascii?Q?VQ5DL3Sn47gthIhgu/EK71XtSdoFSBWjsYDKJSC7+ZP+0NwGADu4Eit6x0J0?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c839843-70db-4417-53fe-08dcdae8bc1b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 09:27:10.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es8mWsXCIg3T5EQjEKZqoeqDyN+8pxb3anBIvLzVA5TcD4TiVleo7hqo0HjEZS9DvjJdZBhGWTqrIH04AVZK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6532
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 1b1e90e04f3485bbd37b605a863b16f42fa9566c ("[PATCH] net/ipv4: Fix circular deadlock in do_ip_setsockop")
url: https://github.com/intel-lab-lkp/linux/commits/AnantaSrikar/net-ipv4-Fix-circular-deadlock-in-do_ip_setsockop/20240918-075223
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 9410645520e9b820069761f3450ef6661418e279
patch link: https://lore.kernel.org/all/20240917235027.218692-2-srikarananta01@gmail.com/
patch subject: [PATCH] net/ipv4: Fix circular deadlock in do_ip_setsockop

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409221753.e29d62c8-lkp@intel.com


[  102.908754][T20485] WARNING: possible circular locking dependency detected
[  102.909639][T20485] 6.11.0-01459-g1b1e90e04f34 #1 Not tainted
[  102.910197][T20485] ------------------------------------------------------
[  102.910822][T20485] trinity-c2/20485 is trying to acquire lock:
[102.911369][T20485] c2ab6a78 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock (net/core/rtnetlink.c:80) 
[  102.912029][T20485]
[  102.912029][T20485] but task is already holding lock:
[102.912663][T20485] edce5dd8 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sockopt_lock_sock (include/net/sock.h:? net/core/sock.c:1125) 
[  102.913455][T20485]
[  102.913455][T20485] which lock already depends on the new lock.
[  102.913455][T20485]
[  102.914386][T20485]
[  102.914386][T20485] the existing dependency chain (in reverse order) is:
[  102.915187][T20485]
[  102.915187][T20485] -> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
[102.915862][T20485] lock_sock_nested (net/core/sock.c:3611) 
[102.916319][T20485] sockopt_lock_sock (include/net/sock.h:? net/core/sock.c:1125) 
[102.916778][T20485] do_ipv6_setsockopt (net/ipv6/ipv6_sockglue.c:?) 
[102.917283][T20485] ipv6_setsockopt (net/ipv6/ipv6_sockglue.c:?) 
[102.917740][T20485] udpv6_setsockopt (net/ipv6/udp.c:1702) 
[102.918226][T20485] sock_common_setsockopt (net/core/sock.c:3803) 
[102.918766][T20485] __sys_setsockopt (net/socket.c:? net/socket.c:2353) 
[102.919224][T20485] __ia32_sys_socketcall (net/socket.c:?) 
[102.919727][T20485] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-053-20240920/./arch/x86/include/generated/asm/syscalls_32.h:?) 
[102.920298][T20485] __do_fast_syscall_32 (arch/x86/entry/common.c:?) 
[102.920778][T20485] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[102.921263][T20485] do_SYSENTER_32 (arch/x86/entry/common.c:449) 
[102.921720][T20485] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[  102.922222][T20485]
[  102.922222][T20485] -> #0 (rtnl_mutex){+.+.}-{3:3}:
[102.922871][T20485] __lock_acquire (kernel/locking/lockdep.c:?) 
[102.923356][T20485] lock_acquire (kernel/locking/lockdep.c:5759) 
[102.923817][T20485] __mutex_lock_common (kernel/locking/mutex.c:608) 
[102.924293][T20485] mutex_lock_nested (kernel/locking/mutex.c:752 kernel/locking/mutex.c:804) 
[102.924748][T20485] rtnl_lock (net/core/rtnetlink.c:80) 
[102.925154][T20485] do_ip_setsockopt (net/ipv4/ip_sockglue.c:1082) 
[102.925613][T20485] ip_setsockopt (net/ipv4/ip_sockglue.c:1419) 
[102.926060][T20485] ipv6_setsockopt (net/ipv6/ipv6_sockglue.c:?) 
[102.926522][T20485] tcp_setsockopt (net/ipv4/tcp.c:?) 
[102.926976][T20485] sock_common_setsockopt (net/core/sock.c:3803) 
[102.927459][T20485] __sys_setsockopt (net/socket.c:? net/socket.c:2353) 
[102.927910][T20485] __ia32_sys_setsockopt (net/socket.c:2362 net/socket.c:2359 net/socket.c:2359) 
[102.928384][T20485] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-053-20240920/./arch/x86/include/generated/asm/syscalls_32.h:?) 
[102.928839][T20485] __do_fast_syscall_32 (arch/x86/entry/common.c:?) 
[102.929362][T20485] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[102.929824][T20485] do_SYSENTER_32 (arch/x86/entry/common.c:449) 
[102.930273][T20485] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[  102.930754][T20485]
[  102.930754][T20485] other info that might help us debug this:
[  102.930754][T20485]
[  102.931662][T20485]  Possible unsafe locking scenario:
[  102.931662][T20485]
[  102.932291][T20485]        CPU0                    CPU1
[  102.932748][T20485]        ----                    ----
[  102.933216][T20485]   lock(sk_lock-AF_INET6);
[  102.937469][T20485]                                lock(rtnl_mutex);
[  102.938054][T20485]                                lock(sk_lock-AF_INET6);
[  102.938658][T20485]   lock(rtnl_mutex);
[  102.939013][T20485]
[  102.939013][T20485]  *** DEADLOCK ***
[  102.939013][T20485]
[  102.939714][T20485] 1 lock held by trinity-c2/20485:
[102.940182][T20485] #0: edce5dd8 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sockopt_lock_sock (include/net/sock.h:? net/core/sock.c:1125) 
[  102.940929][T20485]
[  102.940929][T20485] stack backtrace:
[  102.941423][T20485] CPU: 1 UID: 65534 PID: 20485 Comm: trinity-c2 Not tainted 6.11.0-01459-g1b1e90e04f34 #1
[  102.942250][T20485] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  102.943160][T20485] Call Trace:
[102.943455][T20485] dump_stack_lvl (lib/dump_stack.c:121) 
[102.943867][T20485] dump_stack (lib/dump_stack.c:128) 
[102.944221][T20485] print_circular_bug (kernel/locking/lockdep.c:?) 
[102.944654][T20485] check_noncircular (kernel/locking/lockdep.c:2186) 
[102.945117][T20485] __lock_acquire (kernel/locking/lockdep.c:?) 
[102.945557][T20485] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[102.946018][T20485] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[102.946456][T20485] ? local_clock_noinstr (kernel/sched/clock.c:301) 
[102.946906][T20485] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[102.947350][T20485] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[102.947782][T20485] ? local_clock_noinstr (kernel/sched/clock.c:301) 
[102.948222][T20485] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[102.948678][T20485] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[102.949157][T20485] lock_acquire (kernel/locking/lockdep.c:5759) 
[102.949581][T20485] ? rtnl_lock (net/core/rtnetlink.c:80) 
[102.949977][T20485] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[102.950442][T20485] __mutex_lock_common (kernel/locking/mutex.c:608) 
[102.950906][T20485] ? rtnl_lock (net/core/rtnetlink.c:80) 
[102.951292][T20485] ? lock_sock_nested (net/core/sock.c:3619) 
[102.951724][T20485] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:63) 
[102.952182][T20485] ? __local_bh_enable_ip (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:97 kernel/softirq.c:387) 
[102.952627][T20485] mutex_lock_nested (kernel/locking/mutex.c:752 kernel/locking/mutex.c:804) 
[102.953058][T20485] ? rtnl_lock (net/core/rtnetlink.c:80) 
[102.953414][T20485] rtnl_lock (net/core/rtnetlink.c:80) 
[102.953790][T20485] do_ip_setsockopt (net/ipv4/ip_sockglue.c:1082) 
[102.954216][T20485] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[102.954690][T20485] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:266) 
[102.955140][T20485] ip_setsockopt (net/ipv4/ip_sockglue.c:1419) 
[102.955521][T20485] ipv6_setsockopt (net/ipv6/ipv6_sockglue.c:?) 
[102.955912][T20485] ? ipv6_set_mcast_msfilter (net/ipv6/ipv6_sockglue.c:984) 
[102.956398][T20485] tcp_setsockopt (net/ipv4/tcp.c:?) 
[102.956828][T20485] ? tcp_enable_tx_delay (net/ipv4/tcp.c:4024) 
[102.957294][T20485] sock_common_setsockopt (net/core/sock.c:3803) 
[102.957771][T20485] ? sock_common_recvmsg (net/core/sock.c:3799) 
[102.958233][T20485] ? sock_common_recvmsg (net/core/sock.c:3799) 
[102.958680][T20485] __sys_setsockopt (net/socket.c:? net/socket.c:2353) 
[102.959124][T20485] __ia32_sys_setsockopt (net/socket.c:2362 net/socket.c:2359 net/socket.c:2359) 
[102.959583][T20485] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-053-20240920/./arch/x86/include/generated/asm/syscalls_32.h:?) 
[102.960019][T20485] __do_fast_syscall_32 (arch/x86/entry/common.c:?) 
[102.960473][T20485] ? irqentry_exit_to_user_mode (kernel/entry/common.c:234) 
[102.960984][T20485] do_fast_syscall_32 (arch/x86/entry/common.c:411) 
[102.961511][T20485] do_SYSENTER_32 (arch/x86/entry/common.c:449) 
[102.961909][T20485] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[  102.962336][T20485] EIP: 0xb7fbb539
[ 102.962665][T20485] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 0f 1f 00 58 b8 77 00 00 00 cd 80 90 0f 1f
All code
========
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	0f 1f 00             	nopl   (%rax)
  35:	58                   	pop    %rax
  36:	b8 77 00 00 00       	mov    $0x77,%eax
  3b:	cd 80                	int    $0x80
  3d:	90                   	nop
  3e:	0f                   	.byte 0xf
  3f:	1f                   	(bad)

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	0f 1f 00             	nopl   (%rax)
   b:	58                   	pop    %rax
   c:	b8 77 00 00 00       	mov    $0x77,%eax
  11:	cd 80                	int    $0x80
  13:	90                   	nop
  14:	0f                   	.byte 0xf
  15:	1f                   	(bad)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240922/202409221753.e29d62c8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


