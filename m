Return-Path: <netdev+bounces-92462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BC58B7775
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BC283E0E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25527171E73;
	Tue, 30 Apr 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnGqITwv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08E171E4D
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484749; cv=fail; b=r5zmC+FH+fVyyvtpBpOmmHVxaMebwWdZcNDTYwHY8TLw9/x5HY1+njiOMR/ivWYWAK+sjVXTxwrYVh9hG3FhLg1NsktDR41xRKtVhG/J6NvQ9WQKQzMQsRx1CgXF0/9MsjQrgqMdZQlGEW0g7H05QbOIwJLgssJ5GJxo0uf94Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484749; c=relaxed/simple;
	bh=hyIof6QTc42jZTLyrXYaZ5oBNX03M4yn19kbYxu0SDw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HpsrPmgTR/O0+8n192VEOahyVs3YgiZVatSjyCP+NHwLOjQXhKSqNqMmuWuS75NwMiZdxfZWAzsz/Tv3bs/1jrv6bJtTJMGiaV4IeR6+TrX8jDPFuHhIoCCdTzufqqmpvoGiQI4Q0+y9Prk1GjfYhkFK5SVvOq0EKdUV+RyRr7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnGqITwv; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714484747; x=1746020747;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=hyIof6QTc42jZTLyrXYaZ5oBNX03M4yn19kbYxu0SDw=;
  b=nnGqITwvdnlDZMzW7cUBJqGwBYNwIYCx6leX07JFYEBWN14K8S24RK9N
   3MfFtnMJzp0aFZTNdCtM0fJJyS5S0WwrgKSO+ORx96mUqUCR7/2bwmlcq
   L+27F+sC9v7lmIp4s0gqG/WzvgIpgy1JDqulaZ1VAf7AhwO/tAzWZqMOC
   Wg+6J2IMQOBg15kIpKzfGZi5UKF0lbHimUz/28ePjPb9+dDO6bzy2L79H
   nyowxqiDcGQ53JqvptEv0b8CYanSeyk/3wVrxHB5iIa2vGCRmswR58Zqu
   m0gEw1P90d2VhStEmRydL5a8cVDinG8uAPOsL0v9gq61K9aRbDi7+IWGa
   Q==;
X-CSE-ConnectionGUID: S5HL8kd3TBm2Kr+dogLtfw==
X-CSE-MsgGUID: sQVc8lmWQa6ws5XMZL/fAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10051769"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10051769"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 06:45:46 -0700
X-CSE-ConnectionGUID: vQwR3kaTQNG8aB2Sl2kC1A==
X-CSE-MsgGUID: JqhhRJi5TI+s/SpsOnE6sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="49675875"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 06:45:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 06:45:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 06:45:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 06:45:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhQ4Gldj8822ZWoAmhngMrvCse56uAyyhfbVGjgjecYKiRzFcnizNvbotQE3gL1XNo2Koa8v5UNw5dcxzSHwaTMT1AxauEVm6AHoH1J9E6PFP+zYTnjsT0gjZ2Ug0hsKO9ROanbnuLc0AacIQ8KSj5tX6l2a2kDuVrQ8Q2z7Z4nCzHB+VArscVm+t814pnD4fYt01gdTG80qxWPbWMU3z+MAta2Gt9CBsgNpUM1g738J+RXwbHGHRK3RCWPnvvCQEfgZWsYQDd8006m/xGgNERuBCmfGaOuIL+3UAuycCQuRfhOfvQh88fp9ipcqSa6sq6xu3c9/d6/nZdB1vlny/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLKvfhgbe5KEnfvVILHr6exyu04Yhy4+I/0xdd4WRJk=;
 b=TJRaKNBj4zCPihaFXMNQvrP3fPcIgASyVnDjfbi5Fpyq3levt19yKEZE8T/VZLIMHODbRHEjHqhhiu5P4SISh/18f4yF2+txx4A+W2fjdaws7FcEuZNKnS3e5tbHaNJXK+GxmJo8O7UPD1ZoNB6ppJr892Yx9XcZs/4nQYKRps1z8tTaZIMZkfGfJtCfs2nqAggqDMFZtIOM5si/J9y7WY2BduxZVwfHvlerIBKbtLgnFFmCYsfmzB6ch/bmHJfXSyfmDphbH0opkIK+a2Nv04jFd3UNOYNEoz41k5IpDODg1ALRfvLkBSgil6QKoWhjR3gt0MGDe9N35fEInZuADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:45:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 13:45:33 +0000
