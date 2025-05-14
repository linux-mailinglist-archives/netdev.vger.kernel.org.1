Return-Path: <netdev+bounces-190372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082ADAB68C3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A82E3B0669
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2322F16E;
	Wed, 14 May 2025 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1Q6KrKd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D24B5AE
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747218457; cv=fail; b=dGdn36ecCdC75llPBy8WzQpKkePNcNL/cnztBXvm4BaIm1gfiviYejneokSlVVt4HW3wPdD1Kph4iqPe4HjyiTr7sXh6Nqg62UwCmIr6oZ3CVHcoib07wI9kCm+hMQ0q/UGmzSzrbaF2AEUdYOtm30o/arHvYcVOpp+oMLrJTDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747218457; c=relaxed/simple;
	bh=bj6+M3Ba80o/Iv9E0fH9JbyxMsYCHc7jJbLn+GlTQl0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZkDlupLdZ29ITKPTXqNej66OTE+DPG0cJ7sFmep+++ZgXa9OBHVoSwFNLTQtrGPhn27I7uPBkqNzafTU7wYSs2S4h4nh6mdSgOK2PkCkGeZfGzuJRinwyk6/45RZp0OQBX4Esl85EyKzd7HqLBfA3aPkclHzcLa3Q6U+ZP0NOi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1Q6KrKd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747218455; x=1778754455;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bj6+M3Ba80o/Iv9E0fH9JbyxMsYCHc7jJbLn+GlTQl0=;
  b=K1Q6KrKd9yWVU697RUw0tlkBWiKbFA9Mf+oXVHML9rbRHXRuVwd8pQZj
   qYUp3yGrGwvVCtoQUn5r64jssnnhSu1rRp90eW6cu6juH1R3ZDZKW8iw3
   o2iaIrADM5US9DMWccyUv+jUawNQLHRASpLuUbUKxmqgpzNYoJURQSblP
   ZPStJrMObcMRpu2u26RVHdgXAsqo/A9uIPf+HKaF3ALx7Lbi4cENMtCri
   AIEo66FaxfrXlHRMXTrO+irOAgI/FxOBBZ7Ib97qknbEhkCgP3W116EGo
   xLz8AWgIaAGATg8OpufYaOu79SElBpMvbWb9tnCtRDDXX0cfq7Qz+OUeR
   Q==;
X-CSE-ConnectionGUID: BIKFWSrsS1qFpoNMUfrwIQ==
X-CSE-MsgGUID: rxKiFycERZma0NMhbfAwoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49178854"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49178854"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 03:27:33 -0700
X-CSE-ConnectionGUID: PUrluTmmQoC2HJMU6xB4ZQ==
X-CSE-MsgGUID: tzgTv1f8QVGdSJKIhYKWvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="143199997"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 03:27:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 03:27:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 03:27:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 03:27:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApBuQAh7IVfARFeacZ1AMMq+kI/ccdmF/sfGe5TWEQxJYaafUZAI0GCxaDTlhbjfORvXzygqrFB/wYvjLZTVl9kGqd44q7RhbtkxUdyEcps+GuY3lfbVDR/pLEpkYdsMYv6PmE1a4Q9gcFCsKL6rEswdjGcNMJ3ArP5oiiY+D3UjLgyNhNRwqGz1ERhvNkAF+TD0NRdBC1AgBmfhRsgF3u3Zyarncfxx3e68w518j9SvriPAqrv3pHPkey75ddPwjg976SLDu2HniJgBSielEeU9FUUrbJHYAt525WTRWSVYxcDHeg4O/qPx7VBygI0uHdJ+5Nkbayj4XCwsVvzRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h59MfsVQnIkuUKSHOySpeqoq3qF5+n+QUVy7Noqxuj8=;
 b=uk+PULx+ic2xdL1l5WgkDvonghUFPDXw0JZ8RTJwxr5l6feBD+kS9qHHmsB7TBDwvnfsBYmRAyYBoCXfAPBeNAVpGgbqNTw599XTDcCdbwvM1SZMKGVOGMGhwwzZoHo3GSRfPiWhUEt/7yglsMSqDKOjLQei26jr3Sln26/kEtyCQ3qNTT3C0HFWhvaKw4H4l/WrPaUWqiYPMuoVWnfSh6OSziyxaJtwWeOajrvqDwFwyoNwnwAOvSGGarh7n5C8RvlFVDR+ngD44jw7rX2M3y7AQTEiFQW3ghgiscE4y2eon0Yuuc1LOUewI0VGnIyX3cPVCL/WOFemrQW1916CrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Wed, 14 May 2025 10:26:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 10:26:46 +0000
