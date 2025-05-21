Return-Path: <netdev+bounces-192444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 722A8ABFE88
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C938B1BC6219
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D862BCF61;
	Wed, 21 May 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaWn3arq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A32367A3;
	Wed, 21 May 2025 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860629; cv=fail; b=X3OO/UoxniFC233ZVo5lWxbjRmroLUmqj7r4Vlaxg4p/xQW9U20PDABmAGyuWcOAXxp9LeHNN9J35RS7PM9uq8h3/yjx++HyOQH+trmsPKol9+wwH1WXBwzqB+4CGv5XQFEuqYN7LY/0+VE9yHXjEPCp97hAqBB1lMz9NP/nzuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860629; c=relaxed/simple;
	bh=icKLZIt3ZxIXCah/bTZnqfU/SJmFrUxFUC/pKUifjFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cEFSPAyG4xwCjgsCLNrWkSF2uMOZLAPsNtpcjnnA86yPArjvyKA59oIYCb3kY0rVimRRiMalO2PSeHVavKgJYlUpQ8QjFSWtdMhyUMxgKcKbxeEV1uNIa7XJ/FXmPr4w78XorS0r4elk+rGzxB2r67VtZLgGe3XlgfQFHfVrIao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaWn3arq; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747860627; x=1779396627;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=icKLZIt3ZxIXCah/bTZnqfU/SJmFrUxFUC/pKUifjFY=;
  b=OaWn3arqacc48lfn97FbORiiPfA9BL50Fs1cwI6ejPlJqKsUvKkR2Wfu
   7+sAp5ifa3uV6GslWmkBbSVqgLJj2r+j0emilZcHXGqGV9e+evLNcLbeu
   BgQBnK33fhwY6H18ggQ2x4f8DQEY3GPuMcAw11FHMFd3cPQls+I7PqHbm
   RzCRO0lVDc/OI7eQ1m4ooK567TlcurcAkiKDFhryQeiq3l/qvzO0ua3Yc
   T4vZC6r2P7lItstb2/GgLJhCKxvPLdUjXbh77R4EunvvLWua9/NpMcwf5
   /4OSyV7YUZn0/vKBUaSB9HiLpuAm45ICNQs9eiapLPaxDo0i3vzvdcwrh
   Q==;
