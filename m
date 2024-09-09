Return-Path: <netdev+bounces-126679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73613972309
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C117E1F249C5
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BE189F33;
	Mon,  9 Sep 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1DeGKYl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97790171066;
	Mon,  9 Sep 2024 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911791; cv=fail; b=GC1UEb8/bQXoGtMNT/HM2k1gn6a10O0zATfDr5ODqFojqwS/weqF++PVmN0vKRUcND+QvEee6ZDljiDqGZQ3NJSNcrysrz3L2QLAbt9V6W3437goEK3uH1X5uT89BS0JJ7T/0YE/l3XY+SRZWNrrrNPJsp8mkOGaj8oWSzPPP1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911791; c=relaxed/simple;
	bh=R1Bsv2abPwdriGBsvTHBWNouF+unmOVJ7d6g5evdkco=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Skx2PlXYuSjUx1bbLVkaTHQD/bku/6xasR4xxGcYMsXizCb5Bh+ltJ1EGSbYnEPBeMLk4kEB0H6+QEFb/AAJCjwplKFxIkwTZDxrLlVGQBHHpy/Sk2uJyHlYpa62cTvw2GKNb17Uqogvr+LgBB6FY4JTjsWeesb8Af+ZDBBFF3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1DeGKYl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725911790; x=1757447790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R1Bsv2abPwdriGBsvTHBWNouF+unmOVJ7d6g5evdkco=;
  b=f1DeGKYl5Rr8eaGy3LSfF7qgsq6RKcQy7AOWGwYWbg/jVLpap2rr5Pre
   xZdP/r9xAIrU1Zx8XNBm5BFBbmah131rJJuR68CVMVrf9JDNWn3QUSaNq
   t2OmSNmAoy2HLImEBchmuGP0Pn6qmABU0FG2OGy9wso6pMFG4+RxqKRhx
   OzJIOvUiJob3h4E/yQuEF2ewlI/65sex7rRakvb/Uw6/H4VUVBGLvYkv3
   n96kA1JeXs0F7ZruSibUunMDEwuSBixjJZz5viSD2nVCLyB5csJKVJ8JG
   Ogk31asxhb1d+NuKSu+//VJRpPs2/GvATF4evRcMZv0Odp3WNF20VyfqU
   A==;
X-CSE-ConnectionGUID: D6qG0uUwQzCfRR0z30y4Sw==
X-CSE-MsgGUID: qBuGOe0gS9W87cqUCipdqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35770906"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="35770906"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 12:56:29 -0700
X-CSE-ConnectionGUID: Tro7bK59QV2Cc/fLUQlE/Q==
X-CSE-MsgGUID: sO/Vgt+8Qw+3uoeY8tgQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71181589"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 12:56:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:56:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 12:56:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 12:56:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZvU3WilW9U77foglYuZ+aR96bF8K4wKQL/jbD+f0gGzQ1ALf3j2v0d8BidRsJsjjNGQpEIPt9q82rC1okFxij7su4I17saHBXI+y3uQC55/mWPFcdJhnYNcATD5uORpIFMDG5bwe8v31FvopwrsY9Ev1x9M1as2czgEWU2ZVPzqjmAyaFeDWIbO5EsVUJSZRUJzavNKjJ/8lRwkKkvGIv4eC+TPL1ZCFd/KTqOIEs37vRVFjtrliUMvpO3dDftlM5Y4hMWoRSu1XV+fwKlXh5cRtMR9T5A3lEcFIIJAtrNHcrgmvqLoBUXU4+sBZnQHVr/RpMi1QtaLKPhOPL6ZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uuim5sNQ2nsKBK9pPXcdb1jzX63J8LPHvUkAj4pOoQ=;
 b=O4DCjHnrDD03AstwzaBxghVOmwETiq6WoXxrTccptQy2LZHwZHUK5vPxBRqeedDG3jDfl8gSygKvMn9va5T3mVVM/5nvSgCoU5OziYeu8/EG/2ohPrgWA8prcRUkWO6i/bjbIB11COBmIOPoIehBBtQ4Rt/Z1hPhZxQlPsBSlXLXg6CTmNphsReGnivsZUB1pqNcMu6qMlcRYeHzY2ReMwxVGrW9s16Ly5sCk8Kao/C9l+7QOoCJpmuBlJVkvMMwj8ndjm+5aP/ghTJJOTsBdOIT6kN0iHZootyhLmZw4LwSJZ6gMifpT/WmPtWcE+k0LyF4k3SZtUprdZgVhNpM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8707.namprd11.prod.outlook.com (2603:10b6:610:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Mon, 9 Sep
 2024 19:56:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 19:56:08 +0000
Date: Mon, 9 Sep 2024 14:56:01 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zijun Hu
	<zijun_hu@icloud.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Timur Tabi <timur@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 1/2] cxl/region: Find free cxl decoder by
 device_for_each_child()
