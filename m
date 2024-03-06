Return-Path: <netdev+bounces-77945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82DE8738F6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F9B22666
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A6133293;
	Wed,  6 Mar 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+dqoUz4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BF130AF2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735099; cv=fail; b=NIFupGdoFPAUo1HbFsiJ93UnEZony+lu/M3sJ1Ng3Iln2Ifebj5TbfVgNdJ/w3jVD8UST+8OjOGrYxYGNA+KorTOZrPO3kKRiFNg/fJnqHkY8OG41mV4VmiHKXOezKUj2ai9OlyDT/Yayqhca/2AbYCBSpC+Wu3oMM5n7Y4zvVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735099; c=relaxed/simple;
	bh=YivwbhUAtcfqGtLp66o9NFfbovpC3Tp3EvlWCBfWU8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u0g+pvmal5psioL1vEI7expC/SXWoQzp9qe7Feqd9UZXF05vWkjVP94NUnyD234e2jkBABHC/i0JtzxxcoUfhbmv8EsbMLjTKAVVKN2nRS8Y6H0UC8TDbn+467soCH7LJydjVVfkGylpbMlDma/ElrkGTR17RZlNJJi7jaRVGlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+dqoUz4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709735098; x=1741271098;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YivwbhUAtcfqGtLp66o9NFfbovpC3Tp3EvlWCBfWU8Y=;
  b=W+dqoUz4wSHM5etQSyvV2eaBkeVvcffuTN/qzSLmFkTWwpCD167g7P9N
   zqzgM/NoGxzi7nPhV2rRzTU8gMXLMa4wwuNRqUgNQP5xsDmHsNPKMnqlK
   qgmKEfDpDvTqHTx36vzFHttUWwHtLP9VXOsEkIEPB7gqw3ufZf/v55oV+
   1ratbtG93eO891DTSlfRfklOhMYAVmaPiusqk1dlPHjNpwpJ0YSAq84SM
   Yc1qtyDMdaQGfdYn0ugz5b2xV4XItGFXrOoQpRKhEoKiMcFFAoFWUX7IA
   ZhDYZTH/Wk9QjMaFBXixzVKTEYYlt+OE3TanzJfbd2CVwN8ZZ0Xdz62Zc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8152552"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="8152552"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 06:24:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9745606"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 06:24:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 06:24:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 06:24:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 06:24:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 06:24:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA0C1ix6Sq3LIrrH5c7+qTs7Mlp+t7xeCpdlJkByT3ZBlzHxUT6Y3kcPVuuNXWCZVGRCaDuNKBW8pZcClCdAGceaR7VzAG8y53n3VY22GlyFvaiXLit+XH5y6Z99sTmuk+JOqqotJxUVJXJ5N4swJNNVNtJMKY/073G3HHXpPW8x1tlGgQp0znj+YrD0Qhjk1Xh4oNuS0x80V3XydKnCpuz9iJp0/O2rJLmSTFm/VPA+HyQuU+9nDcM4qgp6xLgVi+IDoNLdpSIiyH4XefzaMGw2tn36HzkVjwwqfw1ol3VS9gA83H6t+mHHIaIqam5CXOtnh5POc4PQIc6F84olWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzCDqL+emjmUMBcv5ZFewzTQpJe+cVcZJ/i9zv++kxI=;
 b=VbNJL7qpTEzyF/Eco+TFPMbv/Dy3p37gavwdoBfnXELp+ka111TMVMLtyAB0jBcyWSpcNL00pg6r2vN1KDA8DfKAMyHK40Db/wtXp1F1B75baYze9ZAeRWFrw0w1ENZSJCM8oE1aJF873gIYQPrY5Nv5NLvdMQiz8nlcpzjc2DX1G9EH2PhLOY7GjLI+hXOpAWUaHjGCzPuxjkhYvLKWfYGxRR9ZdszjANgLrF05UWVp3kT1LaGtvEeHRgz+iQXU11Ijhmm1c2YSMm3wmBc0Bh8RNrrh2FtnbDGb0GFYih7BZ8kpgZSAh4m6HDWVVCVGv2IMpUYGN8r5gplZaXttSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Wed, 6 Mar 2024 14:24:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 14:24:52 +0000
