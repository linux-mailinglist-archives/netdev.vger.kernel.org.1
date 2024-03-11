Return-Path: <netdev+bounces-79266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BBD8788E9
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E53A281B53
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E754BFE;
	Mon, 11 Mar 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MM9O6z+G"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5094640847;
	Mon, 11 Mar 2024 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185257; cv=fail; b=WtsDjpQsXuauk72dhKguQ/rNxbbaOQbR8gFkaz56Hc9BqMckIeoJGoPIuQ9wQ926Sz91AkqoarVUTUwO8I8l3H992t9rL+OrC+T4wjCNFYJoHQg8zM8+p03vn2/31WrK/OgD/dUK845Ie7Gwfe1KdkjtSk+fs3UuKuFIBBUTgy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185257; c=relaxed/simple;
	bh=+vY5eRBggUXPXblO/lU7BShwfhPBN/f3rjgEbuUzJMo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWH6oq6lhlmz2e97VT/5U9twUcjmcn/cwxgE3+pMJtN63gixSAr5U1j4HM0T5Mo1J79Ol9Qj0u3snlyuHw10rH7LuBq+NC3GQ5PwlsLCqhyH3DrHuZkDR7E9HJ0IjsBP/HcSqkMb6OWGHM7m//88PpSDjqAoOStDhWxMNS26DHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MM9O6z+G; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710185256; x=1741721256;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+vY5eRBggUXPXblO/lU7BShwfhPBN/f3rjgEbuUzJMo=;
  b=MM9O6z+GYbBPjt1X3Q4Tx2O6QQnffaKgainwhDDa3gm/+OkqatZgKCSh
   D17uHh0/ky5C89tstz7Lp/rBgx9SN+sSeuyBiFet4plx1dxd7IobKMbul
   hqzZifNIKRBctBLAnSRjZ2bAeE6egbPt2scN3CoRUIFE/epZChqALG8mG
   Yd7xcNGoeiBwAPIX4tYltFEAhMDaXkJ9y7AKSS7vUGsF0Yxfu02m0qvOS
   6FV3D1CQYX6mJBLZeQpobqhvCx3D7yv+FkCftIbzlgQBZW7gcvXcIRgI2
   toUouAxPdGiID72bJ5nwXxARKXrgF+zZvBT+ip+Wdp8JrMyRt+vrk9McW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4726393"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="4726393"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 12:27:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11858343"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 12:27:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 12:27:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 12:27:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 12:27:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 12:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa+ShvT1Uxjrn5ckvwEO4bQ34wGfe68PuDUJiAtOc8vpKEg5LmWLqyIyIAtzxbq4vDtQvGSYaiN1zRmSRj/fqLk/WJ84kTnfL0WWaQslQ6cikNSct5drUJvq7znMSC3AdyQ841qbFXSkBxmhlJBb/L1y8q/xRkWsKlBcoAHzIVjrdLhzRD0APCJOe47khsv69/XdQ/tdXV956wDiDGmBZ88ZVV82ghOSpcaKBEGqwpDHJzcRJxjzyGmKc4aeaSnBKSAAE7NBQUVaA09x+j/t5/8AO0taPC7e1ZqDRGEm2Z6yTXGmvOTOaq/3mOxp47jNdWzI3N1cbHzvhgyq67NjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nY1NhieIjZafOUk8DjtsG8ckiK/AKHsEUny5OKXEB4=;
 b=ak2T1v4IArlvCziqPvL+iin7j8uKm2+Pyg+VWWBYDyLNh8GsVi4HHtRYxQL1pTmdwLORpbA13TDOcvpbkVMHz9WnfjbPFTsVONPSve8TcFEwTqUz4fWwa/zdKtq+K/03DqRUzOvrp2AtOFPxv2kaMmcrrMgBIAQrb422cjDPA45jOs87dkWS3rgrYiW+MqchDrToMXFRfNydbGk11JNVYsPkpMR01remReBhkHNK8zUBM8CSthb+LYDfuBYjbnJkCk0/Qgk/fJL3EKohT6X84VaGBtvjIW8rlOOemK1+sCD3OerCLhjEQECXFqMLEV3rhbLcQrQvGxhRbGrf/QQZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH8PR11MB6829.namprd11.prod.outlook.com (2603:10b6:510:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14; Mon, 11 Mar
 2024 19:27:23 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%5]) with mapi id 15.20.7386.016; Mon, 11 Mar 2024
 19:27:23 +0000