Date: Wed, 14 May 2025 12:26:40 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Michal Kubiak <michal.kubiak@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@intel.com>
Subject: Re: [PATCH iwl-next] ice: add a separate Rx handler for flow
 director commands
Message-ID: <aCRv4Bqi1+9BeBK4@boxer>
References: <20250321151357.28540-1-michal.kubiak@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250321151357.28540-1-michal.kubiak@intel.com>
X-ClientProxiedBy: VI1PR07CA0229.eurprd07.prod.outlook.com
 (2603:10a6:802:58::32) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c017482-1196-484b-57a1-08dd92d1d407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nuwWFMC4bE0UcmwOXf458BvrY2/34XhBWPANobJEiRdSDnzyLUTvRwj/fawV?=
 =?us-ascii?Q?D4HfdJ+cQ/Nfj/rJPF9xmXao3fPzY8lxt8JTJMUSMloLZ/pb34jwE2UlysEc?=
 =?us-ascii?Q?ObCluIzOW6XeGHTWoljaYQQ084OJPQZGC9q7WxNYucg1oXGM5fou/NPvOFZO?=
 =?us-ascii?Q?oxxjYxQQc50dMHB5nvNaTT3MdM1Ixc72JxzNOkTRkrEIpDlOX0rgHDeD7tS3?=
 =?us-ascii?Q?XtSQhCovgiUnLPziMutfH4KD+8Cs6hkwWl02dM4XTlNVzeQ5ifpuhxRq8duW?=
 =?us-ascii?Q?hohcKgmI0Lw9dAeZxCIaiSb9x+jOHjKdNRJhj4UnURWJwMb/I8+jQp3ShY0s?=
 =?us-ascii?Q?Xf5Vg54f1rGr8x3sIzwFln6hPEc8i4xQmvJZa1314UY02qVma264h4rWVSTl?=
 =?us-ascii?Q?rjtAInJUEq65dCTzldcsfAb8dhCmeifnhHH4f0RfKLgzFo4K7Jr72fbghjjp?=
 =?us-ascii?Q?aM5CX3LWj8cWQnodtc67+QRjFwJtyZjksqK0p8GTZxYsc9CCTo2p8YcWaTMb?=
 =?us-ascii?Q?cOnR5jAQayR5MgougXjQAioRhP42WB9De55vLMjLkkD8Be7j8M5yocZpESMo?=
 =?us-ascii?Q?JH+sdTw3h9inPkbNmoKM5eNLOXMc2F7Ph7j1G2nNNmz8mpi1YaNn/tupBaWY?=
 =?us-ascii?Q?V00+tiUHTj0EE1QHB282q/XXVbSKff0ZSqOpFybmonkez+Gk59UqHt87rWxB?=
 =?us-ascii?Q?/Q0bB16gSdSKsOIIcE7V2i8dAUpOqt7Zv9IJFAPezxVKnV4IF2ojFFvmYxD6?=
 =?us-ascii?Q?GQk/uS9fLNvBiuPnjVT29YQ/pQhsx9nm7dYhfMpSJ8i9rBReTXvvCz7nrkkv?=
 =?us-ascii?Q?ZLkLXfAzv+6FfqI4KSlCDQzsfWImIyJPuGROkWOGMen0eA46sDggv5wkVLfX?=
 =?us-ascii?Q?dzcyyvO2A3jlXvKTl5Qb3jmqgA5+npaegGFsKNW+YM3ToU+Gpzs7MCuLjGuS?=
 =?us-ascii?Q?PsPNuvQqH2V/cH2OSjBUCCBmSEeabtZaxeMRQgCfBwnaLhLKYXCWqPV5FZ1V?=
 =?us-ascii?Q?pFuv0ogUykKhs7oKEjEKM1VdASihifgrnOAb/COJoNxlYCl12yBRSnGVkq3v?=
 =?us-ascii?Q?c4ArJEhfhebwIcAPmuDV278EfpCAu1kjqLsvdWlWkFmcCfOc9gl7u8D4sjh1?=
 =?us-ascii?Q?waG+1wlulWxhiAOEWkxXGKWK+QdzdGbpTBN3AWDGGO8wNeg8sF352woNUe1T?=
 =?us-ascii?Q?wRzBh8S+QQ8S+Ln4H9R8sdQRISsuHz20L+BwK8LQh9uY4jwa/Y0xleO7Dos6?=
 =?us-ascii?Q?YTQneve10UAcFRJnvEtROGTdjLuyfuUSCg1GbbdFpQf0aU4lvaIkfZz70IqA?=
 =?us-ascii?Q?7lNhio7xiqUweX10pqFH7KCGFJOnpCHOC1r7/PO57dSmQc2CDiQ7Expq5RBT?=
 =?us-ascii?Q?VcnkT5QGBgOoQ0ZQwgLRoLeA9RxwNkaLAYtxK8WCxFAqiQt531g5przZWmpw?=
 =?us-ascii?Q?l3dkBxt770c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wyEIY6My5MFq273gYYIL1wNWPWe6zLfLPm5i1ZuVeU8/4VSaMURXJC9cZlmI?=
 =?us-ascii?Q?4tNhX177bgsydmjo0PD2ySd/tr1S02fVHLE4EC2wCIEZq9+7As+WUkqEQdxI?=
 =?us-ascii?Q?tLdDR7tRxFvEBLAjoX16GutAahXKh7wggQhincrmMvSZq2CreWeJHDQHhJU8?=
 =?us-ascii?Q?3lW21BnubLU130wHN05iIs/zg5FzReOaJYgnG4IZtTsx0tSZwzOXzOJLzxX2?=
 =?us-ascii?Q?8nOzKuIMWw/9p+PJz1XsjLmehpzDjmPgAUH8wjVqMZoReC+LW0qxo7nWhDEC?=
 =?us-ascii?Q?BP0wRaWx4a/9WnWTnDofijrBEUEirzm5AOQXlIoQsf17oqWl2HjkZjGogOOG?=
 =?us-ascii?Q?pwDWDNfOGn4p9BYg+tVz7cTRm3SvBritsJJEqLyiCsnDBXPrEw9w8d6Vip7x?=
 =?us-ascii?Q?UzDmu7Y/bXsfxkm/hLImLdpoAuMnmzHQtgJ66jasGUIYyF/j0WfH/nGxGTWP?=
 =?us-ascii?Q?E5lZfCQ2M3867KR2gY1Tk84+eezWmejab3TD16pptxQbXdp9TPS6jryp/MDQ?=
 =?us-ascii?Q?wp69o6AX2mLBmo+Gm5nj+1sjs0oswit3hMMZUJXLWgp2KKpXQc6qV9tX6k8a?=
 =?us-ascii?Q?FtprWYJtnqvsebuMbZ43YOf33LPNsPQQxGUK8ZU+hFx2/2QP3p3y6cYjq+3a?=
 =?us-ascii?Q?Hrx8wc+m3dIN2Pu/eNhVEk9KJB29Uele1N1yD6rVTVFXHqlJ/6l4sAyGx/uR?=
 =?us-ascii?Q?Seph1ry33A5MbHW1jRbJCUrRTwLl3TFRukOzxQd9c2MvoPeNqUdsZhYX2BZZ?=
 =?us-ascii?Q?23qjGW1bbhwVPJUciP0b00hfTSl2utUrixcLBsuAmG3C/Xm//57+85rdzSB0?=
 =?us-ascii?Q?vctLrIbpv/JOlY0Vn/V7Dne/m98yIBfXfVtLhEnjdQaQIY8jKfAUBtWk4Va+?=
 =?us-ascii?Q?BZNkBIiFtqFIn+nCCEkOPF3kSZWAxu8+feuFS0Aee0rCkeuX40NZDNx7ytYS?=
 =?us-ascii?Q?jrwMSaRdvBc9TDhR4dKbY3R5REhUeELkQdAkTJAUXoLBtvFuS3QFrB3G/rn5?=
 =?us-ascii?Q?kmineEuzH81aE1YTWB47NUrGsUeNQlDij1U+r2JVSWbgwvpqv4NL2mnM5YY/?=
 =?us-ascii?Q?954Jtf/bKVilwPYIEN7FK5qXT6vqcRcZk0ppAlPrZIIF+OGuS4toRPkpF9cQ?=
 =?us-ascii?Q?ohZauWVulTKxkvSuVPWaXNDOSFycy+kc0ez3XQRUjHvgZxoFALYyTQoaIigm?=
 =?us-ascii?Q?jusViwbq5QW4hCO/UFTrDAOUpXOiibqpMR6K/pwgmSaLRO+HgmwvTqBwH6Ct?=
 =?us-ascii?Q?noBH+/bhND64Pe6NIbDO9RUlb6MTZOdTOX7DB8BSQkT/o+yPEDrtqn3VEA0Q?=
 =?us-ascii?Q?Ahu0z4vusnhgMSBOaOHUMdpUIFOCS5XXHTl8+rz99B1tl2dnWU/5kRuJ2Bl0?=
 =?us-ascii?Q?sLOr8gCRPUGaN1TrD1ChLbLUNVE1pWAWDQVbE7Md2wndGN/FbFeXX4hAyKMz?=
 =?us-ascii?Q?Xk4rvWsXGGeM5DMHuADz48kW/JP4bRuWDiHd8/nK2wRQ2IcE1OJXcN80z27N?=
 =?us-ascii?Q?Da1/Q2dCRXaOLeGK4VTEGuZiU2RcM6eEBJAii0qRhHzcxJDx5zdIoSFEK25r?=
 =?us-ascii?Q?gXgQ2PRfMkrWjrsEq/f+PqX29wbiZEzYh/0QhqgQK7tXwAFvTs9Oh4yiMMyt?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c017482-1196-484b-57a1-08dd92d1d407
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 10:26:46.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFnNJXnYqlNAYE3jZiHbL4RLKy9fCZVZEypHsNnrLanUnpCI/dUU26F9TB/Mo98mH3dvU0TDUoYPmaIr/lJd6UFKPUPRzHYRYZmFLyFxrJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com