Date: Wed, 6 Mar 2024 15:24:41 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<horms@kernel.org>, <pmenzel@molgen.mpg.de>, Alan Brady
	<alan.brady@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next v2 1/2] igb: simplify pci ops declaration
Message-ID: <Zeh8qadiTGf413YU@boxer>
References: <20240306025023.800029-1-jesse.brandeburg@intel.com>
 <20240306025023.800029-2-jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240306025023.800029-2-jesse.brandeburg@intel.com>
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM6PR11MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a38e9a5-8987-40ea-929f-08dc3de92fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gF5//RisHt/bKHlL7y0+zmJFWBEAMQ4YkAQXUHU7fVeHm+5y6R4X4sfWIb9+VmX5msQt9jqyB3YNvRFyhek2RX1jtxCFjCD9zcrkobhALJwgyncdu8lPUwG0mKDVQ9myXW147L1Be1EZJhUBMOTKw52bY1s0Xmm6Ol1oMyG7EVxgayQhWqd0PCjf9BrsFxmezng9x438XEQsThkXskDHwxaeEIM+HE3Lt3gc3+ar81tl3+q0AiLahA7adRtwkNwB7l7er/knFCkRf3wpHzLhtJRNU/gngULhENV7bkNU6o6QWbcfpvnNaRM+CweFJZhXPkI5WmT0+7Ael61bvmNeRSgqDpdoWkV5mcYylxLYCXchDou6x5qF47WYx22ziR8ir3UsfRhE9VBhweXAQ3b2ur3zefo8QcJ61r6/u7Ju0seK+fy/mTnWbfbYJOnFD2LV5re4uT8rSkQ1jB4yEvUdfAKv788sZ/9ZZxOjFajOLOWHRFAf6WNA+AGaKvKDqlhv8oSdFhw8Wl0h4HugOotLPgSykWi+pZxJk+VpAKF2mt0v/kWoVrtrbHjmO7ZD+gLvt6wK8xoRKPjT9N7O62RUFKSNIbTOwoA4rBKSvRR1jiuE3SD3d7XPNDyJl5paMRQ5yxWWyI2O1A4X5HgMnbtOyDEEYHs2+HV0+KT4PNuiY+M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B/j4qH3CTuosQPGk4Ga/nA6m4lIsAgKW76EMN3WfbBtklAwJwlZmdBV22wfP?=
 =?us-ascii?Q?Pd6bCDUguV5F9O/RZZpa1ywhFvPAga46C7Q9eDiI+UYtWniWLG8r6M8+5g86?=
 =?us-ascii?Q?WDg2bzIwNnwI8/Xwcv5wAuyfggf6jwhw+ZJBqeTcxtJUvQ7OXB31JiCKpzxX?=
 =?us-ascii?Q?sg4ic/VT+a0Nprm4JD206BpbJf9fxHkVlBXIp5VNmvE4fim4iCzAb9Nsfr5/?=
 =?us-ascii?Q?pDKfL5cy5SGnhBvbod45AVEjl/e65VDr2VbM/4211Y8TfxeyY0IooeAdxSgF?=
 =?us-ascii?Q?/yNEUMVnQ7JD3JME9ItkuQ9vPEPPaOPosrQc7rV1OTSExsW6JntD5vfPOyZM?=
 =?us-ascii?Q?rKUSAfttcPnCPjz6PuzFH82D69LT3YShum97wiace4/qa2IFe9wwvIgo6Wka?=
 =?us-ascii?Q?m1WGA7qSOeKwqpjKPb48J6R5wG9unkXJVd7DDCePEvIkVYLFlxF7N9dIVaLs?=
 =?us-ascii?Q?s6LTbkx1IDXp9LZbLRE3wB/h2Px97pb958hiW155lMO0fZfrfkxT1R4XsD6Y?=
 =?us-ascii?Q?w5AvWYrHc7/ltZPAw26wYwNTks/Eq7xOzTWM8a7ns1kCXatFGJSc5caV7dFT?=
 =?us-ascii?Q?mjafvaAqE4SPml8cG97UQJjnM06DUKvQdk3Dzxw/W+1B4QwcG3u259Kxyz8/?=
 =?us-ascii?Q?w8Vle1EJjghc5bnVeDzDTvpkxn4jC3dn4lcHyBjB69PgSTg12LT/WxGkwdi7?=
 =?us-ascii?Q?TVnjNZuTrl7zZnKAiMJ+jVyuAOoc8cQ0vj617XAMs5dbQEqqDzmvVL0iXhRe?=
 =?us-ascii?Q?5auDcdpM3D33k3MWJCJf8G8w+Xc2v2PwcMEpev2H36XTNDS7YyzzR5DP4ptV?=
 =?us-ascii?Q?t3mqsaEQoyNoDWbKKB4i9EtWk9k93hXY61C+ECkyE1STnWNaSXkqFTrcpiFi?=
 =?us-ascii?Q?oeDN0rjSNwB09RiMzm1JZ++zeQPAXgmhEa9vTweDPYPmw+BORBRSv0zReJq5?=
 =?us-ascii?Q?TxQcYtCRas+j8mcO40EQGTYAkqjx/W7KbC7c/YYWlT+Xk0faQczp9AI02CPT?=
 =?us-ascii?Q?yO506phcMUb+gUdqc1d7Ry5W+qDQWuH/aOc0Sq+AJxU3uUraGfpEBOCY0xWm?=
 =?us-ascii?Q?xVoVjHECaTlOFKpjgY9helC/4fLIWHYWSnwCGpU3LAhkRzyZofNV36Wjb1jj?=
 =?us-ascii?Q?iiYthzKtuoJ9QMp/4LZPtpAp8+GsHXQd4XhSlaO2L+zQq6sbsgEVSKgsydEG?=
 =?us-ascii?Q?9F/u/r5Ak1n2thSXKxK/edeXSYgjhq1/vALFFq85tmjkyDX9d23KL4nYO1Hk?=
 =?us-ascii?Q?l0x5ZSQnLOx4dOqWB0NYUN1CyWBbHQ4S4nR++/gd4pvK1PTQ6HXwbteZLtSm?=
 =?us-ascii?Q?s0ORINtruDiRZfZoHaCNHe39XKMvyv8s43+J6wS12tu7EB29f3JbxWXm/1pK?=
 =?us-ascii?Q?gDX1th5ij02FfYzpHP/knwS4aceveblevqZUKmmqkImTngl0DtVYsDc6+pp4?=
 =?us-ascii?Q?Hmo0N2JC9jOLqHctq7LTWzWdVwsV0kAaYOTnkWwXvIN1dw2FICsbQeGa0DuV?=
 =?us-ascii?Q?MhHvClveF7AkN1q7MuUp08oRr0vc+BiI9/IMJXLsiAjRLcd6p38D0T1GYW74?=
 =?us-ascii?Q?2Sbd2vi4KxZqbEmGmxf3BjRtfBgFp6ERA94bxdQbefyAf83dbJncssCm3JXB?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a38e9a5-8987-40ea-929f-08dc3de92fc8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 14:24:52.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASMiLc3U+80FlSZDYIJ+9ileL4XHPTSz5C92jIpX6d2+l1l8WeNHZPtPOWk/rPUsTqZx0qYYEaktrJKF1uyQu6/jlowfvCqDy6c27JLklQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com