Date: Mon, 11 Mar 2024 20:27:17 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <netdev-driver-reviewers@vger.kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [ANN] netdev call - Mar 5th
Message-ID: <Ze9bFepLhiQIBmio@lzaremba-mobl.ger.corp.intel.com>
References: <20240304103538.0e986ecd@kernel.org>
 <20240304103657.354800b0@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304103657.354800b0@kernel.org>
X-ClientProxiedBy: DU7P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH8PR11MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b297f2-1c39-49b5-f107-08dc420146de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHNDbHFTNU5+ecWmhli8qAO0cPoh9m70mnjX5tYdzUwVauyXadiNXDRWBbb8IzXYk+Dawthm7zs9wXarfSROvvK68blZ/eBg6wJ3PgHWTdNnYSoyZJpVDrN+OJsb0sOzHgoNww3cB1GUdjvXEF2vabm9v9pgWrN+FYxEaaUVtBy6o5I0tbppFxI9j45Q9+NP06ekjzAo1WdgaYnCCGItxAxLHb6G+WOMzxoTFc75v3mPKSWutkxID3pzdrvsFbvmG7tEywurykRiAWfp4lj0KAcvDEnd/+G+6omz0MFohsWD0b7DMAicwpTuXTDMFVbfOWNSEujIuKo62d/VRbX/U4w0ej1styldIy+Ghd0yePPBHgr/hSQncqMftUMSci3XuB78b27cAQbw38GG0utte2eACxZ3tMhgFPaqW8v9Yp1rAwhzId8ZBVuFqYZQ+4FtLejs2Lgr2yg555oCVhoPgeSSCSpO1TsQsG844nqs92VhE8pJUBSbWqz0dVOUq0Z99tr/K3xdkX00SvTPthVTrKxI3NavUBgPRh5/5eLCgfWDEaFApXkE0p0LzqvNELZV6Y+Ski8wq8rhD1vWyzCzrZnazjWTibPcOQ4rqaqe2ZNbjw4tlDDNS4zl0ulfkqsz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHFvbmxCTFpMRFhsS1pwcWNaNXVDbjZ1OFlVTlZVWUFqUWFJc1NUNHlWVkcx?=
 =?utf-8?B?N3BqQWZzNjR2dUVTQTM3WEU1YitBck8wbGdTdnhJbmZCNW1OWSt4N05WcmVS?=
 =?utf-8?B?WWtFdjhtbVpPSlpVT1VNcGVTeXFsU0hYb25TcmZtZzNybldyRm1sN1A4K0gr?=
 =?utf-8?B?eDJSTi9xYUVHWjY5MnpQZGNNSnQwdW0yT2ZlY1NRL01FNWVtWDltYjIzZ2lm?=
 =?utf-8?B?U0NvV3JqZnVQREhjcm9WdXFhdWNaMVgwRCtQeldEZGJvV3RTUm9NaXdGejZ1?=
 =?utf-8?B?dGFFenRCWUhBeDhLNVhHSHgrMG93ejVQRmpUWEVvbmlwbS9KMGFndHM5cnRS?=
 =?utf-8?B?ajR4ZmhMOFc5ZnR5Mm5QTVJZaDFlZE1vNHRKdWRxV2JNWVZCbGJHSzU3NUZn?=
 =?utf-8?B?L1VLcU5EMXVVZWVGM2dXaCs4dUhRRVFZeUdZTzhDbHZmcTUrdkxTamhITlJq?=
 =?utf-8?B?U2l6UXdkZ0h1Y1pLQlBVTUNIYUROcFMybHBGcEo0S2E3aEdENzBzdUJia2Zk?=
 =?utf-8?B?OGNQYm9GYS8xTjZuZjBXdzRERDNWZXhodEVXNmtTUGU5dnMzbVJMZ0xyN2N0?=
 =?utf-8?B?d1NlbWM4TjNYdUVYbiswTU80Y2ZOVENUSHN5aWJzaWtKR3lLazJ3VmFHMkor?=
 =?utf-8?B?TzJBUU1VVXpYRHpsdU1aMnZFUFlnM3crYTVkN1VROXl0NkRZR3AxMExIRFpy?=
 =?utf-8?B?dHpKOFZxai9hTi8yVWRJNU1DU2dmQUNOV01lQVMxRGVHY0ZuRUNyZ0oyL2V5?=
 =?utf-8?B?SjU0ZUlRZTM3Q0I4OFV4cjZJZHcvMDJ4bHhlNHZMSjRLcEJ4Sm0yTllwbFZE?=
 =?utf-8?B?VU5pcVRPVjMyS2psYnRwZnhJMVRrcHdqOFdoRFhjUFExd1dJTFVsVzFNNjZD?=
 =?utf-8?B?R0lPejQvdmRValBCWFVaRElyZVNRemNVT29QdGFMVnRaaG5ucmtFbVVZRVlx?=
 =?utf-8?B?YTUvUUZrOU83YW9ZWmVKcUQxQkxNV1M2NW9iTW0vT01RNFRnWDlueXNwY2VN?=
 =?utf-8?B?Q3cvbGYzbHFpQ010UDdzdFJYTlVVZTBuV2htWUt0UXFSZEM2RTArNFdkbEZi?=
 =?utf-8?B?cUkrV3UvREF0Y3RIdy85aWZ2YjcyT0VSSStrYWdRSWpNQ0hjTytTeTZVZ3Rn?=
 =?utf-8?B?S1NraEVrRlA5S1AyMlh6MmhpYitIdSttaFYrRU0zUktSdFd3ZWNJRzg3SW0w?=
 =?utf-8?B?cjVqTzhid3pidG1kZVNiVlMwWUI4THUyeVdhZlY4K0NYWnFkUGF5WCthdnpJ?=
 =?utf-8?B?UWt1alFiVXFjQzdEa0JyQXk2akQ3UmdWaFE1OE55QmptVFNhaHpEakRTWUtv?=
 =?utf-8?B?ZGtUUG1SbUhTZGFPTXhENkoxd0N6NGtmVU1IYjcxWkFBek9WalRUU25NdmRS?=
 =?utf-8?B?K1loTFNTdUtuZTFkR1QyVkQwM08wTjJGYWplbWtwdlZPQmlRYTFDaExCektI?=
 =?utf-8?B?ekxlRHNCWTdOazYrRVFkYzZFdWQzSXNxbzhVR3JJRm1Ec2VmZkFJbFRYT1V1?=
 =?utf-8?B?d2l0dXBpR1N6NXM5TUg3dGEzWjliWXBsOGVLT2hRa0lXblY3SjlBTnZ5R2lY?=
 =?utf-8?B?ellQRGNFODNuTE8vTCsxdFJ4NG01UTNSTHJIN2NoazZ4aHBIUVE0SUlxUXZL?=
 =?utf-8?B?KzV5VHF6SjVhWFNvVWhBUmR0TEo2MHNjNytZYWJXV01qT3laQ0xpeFVQcXJi?=
 =?utf-8?B?dG90R2FnK2pkTi82cnoxOXFIS1AwTGtYVGNrYWQreXA5VnI0MWVDelJaRkhp?=
 =?utf-8?B?TmNBbnpMdU9VQVFyTjNUalE0T1pYNEZ2YlJ5SlNOeEwzZzdBYjcrUDBKbGxI?=
 =?utf-8?B?eXB3R1JGTmptdTVhcnRjN3lobE1LaWNnMSt2NFh6Ykl1RUoxTjU4WFEweTdi?=
 =?utf-8?B?NkQ4bWVucVE5MWhwSW54bTNOMWxmWVMrTkhkK1ZXa1lnRGVRc0QyanVZaXc3?=
 =?utf-8?B?QzJMejBuQW9MWWJ6ZGdkQlRBZzZEaEVPYnZOeUJJaGcyS2E2dy9MOTRWbmU4?=
 =?utf-8?B?R0VEdGJrTkdrclp2SUU0UzZPclp5RjNSaGE5ZUFpUm9sTGRZb0pNOWxVenh4?=
 =?utf-8?B?SmJYV245MjcybXhIQVdyazVCK1N4WllDU09CRE9zSndWOE51dkNPM3FHZFl6?=
 =?utf-8?B?cUhyMUFpZWFFNUJGRlNMaUVCZlk2MlBQMEZhamEwamRYaTI2dXhud2xNbUlR?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b297f2-1c39-49b5-f107-08dc420146de
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 19:27:23.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0BjLTnfTTpYO/70wzCj3mIc0l5RkfGIpH9/8/CHOWAJOOjAberS9SBtJlrLX7jKaz5Q2gHJ0x0IObczZzDxAYJ8ULC82QiVoUtn9UeVXa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6829
X-OriginatorOrg: intel.com