X-CSE-ConnectionGUID: 6wiveCPJT5SgWIoRfUV/YQ==
X-CSE-MsgGUID: zWopi06BQXSrZ1hDlBWPBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="67416570"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="67416570"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:50:26 -0700
X-CSE-ConnectionGUID: dsnEEwgYRpGD9f+dHrF8Rw==
X-CSE-MsgGUID: icaO+gvmTEmEw13hOwZKVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="177399805"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:50:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 13:50:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 13:50:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 13:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCUiuoLZb2l5zIouQqtWsIbtHcb5KYbU1UYc+XNVW41FC65AYQ9guqB1sPVdVh4uxjPLZvdvTPtg12i+VKgvPCt4UfzIWiewvcx4H21UPwkbxNdw49EO7in6W+BRgnejUfRPjv7rb0g1EMx0q9AIs0/YnIgD7EyqL9VhcCIUAWEqhtQLOmaT4I25uDM75fweOI2uB+L06+KZCBh4c7UIUOSsWDb4g76fZaCVHoVF5rwnLzWwnH91HPGO846RlzgUG2wLDHgft5iobjpGV2Q8M8Oq2Zc/8xzi+jo6wkcZWXU6RnKgA4nilVv2UjzSkkFH9h+kBcEECAftiH7z6NMrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgynIz3o+avj5K4TVJNCXKyIb6ked/0vT3ISk4Dqkdg=;
 b=YgBzJoetm0jE6Pek8KVasVfgWrdGL0nJciT4JQKNeynMGUKLEuxjPq7ThQ+amziAL7HQOzZgZbyO/HG1kpJezowcKax3kXGu24VeGC5Jg+Wh8NURWZCNMzKTQ4Eft85PlUamhVWYh/WPwD0+gSVwG7jtiErPwHmQXM9hEvtmAfFFUrNCFxTSs5TXOT19OnjEHRML+C9TXKOUJerRMK0R0TdzZtDemicKmVciBgLYoiu9F/KMxFLcmdnYLnWfPvqWyRs64tkT4XgZiDjU356NKpqLWTS/5SQ7rsryIq4thKMIwZKXcGmfTWxh1YjzusKc7TC3l98Esj9pHlxJ7A2E4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5813.namprd11.prod.outlook.com (2603:10b6:a03:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 20:49:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 20:49:55 +0000
Date: Wed, 21 May 2025 13:49:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: Re: [PATCH v16 19/22] cxl: Add region flag for precluding a device
 memory to be used for dax
Message-ID: <682e3c7129fb0_1626e10062@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-20-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-20-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bc7649-70bf-46c6-db16-08dd98a90a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IQW3it3geu0nmqcEsBnhf4MVtUA62JMUeR3K4sSkh71GiupUiuXsv9stHJFY?=
 =?us-ascii?Q?6yfP3YfW2nF1wgw9PdK++0qt0w0HH741b34+eHxxRr6sne5D1qEiwtB5aXRN?=
 =?us-ascii?Q?54HrSAuh6NMVYA3SiwrK2PhjG37W4NK/pZCs0g9qgwJ7OzmO9FOetCSNJ5nE?=
 =?us-ascii?Q?3tizwq/rP6RizPLHY/Fmg3zT3f+VW/ZsPNZgXBSvFkfSpDPEvc62+GIWnusC?=
 =?us-ascii?Q?jqfJcsUd11D17JwE4B1jVxquVBm4s/qqB1W2c/jbabAbmrwVbgbnQA/2TYE+?=
 =?us-ascii?Q?CtZPO9aUR8YQVSOu8f3PnoMjYLAsiLv4SW6GeOkFK2r6ZVXv8R+R7z3oY+Dw?=
 =?us-ascii?Q?6GeKeJmtjy1Xr8uhfj8zTBqEkUl7sD8eMppqMt4oPujddhsfiweKOrMJfuU6?=
 =?us-ascii?Q?dnM1tQkNvwnHmqlkonwglsvFJY+35LVP/JsfWSNYuAjoB8HqbxfgYibIMLum?=
 =?us-ascii?Q?bCR8CGYSnutdtLP+r8+ICpoTgCBA1dNLbqvSfWcSWq6l692XUkFqpleXtEGf?=
 =?us-ascii?Q?uVRNNglFnacvKRcFSuqA68iMkgrhxGD7suK04c882EXNBvoyApyOEGWR7Keh?=
 =?us-ascii?Q?9nCzIvq7I2fa8rkZQR2V769bcrrv3bLM5QonNnr9dRUYSOZr1vfgN44ErqZu?=
 =?us-ascii?Q?iP4Tiupg97OA6751/dCK9CiLPWiiqXH1cy4Tn8iQakn2yQi3uOGyabike/9z?=
 =?us-ascii?Q?UzYQSXpuHKmfuQFBrCQMORQrV+1NjV4UV1iTsP2lkBZge4/WsP5Y5YK5V0m2?=
 =?us-ascii?Q?l8LX+79y7wzR8kXWvxxVV7bKDh9P16G2TA72Z47TNxAFa35OwfZYZAx4l38T?=
 =?us-ascii?Q?UIyIqUzJj8/vtj9fM4/+iTvOMlT7Jf713TXQ40tizlEXQqvM4HME2q/HUcPK?=
 =?us-ascii?Q?Dn1Csm95sTmBITEyYPCnUrTUOeqDJPYhSpG+CEd90wZjHZZTItfS1iG8RKe3?=
 =?us-ascii?Q?SUhd3XUfmswXSZoNnqKW7TugKEAmJAM2VLPlrkTD43zWydec6BnxprUaOfZp?=
 =?us-ascii?Q?h6KaYjGVlGUvL7+FvbP4tezpD/t/E0Wd0M9NeOcZ+79qrBtnR1KDNZBaAidz?=
 =?us-ascii?Q?IqOrzYgFTJU0WrNIzNbsfgb7kAPn3R6ECuHcFAvqtJNnyhby/eAFl8RNmdb9?=
 =?us-ascii?Q?yuL7YK5oiBAvI5trW4qJXwNFgPcsGnbq52VlQ7CPTKgrQwMgYhQdvrhDSknd?=
 =?us-ascii?Q?l3e1B4zQLE9k4ziRF92yyd7dGXLc9s0ZDoRYYZBJi2Q4VNdZHTJCdSDlX43v?=
 =?us-ascii?Q?R/Hrs/k2sGWp/ish5r991k4N6o0dkLydqjButQPQ68ekY3nw73VfUtzytlmP?=
 =?us-ascii?Q?v4TXlBkKD8KnbFn/Zd7FCo+xkSCF4uTLfAJuubH3toi2iugsrCKIvDKyXsO6?=
 =?us-ascii?Q?Wdc7I8juxmoCqotreVSgp9ZftLjKIO9kOVY84MXWvlmHTOGVLeFw65kebMBs?=
 =?us-ascii?Q?jhjgCt+y7xNBfOO0z9TcpQa+V4rkWeoGaaDlq3Fv+Qa0hmPBUs+Kaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0OUSTjMYQfADe9QyVnYt9mzolkbllteiS2jMYKubYAunFfBWDq07gPYhRN5p?=
 =?us-ascii?Q?RBi9MamZ8sxI+2dxQS42GPug3sZE/A2K10vcJgR3bxZCQyLkHCAZGTO4bpF+?=
 =?us-ascii?Q?5HdGNnhMGnI/SQb4UhxVRWeNqNcnrqZr8OhYYfukPLflWH41UyVFz5eJkqPD?=
 =?us-ascii?Q?iOMzdbwW2R7+GDEkJKdAdYWNQsXVAXQrsEzZbr2lz54rJm36c5bsNOnjw1bd?=
 =?us-ascii?Q?SSNc1zELeEEN3x4fPASqLjHHLZfamm3I31n8RHpDn/m9jkwAlgX3ErvJASKh?=
 =?us-ascii?Q?3YLsjYaRdZk01kfZDi5D0hY8b3VvT3O1oG4Js4ibaR5VNtWD8t7JMjFyHjTh?=
 =?us-ascii?Q?m+pW12qnLiuPveUxAvlXbJjFpb58S7Gn0U3lDDd39093Gfne1uQdBEUPFfHP?=
 =?us-ascii?Q?BXqWbjj9b9A4hoCS3qmRKqogfXUZ+sHIU7AE14Cc7xho0X1BGIZaBtN5ByaW?=
 =?us-ascii?Q?uN6WNRm2eur9PGakXZVqOq9zERCwJXJxosxChxweizOFQZudaqt2AyPbHcuy?=
 =?us-ascii?Q?TOTFwnsbM9xtjBQRRyLuJnK2lWbYOSO53weKXPevcKS6pe9M/ow/WOeIgBbb?=
 =?us-ascii?Q?uIEIVGFLdBKYZU7+x3ZGhK+xNRnZbvV0jx1nTRWdgY24NFjdMsdj/bqL/Evs?=
 =?us-ascii?Q?foAFlJT6vQ52my0NSPmEuX83u16h0/6ITVWciakvlPCr62as3LqHCKSGYr31?=
 =?us-ascii?Q?jBqNGFzEyWCyO4dYVIAqpbfMt7CGWqM1NprWYUPaasqnyXGQ1k5L1Z7t5lbi?=
 =?us-ascii?Q?EKq/Svo3ThgwobjWkIhbzckOo41xnT2O1+Zgg0pdlJmKpQ96YvMJF0hqdnf6?=
 =?us-ascii?Q?HKlE6wd1q10UREMvYVGx+eu93kcPyCRd/wZ7RudIYdg+axUY+J4Z8qQx+7mw?=
 =?us-ascii?Q?xOM9sxrGUSCSTXiJsRi3WjOM0E02yDNAQQaGR4mV0E7DqK5Ix1nCPFJ4MtjN?=
 =?us-ascii?Q?OTFcuisxVgPerVkkIi9i7DI05cgr1ccGSPMMkEubrJ5wI1rPLcJozo39rxg6?=
 =?us-ascii?Q?wQevwPoEldTvrbEptK4laMvUVXkicMkcAZpp+ESgPekAd4NIEoBx6lUZiKml?=
 =?us-ascii?Q?5cCseHhES3zPyHPYYQ+zACMjefuoXBHCu4c9XCq+HaZ+4mg6o1atSRmYqFT6?=
 =?us-ascii?Q?ku1olYfTaV4ivJ5rFOCca3XOxGERtwsUimpIcML+DVLd9V/WRYWkk211BOvI?=
 =?us-ascii?Q?N7+PMqcyhVEvI4x6EF6t6oamWSLCsBPojUkX6k4m5wmbJ+Mybk+Y1q8iQHDS?=
 =?us-ascii?Q?rKM+d3e/mQfmnL+7YayA+TPjqh4Qm66ygY39w3iFSd56oIPLLDU7KRcB8YNl?=
 =?us-ascii?Q?KnHln6BXZWD469ZFsUQK4h5PndxoP9GKfRNQ22j3Rx6XddxVqIc6/rlW70e4?=
 =?us-ascii?Q?QFNF6GDaKvM45+sbSlYeU6tMrUVIbVZ+4UGsWkIY3OG7cayshm6BBnQ3Yseu?=
 =?us-ascii?Q?8leiTVJ+J21mVY7f5rqmwSPQ7/6JkFk1Rp2H7J26zmZtuiHuXI4iZlAzMyRY?=
 =?us-ascii?Q?/NUGXpGGJYeDia0MhjxQaQSDPNVcujEsBUi+UY/21QvBiDU7Vs1LjP3g53mK?=
 =?us-ascii?Q?fH18pL0wf8hUgm0hZsERUSOK4TGFLH8PSQYL6qBD2Nn+Gu8/RWdmJfgK7cby?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bc7649-70bf-46c6-db16-08dd98a90a9a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:49:55.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZuWX/ORxw/7TWxyaMA0MhCNocDdzIhCQxaGaJnxmU1B6fu0paaszIWbjuLOySm70FbGpj9IQSQHGneg1LTWgPHJcCsHiYgf2EHTqNc2oBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5813
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---

What was wrong with the original proposal?

+
+		/*
+		 * HDM-D[B] (device-memory) regions have accelerator
+		 * specific usage, skip device-dax registration.
+		 */
+		if (cxlr->type == CXL_DECODER_DEVMEM)
+			return 0;

I really do not want the ABI presentation policy layer leaking that deep into
the region creation flow. Another way to determine this is if devices
hosting the region are not driver by the generic CXL device memory class
driver 'cxl_pci'.