Message-ID: <66df52d15129a_2cba232943d@iweiny-mobl.notmuch>
References: <20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com>
 <20240905-const_dfc_prepare-v4-1-4180e1d5a244@quicinc.com>
 <2024090531-mustang-scheming-3066@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024090531-mustang-scheming-3066@gregkh>
X-ClientProxiedBy: MW4PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:303:86::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fb2a70-a86c-4a10-d456-08dcd1097251
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D+UoeCIDoVNcrePdoAL8C9ZMbUmHVzQK+kRgT4VasetGGOpvJoWbkyGJFI+U?=
 =?us-ascii?Q?uJerSSBO56doLfRX/bFXvKtImsDVX2vXBwBlt1Mx5arFs+YnwTy1MYThcpDy?=
 =?us-ascii?Q?PyzFtr2amgxFyZIpaALw4XtY/ZVD6RpNQUBiwR9ozl4cUCyIjdsOaCOCYEOG?=
 =?us-ascii?Q?BxFW3qEgLtvnxjmPALFdhq7yQfxVjIbSGpcF03L9OImB/M4vWYjRfPerA8le?=
 =?us-ascii?Q?sQn+C9gKJjnYdlDH8qA+ecgYly4cpxDW8M1q2YcQmu/kItj76KRIxqkSF92L?=
 =?us-ascii?Q?u3mSpyzAMkApdFZ7VXlFll9C78O27zQzoKQmLzKuU3rYkaNLDcR8ZzkG8ubi?=
 =?us-ascii?Q?NYzhKKgO1OpzinOc48WYMD2yZ/lW7duWZu1Vh13AytrGl2U1NqFZm2Ar+40h?=
 =?us-ascii?Q?YxY25QTEx119JhL0oTZp/s1Eo5BQoIkP8kwYJjcrSmT6tSEEH2d6m1KAqVn/?=
 =?us-ascii?Q?OF/vuqR70+xB3KvOYS3Ij07O9CaVNE2+metI80XcunP+74iy9bf9ag34jhTI?=
 =?us-ascii?Q?nZUU2ZUqtUKhUB6WXy4jtP8csVVG0jrh/ONy+5NNqiF6hg0Qbjfx5vo/HIxq?=
 =?us-ascii?Q?ode4ZtMM5V5G1hT/7WJRLxLdlqv7g1TAY5v3lLOyaXou5txUFmwwJSkJdEjA?=
 =?us-ascii?Q?rBUTRdKe+nU0EDfHimCJ37vRCe1AQYSjdbMBjEzgMKz/WGKNtYIWeXv4aWrQ?=
 =?us-ascii?Q?ov0pT11UNcFPBfR6ars7ty+JVTdmt2fAgyuszJVstSb0VhctjnPT7gGPmmq4?=
 =?us-ascii?Q?yB4t9v0CYGEKoo5QaYM30uS4xklMD2gnMu7QFuEDkSmWVQop66y2PHLczxuB?=
 =?us-ascii?Q?ToIPOU9Eu/t9hfArjDWHjPXIXQgR6pw7SoJAcB/YdXIn0jvRxV8CZLe6YRah?=
 =?us-ascii?Q?ABgAlynOH7vYfaBru5OpNEFYI9+7dcM4eGyv3WTne/5nv6DyBmNtVL4K18rm?=
 =?us-ascii?Q?Zk28oQynbRAn9Mh5bYtwYUezpnbkDEBQ9ZTc4JAQu4gHLP8Je4DMeqvMBS1E?=
 =?us-ascii?Q?GaGFsuokKwM0HPgM5uqDok7c30Ti5FCMxFht+jvZYjrgWNP95JXNS2TzLITU?=
 =?us-ascii?Q?uPE7FKp+aFw1uZz/J/cyofE3y0pcySA6gceh9b0YIHWnPdwGVxBCVDvsXg9/?=
 =?us-ascii?Q?cRf34uUWZ5gR8z41GQRxVZklSt2GONFnTHlr85bjSK/udCxTGoPRTUmucxZr?=
 =?us-ascii?Q?TNFAERDaKhqEZhELxtPbBb5Xnn8DsejUCcEvEe9QwCttViRX0wWM7iLhjFHB?=
 =?us-ascii?Q?FmrBW75zlyACQeOhTrEmx8nwH2pp03dGXB33ijdIlrMw4ZOeryxxOZHxmI5A?=
 =?us-ascii?Q?cgEUdiztkAfnbQaiFaiVjLphZcB2xR2THpz9is8fKrGnCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txiWQvLIOP8HY7g3rTfcJioEYJZJUdhHD7KbEJg97c03QXX4GnGQCkEXgVvF?=
 =?us-ascii?Q?RWk9lTIj0/r8VKx6fwtdx6qIFi+xy24hazg0COkDdQBQ38jLyPcKzVovHcJp?=
 =?us-ascii?Q?Z369yMwK8G741V+pUvrZuc0zpN2z6PFx1/IJe56Ck7vRni9rx2XL5VrBZovD?=
 =?us-ascii?Q?QysH3kwqQADfCwJ7Affwz98QzJL/rlNvAuVbwNc2mnc6N+zuyfvdYDb5BDVH?=
 =?us-ascii?Q?0Bor40MnCaEHKGiTJ0Gfn3lIkYgkZEnyeHS/F3upSjcqUYeqaTSbk5jvl6Nd?=
 =?us-ascii?Q?LzBxK1OjQ+AU+EI/TzllDg9UewmwEC8WAG6Vc4S6sAhZi4JVH+D7j/YauvBB?=
 =?us-ascii?Q?ExcrFzwNRIczPOFq5n0AfXXmj/VH+lkrvL1EU3KbDUe2/tN6wZ1Focz1ozrE?=
 =?us-ascii?Q?RQWIViUgLrwuftYh8Jmf5wwBak44JnZL8cpYpAXysNHIcQIIgJPWSIH2a9UW?=
 =?us-ascii?Q?nCwYDrMlO2rCB5NAb4IkxDH7pPeFWH4R2cxvDsc88a2sg4OaCVa66CbzaGd2?=
 =?us-ascii?Q?LRlmMuu7OrZmhauyhm+Z83sFdVXKT2bulNYmw5lWx6dDjZGJiJjXXrwo6i9T?=
 =?us-ascii?Q?CQOIIOOXwdgvubHFxC52xBJjAPdcdTnQ19xxSTEysYCGUcTcl/tV7sPVYlzr?=
 =?us-ascii?Q?rhNqyKNdbhi2eNwd/wvdHxxV2NkzJ/IbLCfSpdBdQiLMY2XdXSHSBS+0RDBh?=
 =?us-ascii?Q?SOrRrt1dolzA/Tk1ZeYagbjMlriZ/sRbLcKyw1PUEzb/xphhuuApnntxN4Yv?=
 =?us-ascii?Q?Xwb2TExqWghTBwClZGeSjd1mXjPchuMX5ePZW1hCkorcUDjw4eTrxgKXvSTQ?=
 =?us-ascii?Q?Jq5rlN73TTb6Ru4wXKjP0d0HKKhv33XppBz4TTNdsP1bCaYIk8zy8l1ueWxu?=
 =?us-ascii?Q?wCPQvJofsC4AwmlQ0eQZL4nAzxzI6khWehamfmLvnaQv71LzrcEYSWZ4AXya?=
 =?us-ascii?Q?5ZsQ/9iTvNKzlzvvKdp7o0BTcjlxO7Qf6atYDmTz1+QcSID/mmO5PaP8iBUC?=
 =?us-ascii?Q?AO6Rg3EoHH0Za2WJ3tmY99iw5zxWR45ATE6KypTyvoYfksTuySUkVUM9Ou/Y?=
 =?us-ascii?Q?tYucSZtj1ptcoIgbgeuQdNxhJXI4boxmHPDcn61q8OAd1NMuFPqSRd+uPCYh?=
 =?us-ascii?Q?CISUrAWkKAPiPz5xGKFtsVzT+tVOUjQABFJ7GWqjO3jhptVl+kltQzgV5p5o?=
 =?us-ascii?Q?It7pD3zwcx2MO/RYIEJDy3tL0JfzB2+2dHVEG2PZcuhjvpUM3R8jFyIQp3XL?=
 =?us-ascii?Q?2v9YEDcQ1hLhdPdnkepYR227m8lRPoR88Uxi6OEgA1T2lEw79U1T/0/BNLoQ?=
 =?us-ascii?Q?O+PEZosWSSep0SOVpjc8p1YoHAg14GxomonB4xJr5hywA8Yl6xsBB9NKOGEy?=
 =?us-ascii?Q?Iw2KQ50WVwtsY3E3UmiV4IARSCEWAKecGCH4uVRsw9RaltJV7lfhzgnFYKBO?=
 =?us-ascii?Q?osrcmeW8I0bjIH/ACDhELTEguPfsioB1gCjenZlknj8IqrQJ4JxtaUCYyMYE?=
 =?us-ascii?Q?0znN/L6lLjgvteHbaud7g+K+TK7NaLTg02mPI6R5I4D4Byp07i4qJCYtuzLY?=
 =?us-ascii?Q?PmjfsCOFlnfA1Q/EJUDD8mpk8dY95Yba24ebzUx0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fb2a70-a86c-4a10-d456-08dcd1097251
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 19:56:08.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7lCi05+YNTL2oCUddPODoRdN97ACG6VDv4qfGMqdVZ5Ir0ouuSxDDeipkfp6B7saSdAoG7Hc4eTx6dF8FYo3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8707
X-OriginatorOrg: intel.com