On Mon, Mar 04, 2024 at 10:36:57AM -0800, Jakub Kicinski wrote:
> On Mon, 4 Mar 2024 10:35:38 -0800 Jakub Kicinski wrote:
> > Hi,
> > 
> > The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> > is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
> > 
> > No topics so far, please reach out if you have something to discuss,
> > otherwise we'll cancel.
> > 
> > The reviewer of the week is.. Meta!
> 
> Sorry, ignore that, ENOCOFFEE.
> The next call is scheduled for the 12th of March, not tomorrow 🤦️
>

We have a topic for the 12.03.2024 netdev call:

How set_channels() input should be interpreted

Mostly, implemetations of .set_channels() are tailored for only one of the
following inputs:
1. ethtool -L <ifname> combined <n>
2. ethtool -L <ifname> rx <n> tx <m>

There are also exceptions, e.g.
* bnxt: input 1 puts interface in a shared channels mode, input 2 puts device
  into a dedicated channels mode
* xgbe: ethtool -L <ifname> combined <n> rx <m> tx <l>, <m> and <l> cannot both
  be non-zero at the same time
* ice and idpf: accept both inputs, but try to create as many queue pairs as
  possible

In idpf and ice, we have encountered a problem, where the checks (listed below)
in ethnl_set_channels() do not trigger for us, because our set_channels() operates
under an assumption that if a value in ethtool_channels stays the same, it was
not provided by user and therefore defaults to '0' [0].