On Fri, Mar 21, 2025 at 04:13:57PM +0100, Michal Kubiak wrote:
> The "ice" driver implementation uses the control VSI to handle
> the flow director configuration for PFs and VFs.
> 
> Unfortunately, although a separate VSI type was created to handle flow
> director queues, the Rx queue handler was shared between the flow
> director and a standard NAPI Rx handler.
> 
> Such a design approach was not very flexible. First, it mixed hotpath
> and slowpath code, blocking their further optimization. It also created
> a huge overkill for the flow director command processing, which is
> descriptor-based only, so there is no need to allocate Rx data buffers.
> 
> For the above reasons, implement a separate Rx handler for the control
> VSI. Also, remove from the NAPI handler the code dedicated to
> configuring the flow director rules on VFs.
> Do not allocate Rx data buffers to the flow director queues because
> their processing is descriptor-based only.
> Finally, allow Rx data queues to be allocated only for VSIs that have
> netdev assigned to them.
> 
> This handler splitting approach is the first step in converting the
> driver to use the Page Pool (which can only be used for data queues).
> 
> Test hints:
>   1. Create a VF for any PF managed by the ice driver.
>   2. In a loop, add and delete flow director rules for the VF, e.g.:
> 
>        for i in {1..128}; do
>            q=$(( i % 16 ))
>            ethtool -N ens802f0v0 flow-type tcp4 dst-port "$i" action "$q"
>        done
> 
>        for i in {0..127}; do
>            ethtool -N ens802f0v0 delete "$i"
>        done
> 
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
> ---

(...)

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
> index 4b63081629d0..041768df0b23 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.h
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
> @@ -492,6 +492,7 @@ static inline unsigned int ice_rx_pg_order(struct ice_rx_ring *ring)
>  
>  union ice_32b_rx_flex_desc;
>  
> +void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 num_descs);
>  bool ice_alloc_rx_bufs(struct ice_rx_ring *rxr, unsigned int cleaned_count);
>  netdev_tx_t ice_start_xmit(struct sk_buff *skb, struct net_device *netdev);
>  u16
> @@ -512,4 +513,5 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
>  		   u8 *raw_packet);
>  int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget);

this can now become static as it's not called from ice_lib.c anymore.
can you address this in v2 if this patch got lost and has not been merged
yet?

>  void ice_clean_ctrl_tx_irq(struct ice_tx_ring *tx_ring);
> +void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring);
>  #endif /* _ICE_TXRX_H_ */
> -- 
> 2.45.2
> 