Greg Kroah-Hartman wrote:
> On Thu, Sep 05, 2024 at 08:36:09AM +0800, Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > To prepare for constifying the following old driver core API:
> > 
> > struct device *device_find_child(struct device *dev, void *data,
> > 		int (*match)(struct device *dev, void *data));
> > to new:
> > struct device *device_find_child(struct device *dev, const void *data,
> > 		int (*match)(struct device *dev, const void *data));
> > 
> > The new API does not allow its match function (*match)() to modify
> > caller's match data @*data, but match_free_decoder() as the old API's
> > match function indeed modifies relevant match data, so it is not suitable
> > for the new API any more, solved by using device_for_each_child() to
> > implement relevant finding free cxl decoder function.
> > 
> > By the way, this commit does not change any existing logic.
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > ---
> >  drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++------
> >  1 file changed, 24 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 21ad5f242875..c2068e90bf2f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
> >  	return rc;
> >  }
> >  
> > +struct cxld_match_data {
> > +	int id;
> > +	struct device *target_device;
> > +};
> > +
> >  static int match_free_decoder(struct device *dev, void *data)
> >  {
> > +	struct cxld_match_data *match_data = data;
> >  	struct cxl_decoder *cxld;
> > -	int *id = data;
> >  
> >  	if (!is_switch_decoder(dev))
> >  		return 0;
> > @@ -805,17 +810,31 @@ static int match_free_decoder(struct device *dev, void *data)
> >  	cxld = to_cxl_decoder(dev);
> >  
> >  	/* enforce ordered allocation */
> > -	if (cxld->id != *id)
> > +	if (cxld->id != match_data->id)
> >  		return 0;
> >  
> > -	if (!cxld->region)
> > +	if (!cxld->region) {
> > +		match_data->target_device = get_device(dev);
> 
> Where is put_device() called?
> 
> Ah, it's on the drop later on after find_free_decoder(), right?
> 
> >  		return 1;
> > +	}
> >  
> > -	(*id)++;
> > +	match_data->id++;
> >  
> >  	return 0;
> >  }
> >  
> > +/* NOTE: need to drop the reference with put_device() after use. */
> > +static struct device *find_free_decoder(struct device *parent)
> > +{
> > +	struct cxld_match_data match_data = {
> > +		.id = 0,
> > +		.target_device = NULL,
> > +	};
> > +
> > +	device_for_each_child(parent, &match_data, match_free_decoder);
> > +	return match_data.target_device;
> > +}
> > +
> >  static int match_auto_decoder(struct device *dev, void *data)
> >  {
> >  	struct cxl_region_params *p = data;
> > @@ -840,7 +859,6 @@ cxl_region_find_decoder(struct cxl_port *port,
> >  			struct cxl_region *cxlr)
> >  {
> >  	struct device *dev;
> > -	int id = 0;
> >  
> >  	if (port == cxled_to_port(cxled))
> >  		return &cxled->cxld;
> > @@ -849,7 +867,7 @@ cxl_region_find_decoder(struct cxl_port *port,
> >  		dev = device_find_child(&port->dev, &cxlr->params,
> >  					match_auto_decoder);
> >  	else
> > -		dev = device_find_child(&port->dev, &id, match_free_decoder);
> > +		dev = find_free_decoder(&port->dev);
> 
> This still feels more complex that I think it should be.  Why not just
> modify the needed device information after the device is found?  What
> exactly is being changed in the match_free_decoder that needs to keep
> "state"?  This feels odd.

Agreed it is odd.

How about adding?


diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c2068e90bf2f..5d9017e6f16e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -814,7 +814,7 @@ static int match_free_decoder(struct device *dev, void *data)
                return 0;
 
        if (!cxld->region) {
-               match_data->target_device = get_device(dev);
+               match_data->target_device = dev;
                return 1;
        }
 
@@ -853,6 +853,22 @@ static int match_auto_decoder(struct device *dev, void *data)
        return 0;
 }
 
+static struct device *find_auto_decoder(struct device *parent,
+                                       struct cxl_region *cxlr)
+{
+       struct device *dev;
+
+       dev = device_find_child(parent, &cxlr->params, match_auto_decoder);
+       /*
+        * This decoder is pinned registered as long as the endpoint decoder is
+        * registered, and endpoint decoder unregistration holds the
+        * cxl_region_rwsem over unregister events, so no need to hold on to
+        * this extra reference.
+        */
+       put_device(dev);
+       return dev;
+}
+
 static struct cxl_decoder *
 cxl_region_find_decoder(struct cxl_port *port,
                        struct cxl_endpoint_decoder *cxled,
@@ -864,19 +880,11 @@ cxl_region_find_decoder(struct cxl_port *port,
                return &cxled->cxld;
 
        if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
-               dev = device_find_child(&port->dev, &cxlr->params,
-                                       match_auto_decoder);
+               dev = find_auto_decoder(&port->dev, cxlr);
        else
                dev = find_free_decoder(&port->dev);
        if (!dev)
                return NULL;
-       /*
-        * This decoder is pinned registered as long as the endpoint decoder is
-        * registered, and endpoint decoder unregistration holds the
-        * cxl_region_rwsem over unregister events, so no need to hold on to
-        * this extra reference.
-        */
-       put_device(dev);
        return to_cxl_decoder(dev);
 }