The ethnl_set_channels() checks and how they fail us:
1. Ensure there is at least 1 RX and 1 TX channel [1]
        ethtool -l <ifname> -> combined 40
        ethtool -L <ifname> combined 40
   ice triggers an internal check, which was removed from idpf after review [2],
   so idpf tries to set 0 RX and
                                           0 TX queues
2. Prevent disabling a channel with an AF_XDP socket attached [3]
        ethtool -l <ifname> -> combined 40
        ./xdpsock -i <ifname> -q35
        ethtool -L <ifname> rx 30 tx 30
  ice destroys the queue the socket is attached to, despite there being a check
  in the core code that must prevent this [3]
  In theory, the same should be possible to do the same on e.g. mlx5, by doing
        ethtool -L <ifname> combined 30 rx 10 tx 10

So, we would like to discuss, how can we solve the above problem and also
establish how should an ideal set_channels() input interpretation look.

Possible solutions:
1. Convert our drivers to whatever is a preferred way to handle the input.
2. Add .fix_channels() callback to ethtool_ops
        [...]
        mod |= mod_combined;
        if (!mod)
                return 0;

        /* Here ice and idpf would change unmodified values to 0 and convert
         * separate overlapping rx/tx channels into combined,
         * mlx5 and bnxt would set rx_count and tx_count to 0, etc.
         */
        if (dev->ethtool_ops->fix_num_channels)
                dev->ethtool_ops->fix_num_channels(dev, &channels);

        /* ethtool does generic checks on the modified values and calls
         * set_channels() after
         */
        [...]

3. Use the abovementioned assumption made by ice driver [0] in ethnl_set_channels().
   We propose this, because no doubt about it was expressed during the community
   review of the both affected drivers [2][4].

[0] https://elixir.bootlin.com/linux/v6.8-rc7/source/drivers/net/ethernet/intel/ice/ice_ethtool.c#L3541
[1] https://elixir.bootlin.com/linux/v6.8-rc7/source/net/ethtool/channels.c#L154
[2] https://lore.kernel.org/netdev/20230821140205.4d3bc797@kernel.org/
[3] https://elixir.bootlin.com/linux/v6.8-rc7/source/net/ethtool/channels.c#L186
[4] https://lore.kernel.org/netdev/20191121144246.04adde1a@cakuba.netronome.com/ 