On Tue, Mar 05, 2024 at 06:50:21PM -0800, Jesse Brandeburg wrote:
> The igb driver was pre-declaring tons of functions just so that it could
> have an early declaration of the pci_driver struct.
> 
> Delete a bunch of the declarations and move the struct to the bottom of the
> file, after all the functions are declared.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

However, that's just a drop in the ocean when we look at unneeded forward
declarations, isn't it?

I got side-tracked while looking at some stuff and saw such forward decls
in i40e_nvm.c and decided to fix this as this was rather a no-brainer that
just required to move code around. Now I feel encouraged to send this, but
what should we do with rest of those, though?

Being a regex amateur I came up with following command:
$ grep -hPonz 'static [a-z]+.+\([^()]+\);' drivers/net/ethernet/intel/igb/*.c | sed 's/1:/\n/g'

in order to catch all of the forward declarations in source files and this
results in very nasty list [0]...and this is only within igb!

ice driver is a nice example that reviews in netdev community matter. It
contains only 4 fwd decls and I believe it is very much related to times
when vendor pull requests started to be actually reviewed in the upstream,
not just taken as-is.

[0]:
static s32  igb_get_invariants_82575(struct e1000_hw *);
static s32  igb_acquire_phy_82575(struct e1000_hw *);
static void igb_release_phy_82575(struct e1000_hw *);
static s32  igb_acquire_nvm_82575(struct e1000_hw *);
static void igb_release_nvm_82575(struct e1000_hw *);
static s32  igb_check_for_link_82575(struct e1000_hw *);
static s32  igb_get_cfg_done_82575(struct e1000_hw *);
static s32  igb_init_hw_82575(struct e1000_hw *);
static s32  igb_phy_hw_reset_sgmii_82575(struct e1000_hw *);
static s32  igb_read_phy_reg_sgmii_82575(struct e1000_hw *, u32, u16 *);
static s32  igb_reset_hw_82575(struct e1000_hw *);
static s32  igb_reset_hw_82580(struct e1000_hw *);
static s32  igb_set_d0_lplu_state_82575(struct e1000_hw *, bool);
static s32  igb_set_d0_lplu_state_82580(struct e1000_hw *, bool);
static s32  igb_set_d3_lplu_state_82580(struct e1000_hw *, bool);
static s32  igb_setup_copper_link_82575(struct e1000_hw *);
static s32  igb_setup_serdes_link_82575(struct e1000_hw *);
static s32  igb_write_phy_reg_sgmii_82575(struct e1000_hw *, u32, u16);
static void igb_clear_hw_cntrs_82575(struct e1000_hw *);
static s32  igb_acquire_swfw_sync_82575(struct e1000_hw *, u16);
static s32  igb_get_pcs_speed_and_duplex_82575(struct e1000_hw *, u16 *
						 u16 *);
static s32  igb_get_phy_id_82575(struct e1000_hw *);
static void igb_release_swfw_sync_82575(struct e1000_hw *, u16);
static bool igb_sgmii_active_82575(struct e1000_hw *);
static s32  igb_reset_init_script_82575(struct e1000_hw *);
static s32  igb_read_mac_addr_82575(struct e1000_hw *);
static s32  igb_set_pcie_completion_timeout(struct e1000_hw *hw);
static s32  igb_reset_mdicnfg_82580(struct e1000_hw *hw);
static s32  igb_validate_nvm_checksum_82580(struct e1000_hw *hw);
static s32  igb_update_nvm_checksum_82580(struct e1000_hw *hw);
static s32 igb_validate_nvm_checksum_i350(struct e1000_hw *hw);
static s32 igb_update_nvm_checksum_i350(struct e1000_hw *hw);
static s32 igb_update_flash_i210(struct e1000_hw *hw);
static s32 igb_set_default_fc(struct e1000_hw *hw);
static void igb_set_fc_watermarks(struct e1000_hw *hw);
static s32  igb_phy_setup_autoneg(struct e1000_hw *hw);
static void igb_phy_force_speed_duplex_setup(struct e1000_hw *hw
					     u16 *phy_ctrl);
static s32  igb_wait_autoneg(struct e1000_hw *hw);
static s32  igb_set_master_slave_mode(struct e1000_hw *hw);
static int igb_setup_all_tx_resources(struct igb_adapter *);
static int igb_setup_all_rx_resources(struct igb_adapter *);
static void igb_free_all_tx_resources(struct igb_adapter *);
static void igb_free_all_rx_resources(struct igb_adapter *);
static void igb_setup_mrqc(struct igb_adapter *);
static int igb_probe(struct pci_dev *, const struct pci_device_id *);
static void igb_remove(struct pci_dev *pdev);
static void igb_init_queue_configuration(struct igb_adapter *adapter);
static int igb_sw_init(struct igb_adapter *);
static void igb_configure(struct igb_adapter *);
static void igb_configure_tx(struct igb_adapter *);
static void igb_configure_rx(struct igb_adapter *);
static void igb_clean_all_tx_rings(struct igb_adapter *);
static void igb_clean_all_rx_rings(struct igb_adapter *);
static void igb_clean_tx_ring(struct igb_ring *);
static void igb_clean_rx_ring(struct igb_ring *);
static void igb_set_rx_mode(struct net_device *);
static void igb_update_phy_info(struct timer_list *);
static void igb_watchdog(struct timer_list *);
static void igb_watchdog_task(struct work_struct *);
static netdev_tx_t igb_xmit_frame(struct sk_buff *skb, struct net_device *);
static void igb_get_stats64(struct net_device *dev
			    struct rtnl_link_stats64 *stats);
static int igb_change_mtu(struct net_device *, int);
static int igb_set_mac(struct net_device *, void *);
static void igb_set_uta(struct igb_adapter *adapter, bool set);
static irqreturn_t igb_intr(int irq, void *);
static irqreturn_t igb_intr_msi(int irq, void *);
static irqreturn_t igb_msix_other(int irq, void *);
static irqreturn_t igb_msix_ring(int irq, void *);
static void igb_update_dca(struct igb_q_vector *);
static void igb_setup_dca(struct igb_adapter *);
static int igb_poll(struct napi_struct *, int);
static bool igb_clean_tx_irq(struct igb_q_vector *, int);
static int igb_clean_rx_irq(struct igb_q_vector *, int);
static int igb_ioctl(struct net_device *, struct ifreq *, int cmd);
static void igb_tx_timeout(struct net_device *, unsigned int txqueue);
static void igb_reset_task(struct work_struct *);
static void igb_vlan_mode(struct net_device *netdev
			  netdev_features_t features);
static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
static void igb_restore_vlan(struct igb_adapter *);
static void igb_rar_set_index(struct igb_adapter *, u32);
static void igb_ping_all_vfs(struct igb_adapter *);
static void igb_msg_task(struct igb_adapter *);
static void igb_vmm_control(struct igb_adapter *);
static int igb_set_vf_mac(struct igb_adapter *, int, unsigned char *);
static void igb_flush_mac_table(struct igb_adapter *);
static int igb_available_rars(struct igb_adapter *, u8);
static void igb_set_default_mac_filter(struct igb_adapter *);
static int igb_uc_sync(struct net_device *, const unsigned char *);
static int igb_uc_unsync(struct net_device *, const unsigned char *);
static void igb_restore_vf_multicasts(struct igb_adapter *adapter);
static int igb_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac);
static int igb_ndo_set_vf_vlan(struct net_device *netdev
			       int vf, u16 vlan, u8 qos, __be16 vlan_proto);
static int igb_ndo_set_vf_bw(struct net_device *, int, int, int);
static int igb_ndo_set_vf_spoofchk(struct net_device *netdev, int vf
				   bool setting);
static int igb_ndo_set_vf_trust(struct net_device *netdev, int vf
				bool setting);
static int igb_ndo_get_vf_config(struct net_device *netdev, int vf
				 struct ifla_vf_info *ivi);
static void igb_check_vf_rate_limit(struct igb_adapter *);
static void igb_nfc_filter_exit(struct igb_adapter *adapter);
static void igb_nfc_filter_restore(struct igb_adapter *adapter);
static int igb_vf_configure(struct igb_adapter *adapter, int vf);
static int igb_disable_sriov(struct pci_dev *dev, bool reinit);
static int igb_suspend(struct device *);
static int igb_resume(struct device *);
static int igb_runtime_suspend(struct device *dev);
static int igb_runtime_resume(struct device *dev);
static int igb_runtime_idle(struct device *dev);
static void igb_shutdown(struct pci_dev *);
static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
static pci_ers_result_t igb_io_error_detected(struct pci_dev *
		     pci_channel_state_t);
static pci_ers_result_t igb_io_slot_reset(struct pci_dev *);
static void igb_io_resume(struct pci_dev *);
static void igb_init_dmac(struct igb_adapter *adapter, u32 pba);
static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter);
static void igb_ptp_sdp_init(struct igb_adapter *adapter);

> 
> Reviewed-by: Alan Brady <alan.brady@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: address compilation failure when CONFIG_PM=n, which is then updated
>     in patch 2/2, fix alignment.
>     changes in v1 reviewed by Simon Horman
>     changes in v1 reviewed by Paul Menzel
> v1: original net-next posting
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 53 ++++++++++-------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 518298bbdadc..e749bf5164b8 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -106,8 +106,6 @@ static int igb_setup_all_rx_resources(struct igb_adapter *);
>  static void igb_free_all_tx_resources(struct igb_adapter *);
>  static void igb_free_all_rx_resources(struct igb_adapter *);
>  static void igb_setup_mrqc(struct igb_adapter *);
> -static int igb_probe(struct pci_dev *, const struct pci_device_id *);
> -static void igb_remove(struct pci_dev *pdev);
>  static void igb_init_queue_configuration(struct igb_adapter *adapter);
>  static int igb_sw_init(struct igb_adapter *);
>  int igb_open(struct net_device *);
> @@ -178,20 +176,6 @@ static int igb_vf_configure(struct igb_adapter *adapter, int vf);
>  static int igb_disable_sriov(struct pci_dev *dev, bool reinit);
>  #endif
>  
> -static int igb_suspend(struct device *);
> -static int igb_resume(struct device *);
> -static int igb_runtime_suspend(struct device *dev);
> -static int igb_runtime_resume(struct device *dev);
> -static int igb_runtime_idle(struct device *dev);
> -#ifdef CONFIG_PM
> -static const struct dev_pm_ops igb_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
> -	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
> -			igb_runtime_idle)
> -};
> -#endif
> -static void igb_shutdown(struct pci_dev *);
> -static int igb_pci_sriov_configure(struct pci_dev *dev, int num_vfs);
>  #ifdef CONFIG_IGB_DCA
>  static int igb_notify_dca(struct notifier_block *, unsigned long, void *);
>  static struct notifier_block dca_notifier = {
> @@ -219,19 +203,6 @@ static const struct pci_error_handlers igb_err_handler = {
>  
>  static void igb_init_dmac(struct igb_adapter *adapter, u32 pba);
>  
> -static struct pci_driver igb_driver = {
> -	.name     = igb_driver_name,
> -	.id_table = igb_pci_tbl,
> -	.probe    = igb_probe,
> -	.remove   = igb_remove,
> -#ifdef CONFIG_PM
> -	.driver.pm = &igb_pm_ops,
> -#endif
> -	.shutdown = igb_shutdown,
> -	.sriov_configure = igb_pci_sriov_configure,
> -	.err_handler = &igb_err_handler
> -};
> -
>  MODULE_AUTHOR("Intel Corporation, <e1000-devel@lists.sourceforge.net>");
>  MODULE_DESCRIPTION("Intel(R) Gigabit Ethernet Network Driver");
>  MODULE_LICENSE("GPL v2");
> @@ -647,6 +618,8 @@ struct net_device *igb_get_hw_dev(struct e1000_hw *hw)
>  	return adapter->netdev;
>  }
>  
> +static struct pci_driver igb_driver;
> +
>  /**
>   *  igb_init_module - Driver Registration Routine
>   *
> @@ -10170,4 +10143,26 @@ static void igb_nfc_filter_restore(struct igb_adapter *adapter)
>  
>  	spin_unlock(&adapter->nfc_lock);
>  }
> +
> +#ifdef CONFIG_PM
> +static const struct dev_pm_ops igb_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(igb_suspend, igb_resume)
> +	SET_RUNTIME_PM_OPS(igb_runtime_suspend, igb_runtime_resume,
> +			   igb_runtime_idle)
> +};
> +#endif
> +
> +static struct pci_driver igb_driver = {
> +	.name     = igb_driver_name,
> +	.id_table = igb_pci_tbl,
> +	.probe    = igb_probe,
> +	.remove   = igb_remove,
> +#ifdef CONFIG_PM
> +	.driver.pm = &igb_pm_ops,
> +#endif
> +	.shutdown = igb_shutdown,
> +	.sriov_configure = igb_pci_sriov_configure,
> +	.err_handler = &igb_err_handler
> +};
> +
>  /* igb_main.c */
> -- 
> 2.39.3
> 
> 