Date: Tue, 30 Apr 2024 21:45:24 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [tcp]  8ee602c635:
 lmbench3.TCP.socket.bandwidth.10MB.MB/sec -21.8% regression
Message-ID: <202404302139.175c602f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd5045a-bb02-4224-33c8-08dc691bce98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jpLQN/d0qkmUbRZHTXsiRbK2zJp7IR115k08nRyzQaBPiB4l+KtnGgUjTq?=
 =?iso-8859-1?Q?f+L+KL6m3OmDF3Spjm7VbhzHwcW3nPgbE1CfGAxBl87U0TpDABlNGh3TFR?=
 =?iso-8859-1?Q?MQ6/qcVNtB5EywRHr15RUhLcjvPUGL3lUNcvJrzMvZ8kzqc31vwmi9RFwV?=
 =?iso-8859-1?Q?6lom++jl4M+pOXQ6Dwp94QlUHp7vK3LKLBgjSpibuTgAkGqcAlRQK95tqj?=
 =?iso-8859-1?Q?aMEw3Qs4HkxrMNWmVIB4ExM6/+7o1o2cbpx5MCtxWgQiyQrBGIXwbYP/Lk?=
 =?iso-8859-1?Q?yK0DIqi+gHR6RhyD7mtDqNmKqiP8w8JnmzO6EdEyRSFjVLykSe3pocXcSe?=
 =?iso-8859-1?Q?j2d5g11ctUBPxd2l8dyEUyk8nRGQ/PhUs7ven9fiqHbMCNryHhTOI/zMq0?=
 =?iso-8859-1?Q?OSntNWUVVPTQx57OTQ0C8Yt9Q/WTfV+8DlbyVDARqC8LqPshOyh0xJ9a9Q?=
 =?iso-8859-1?Q?I6Aov4VqBK4gF3ueBz5Co9YULaYHWV8ZGzie+SNWoSHbeTPrq0RxhFpXDT?=
 =?iso-8859-1?Q?gugXL8eeda9szVbfpksvzVQ/JTQhxpOvleV+rt1IEqNNnc7b13PwInwMiE?=
 =?iso-8859-1?Q?q7iU+r6e7bUaaaBP3F23mkbM1S9kC061XoCovrpibgpRBQy/EJ91W1pN02?=
 =?iso-8859-1?Q?PP0ZLEJpp8GgDyHJAykBF6UXoDvagwZluIRO+dXBx3/Z3EAYVmcRI1cgzZ?=
 =?iso-8859-1?Q?UN1YCDH9Z/SvFnDSW1MZ0l0Ci7/sI5wK5sQ42ERgRCczFZWGI/prEPRwp4?=
 =?iso-8859-1?Q?Cf0GqsHtcQoJiuTk9lTTew+392BGanYhEtQFg0c694MK9PqBiMzgpjVuV5?=
 =?iso-8859-1?Q?a3xBx7SqlGnxfpzRy/HrkCB76gPQsPCUmIY8hggU5K/Yb9ZvQLloAqT7b3?=
 =?iso-8859-1?Q?q7qyiaKviKlVR+KENJgJlUk9sNiPOCu+29ecwexKpmw8CbtZAr7xOVOcVU?=
 =?iso-8859-1?Q?QQ+df67eYG+g4vyEaxPLqqX9EPfqn0hZ+ahYFRQXQAwD46EKmLIXaU4neD?=
 =?iso-8859-1?Q?1HdwPI6+CRzIqPrXjntcDWulCpAX71skB279+yA07RddvRw/IowzlTN57g?=
 =?iso-8859-1?Q?DnnSZLWkFniCYE0E0NXABn5LTepRXBaBeXUkondTylyegGEVMcGZCwegVh?=
 =?iso-8859-1?Q?yl9ZXXi8CmhJztXgRdiwMoaQlyZe1OMlEV2qfzpK/l4TQN8QtkSzJVVOgh?=
 =?iso-8859-1?Q?o/gQBFYQDOKpb2QS3bDKEXwM3nvBTGzK2XHDMmtKk4KdLPPPCAkCRjeN8t?=
 =?iso-8859-1?Q?8hoQ+XHSLS+hFyy5gpkFNrMcTCySkrfAisCA76QiM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1BubHrKPvaHGN4jyUUXIHwJ+5VMTnroM7vM8Sp39SOWaOj9cfD2qZmLPx/?=
 =?iso-8859-1?Q?kRcvCpVbFSFjcIfXWGbSkqP/9HIe9AifZJjrF2jt1VbN3D0vSaICLyCByL?=
 =?iso-8859-1?Q?wlITvydhcqKkc2EHgqdBEs4qEcLMtIgr22mnltffQ+OInRAqtSC8dLRcjj?=
 =?iso-8859-1?Q?FsARuqY76vJUcLUwwL8c7Z3/UrT6ZaukYvWBWx3VTIJ8MQaQYbWheD5er2?=
 =?iso-8859-1?Q?oVs8IPe6fIo4qENG/1PiyAkQg4Pck7uZmmWk9r9SS2ApyuWeoSvuxDj71K?=
 =?iso-8859-1?Q?8yHQmaKXIyvoN3XhsvJWbt1WrIQf6EK5PmicAy+6NMUwuWKGttAsoSlqGh?=
 =?iso-8859-1?Q?CGzIfJu66bcAVSbwwe3TN/1NbG41mkY+31L+NljDXyakEvLqxcptQkl2Hd?=
 =?iso-8859-1?Q?5OV/emegTOepq+upS/9ii9AHVk1qNKhiZ9tSlVg+9w6jH34v+fsQvdqd6Z?=
 =?iso-8859-1?Q?NDK0dGjxAf8RNr+Wx1nWHHHBnLSa5cYeI0QXGd/CmsN6a9T3oKQHfHiEyK?=
 =?iso-8859-1?Q?sxPHXvVH2TTQou2oP9VGcqD5SNO1SP5U20unbPB/dc1YpvCe2GL910S3kI?=
 =?iso-8859-1?Q?UZfS/Oip2H+SuVEIhEeFg3ypTSKI4VROaSB3478DZG+Mr/peUv8jbb8V15?=
 =?iso-8859-1?Q?61Pxkq70u30UEzX+kzXu8ytOs+ji0KzNGmhgl057Lfu5DQRLkeaTNIy8+F?=
 =?iso-8859-1?Q?iCLDQrNeKrBgqGXmP/DGoeC9r/LVrJZuMOjeh0SzNMZuguK8to/nGB5ubs?=
 =?iso-8859-1?Q?zLWAL++ZszSCpHYJquo8sHtHyilv12zrPJy3OoWUoeo0Q1wDJAyNlRxAtO?=
 =?iso-8859-1?Q?0xwKLVenm2jrBoP4QCeIdy8U2v99I8A5yvJBQCVEk3lPe/AbGMThZ/favQ?=
 =?iso-8859-1?Q?7j4UQDvyNuCwmKXnSHQl9pdAKFqK01e2vr9OmBxBOjU9MPWqkiN/bwb37p?=
 =?iso-8859-1?Q?6fXgG1tOLqaMvcUU3AjO5wBMVEbmGbLBIY4IhrL8OI7Xq2F2zWqkEQm2Jm?=
 =?iso-8859-1?Q?tsyP4gWUyhh3WlIa2wLqB1S3MrAv3Z765mpvL6CnmfuuSgavQlHrhW1oOX?=
 =?iso-8859-1?Q?LkUL5ROdKFhMRtOQB0AGL43y26I7K4BjvD7IkZdtmnBbb9jmAgIIQ5TQI2?=
 =?iso-8859-1?Q?/nFCraqi88R6lKPOGThWX8ysEYA4T1JzDPiKUYKX0yvaY0HjfWWj1WLtRp?=
 =?iso-8859-1?Q?3HJdIeOaFYsaUTCbXUw0xdU0SCnVKhSmyW6cB4fgtIZ/c45wYdbhMuPBhG?=
 =?iso-8859-1?Q?x5DOK+n+zpAu4CKJiViJ4kTCyNeZ57QUySZRiWhHqJMyKXXFxXzrhQKZ72?=
 =?iso-8859-1?Q?ZvTs8PQczQskveOzdzAMsa/i2uJWdl9hVJVswaeiITK/w59NwFxdlED+/w?=
 =?iso-8859-1?Q?KeZIoxo6dzVjujFHzaluaReB2y9RZhZ8umgdOSPr4lbfRAZIhcNbRRWNR4?=
 =?iso-8859-1?Q?xiqWNpTzyszBhNL3VJtwjxB4RikyFLIbEDmRtgEXcjvysFADM/5hWaXax/?=
 =?iso-8859-1?Q?JtAqv/1aDJRJ8CEsolRMA+WEncBrqODc/Nkr4TLZiBw/lOSf70qLpZ3xgJ?=
 =?iso-8859-1?Q?O9ngwEGnzn88CO0RVSLlol4FvDZskxwmIyVz/CXEa995lqFSJzUazmBchp?=
 =?iso-8859-1?Q?cpGRdVdniTo5U44HPqg2w3hTL593hcF5thr0SSLovD7OUOXAp/G7TsZw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd5045a-bb02-4224-33c8-08dc691bce98
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:45:33.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKdbcb84IQlNhzTZgH2hSapV8IRLqUD6eJPqFS61GHaUVubmYJsQBb6odL2lzoD4ZGrwd1d9UhdKTAS2714WeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8468
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -21.8% regression of lmbench3.TCP.socket.bandwidth.10MB.MB/sec on:


commit: 8ee602c635206ed012f979370094015857c02359 ("tcp: try to send bigger TSO packets")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[still regression on linux-next/master bb7a2467e6beef44a80a17d45ebf2931e7631083]


testcase: lmbench3
test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
parameters:

	test_memory_size: 50%
	nr_threads: 100%
	mode: development
	test: TCP
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404302139.175c602f-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240430/202404302139.175c602f-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-13/performance/x86_64-rhel-8.3/development/100%/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/TCP/50%/lmbench3

commit: 
  d5b38a71d3 ("tcp: call tcp_set_skb_tso_segs() from tcp_write_xmit()")
  8ee602c635 ("tcp: try to send bigger TSO packets")

d5b38a71d3334bc8 8ee602c635206ed012f97937009 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     50684           -21.8%      39620        lmbench3.TCP.socket.bandwidth.10MB.MB/sec
     10.17 ± 41%     +83.6%      18.67 ± 15%  perf-c2c.HIT.remote
      0.10 ± 71%      +0.1        0.22 ± 16%  perf-profile.self.cycles-pp.__tcp_push_pending_frames
      0.66 ± 72%      +0.6        1.24 ± 14%  perf-profile.self.cycles-pp.tcp_write_xmit
    965580 ± 83%    +150.9%    2422689 ± 51%  numa-meminfo.node1.FilePages
   1617434 ± 52%     +91.0%    3089919 ± 40%  numa-meminfo.node1.MemUsed
      3863 ± 14%     +24.5%       4810 ± 11%  numa-meminfo.node1.PageTables
    612236 ±149%    +218.4%    1949210 ± 61%  numa-meminfo.node1.Unevictable
    241348 ± 83%    +150.9%     605612 ± 51%  numa-vmstat.node1.nr_file_pages
    964.36 ± 14%     +24.7%       1202 ± 10%  numa-vmstat.node1.nr_page_table_pages
    153059 ±149%    +218.4%     487302 ± 61%  numa-vmstat.node1.nr_unevictable
    153059 ±149%    +218.4%     487302 ± 61%  numa-vmstat.node1.nr_zone_unevictable
  51738871 ± 15%     +27.3%   65841641        perf-stat.i.cache-misses
      0.45 ±  7%      -7.5%       0.41        perf-stat.i.ipc
      1.29 ±  2%     +17.0%       1.51        perf-stat.overall.MPKI
      9.45            +1.9       11.39        perf-stat.overall.cache-miss-rate%
      2.67            +3.2%       2.75        perf-stat.overall.cpi
      2064 ±  2%     -11.8%       1820        perf-stat.overall.cycles-between-cache-misses
      0.37            -3.1%       0.36        perf-stat.overall.ipc
  51471548 ± 15%     +27.5%   65638078        perf-stat.ps.cache-misses




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


