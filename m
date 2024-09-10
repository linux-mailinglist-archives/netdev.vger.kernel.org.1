Return-Path: <netdev+bounces-127154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C797463D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFEAB2436B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 23:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC851AC895;
	Tue, 10 Sep 2024 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuRfJl+b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13871AC439
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009547; cv=fail; b=Gmx55sz2KtYiQU6nOj1rDsAQHGE5IcrQL4wno5xAZuE8xlmJ4tSHpCOMIavqhIAbY6/ecgVP/2tcGpFcOASGpxfOsKtER5WvW1IzrLlrNzGkGJyafOoU2Hro2yN8aa0pb8tYG3//xVw2p/S4hA0Tn/gNGZpIGusFznb9PNL+eHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009547; c=relaxed/simple;
	bh=hbR8PZ2acS1XbbXsdet4W+SIkSO55HnzvI1dt5Xc87I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dhTvYprxmpLhd/FQebM4RuMvjFeuZlhNTAfo2zns5rc7SOqhEbaZZZ7jDdjEczylrPW3+rQui7o3u66x/YK+zVqzpXxA8fE+NmW4rHuomzm9ohhQyxWQQGXOdGJxPqkELFyPdfuIFDEOmbB3YtITQ9ujxAremxDLJ8ZXvUq4usY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuRfJl+b; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726009545; x=1757545545;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hbR8PZ2acS1XbbXsdet4W+SIkSO55HnzvI1dt5Xc87I=;
  b=VuRfJl+bpVIyWku8/mZhkCVWXUTKn3O+N5drjlx2+EDnA5qcCzaQ/zw6
   IDK4vMRvcIfALmS9uoA1lzZ6ymqgibB7iaIwAr0q0zY9/n2fDfJnMUExh
   5GOHMmKrc4JSsoF5dpXpDEdeng/o5yuHcchdH7Y+fH80QhdafXJAILmND
   3Tlgj/bokn4Khl1D4KMRVFGt+T/HxeOozJ4EP1S3DQKnxRghClHXbmyie
   Z7z6GrOloU1SmGN7uLd6PnuNH2TJysQ5kJYgoiTcQTWAJNzb0HJMZoVh1
   bm6WjtjUf+I3iORzzRKbMFRUzy34lArje/EYUXA0pnbpu06Sx99OhMI/c
   A==;
X-CSE-ConnectionGUID: vvEOUKRsTnm30SYzPGZFTQ==
X-CSE-MsgGUID: gun3xvQ2QuSLUXDTiwy6mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="27704416"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="27704416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 16:05:40 -0700
X-CSE-ConnectionGUID: ET3QSOyWS0KmqvpCL82kiw==
X-CSE-MsgGUID: o3ngQVaMST2lcMzc+10EmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="104638811"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 16:05:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 16:05:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 16:05:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 16:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYJGSvZiKclDRyPuPQXyCEdSJROJOLiqTiHKFQMCfhDOd949bHnuIDlpV3Mi786dC2kfBP+6xTymGiEjBjBBJXwOdRtoUWoZgpGS1I+MhiaceUp4yPWIUAkS5TuE4b4LhUxJLd64281roADLPD1KfNkLl7iki8WlViUUfM2lrRxhj8VmPy2VQvv1Xvtx9+aJMJwQxVRA8teOYNccfq/Ge1fvcJ2J+8dzoMPyFuoF1GBiTLS/YcdjtTBwfecHLg+4d7diHLNpgBZ+0oV8xlbO2RSfWXYVxyxuNicKQAu3vrvdEXOWL/vQ0twgFLjMo8wbjIaF+qQD31Y4rqO2rzo7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHrJ/KKMoXC1+ahFO9JwpywVcL17d2+blSoOGO2S8fA=;
 b=NM165FSHF7NULMLmrifTG602RI6QF/F+aa4b5fc9JgiQQrO0mmQ2GNSPIpMOmhHbx3rH2PpMu8macryTyKIKQ4cnf9GStv2lO0SE9Rodb3UeS7O7UoU45i0m+/UD68nXy86uhe1ypFcNnce29CIlXom2YZCazJMuepMrvREksKmqJPwalhx3DAoswzOZJBPDuoAiCmI2y7YUzlCgRlIrqx1mCFUal6w8PPY8+ufuH/GPta5t0KxFUxvlPq5JEgsfK4ABZumTvUj0dz/Q9+O72e5XaMbAEvVp53bS6nSjMJRJ8izmHaEtA7Kb9KeiiWzIgNIUaPfio6OqUBqyyQD/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 23:05:37 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 23:05:36 +0000
Message-ID: <13dd3449-6a28-3fa3-cfde-1a34b537ed19@intel.com>
Date: Tue, 10 Sep 2024 16:05:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v3 0/6][pull request] idpf: XDP chapter II:
 convert Tx completion to libeth
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <aleksander.lobakin@intel.com>,
	<przemyslaw.kitszel@intel.com>, <joshua.a.hay@intel.com>,
	<michal.kubiak@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<willemb@google.com>
References: <20240909205323.3110312-1-anthony.l.nguyen@intel.com>
 <20240910071649.4fba988f@kernel.org>
 <c3ba53a1-0de6-7c15-8a74-415e91e55edc@intel.com>
 <20240910144456.67667b69@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240910144456.67667b69@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA1PR11MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e7266a-495e-437e-81c3-08dcd1ed14c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmxCc2tLalVQdml3Ymp3K1hYRmZXdzBRdmJER3VLa29udkFmUUNUbGFiWlor?=
 =?utf-8?B?TThQNnZoNGVtME5jYkJEMXdUVWdKTEdpVWJKS21KVXVtbVJVamtxVXhvam9l?=
 =?utf-8?B?cmlXOFJZeC9jUEFQNEVZMVQwQlhxWEtvYzVVdzVrb1phZDgxWjlOU3BySVA1?=
 =?utf-8?B?clBoWmc2UkZjczBSbnlzUGtTM25DZk51QVZwOXkrTEc2ZThMb3ZBcmNJWC8r?=
 =?utf-8?B?bklKRklwekxXakpzVzZsMlN1ZTE4VVJxbUNuZFhGaEdmN0QwbzZjQWJLVENn?=
 =?utf-8?B?dGtuZENuRUxQazd4dGFBd20vYlArdGZ1a2xzaTFwTGtOeUJWNzhsZWZseDA3?=
 =?utf-8?B?WWJxdjl6ZjZBYXcvNmkwMGppbUtFNlpCMHVKVkxGZFVmWUd1TWcybDVFNmcr?=
 =?utf-8?B?b2Fma1VWWFcrR1QxeEUreTZHWEZGZHJjZXVJSWVIOFJFdFZpb3RBcmhwUmFi?=
 =?utf-8?B?cEJBSWU3a2lGbXNkbzJvVG5Cb2tIOStjL1YzQkdhYUZNZys5K1JPVEhwNXVO?=
 =?utf-8?B?Ry9BNDU1STEvYXBTNjNFd1gzaHRkbUk4cE5yS2dOVlpYNTRFdC9PSCtpM2VP?=
 =?utf-8?B?SXQyUStBNC9WWEFaTExmZUg0Ukt6azlwUmExWktzbUFRSWl4bllBcXEwWXRV?=
 =?utf-8?B?QWJaQm9icys0MlZOT1cwZ1BqaWNnUFBKTEs1M2duVEhvUHRMQ2RxT1VtbStI?=
 =?utf-8?B?L3JEM1ZkM1lscExGbFlCaUFySmQxU1ZyU0RsYWsvaCsxVlE3TElZeitRK0R4?=
 =?utf-8?B?YWRBdDczSVBnQms4QU5UaWxqUXo2K2FLQ0k4RjNXSW9ZVVY4NTNZRlc3aTJh?=
 =?utf-8?B?WU5PNlA0Q0NWRm9PZlFuZnJNVlAzdmRPTEo3b3JyeURFWm1YS1l4dHZkRkl2?=
 =?utf-8?B?eEFGMEd4VzBGVXd0MVFodVVUOFdOdlRWUUtXNkRuUkhBZk4vZ0xkVHR5by9W?=
 =?utf-8?B?S0s3MTdhbEMxblFnMGUrai9qdnpzZUdiV3h0MDFGbGNac0dVN0dPK2pNQVpt?=
 =?utf-8?B?THVHM2pPRXJuSzIvNG5uTk85MUFzQ2x3c3pFa0xNd0tpelVnMERtN2hIVmVK?=
 =?utf-8?B?OVBJcWljdHpDdnJRNmh1U085YnQzeEtUNDlHUGJPUmpYdlNlSE5yWDhLOWo1?=
 =?utf-8?B?Skk0WUFkK1hGT3BRUUdoeVFnd1lGekxqV3dWR254c2ZKeVF0TktFM3l3SzJQ?=
 =?utf-8?B?cS96M2JVa2NadEtZTWZBQzFJQmVBRkVUQU05TjloZ1ljakhCNWg3SGoyREJY?=
 =?utf-8?B?T3RrS3dGd0llRXpQN1VsR2d2OTl0Q0w2a3lLd3RURGRmRkFxMjhwRUpWR0ln?=
 =?utf-8?B?U25tbVM5MTZjMVFqN1ZuQi9Wdk8xci9XSzdaSnM4Sko5S0RBZko5cWxGdTd6?=
 =?utf-8?B?OHdKc2w3TEJyVEtvRzJrLzB6clo3UHhoZC9jOHp6ZmFzajEwUXptUGwxSEdr?=
 =?utf-8?B?MzY2K1lYeUJ1OW1QR2RjN1YzaWVjemJITDIzSXBTdmNLNE1rUjFna2VEdE1H?=
 =?utf-8?B?V1NxWmtLR0xXeEl4a2xwQ1VMYWhmbzV2UHFiSU5FNi81Uk9PNW1OQVZ1bDBk?=
 =?utf-8?B?ZmdRNHAyZ2lvdlpMN0JsNEpyQmJnSWplYWlmVHh0UWFOZ3dOZlN3TXhtQXQr?=
 =?utf-8?B?SG9Xd2krQ1Zka1lDQmFrZm9nUkZhRVhIeFRuZndxYmlxbUk4SGJUWWEwVk1K?=
 =?utf-8?B?TnRkRlMzZW93aHo4a2hMVU9PQXdRb2NmMDlwekRON1lFQnNFeGpxOHdNRlVT?=
 =?utf-8?B?QURFQXhCbUtPcFJmT2hxRW5JZ1RUQnM5Qng1VDM1U3BCdnhTcmxJa0RzN3pX?=
 =?utf-8?B?endBdWIyZXJCeEcrQVcvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJ6ZnBmNUJPSUFJdFJHK3RPVDBwYW1SbklpSjZVYVFIdnprU0tLczFYeEpK?=
 =?utf-8?B?WE5RdmVMS2s0N2FMa0hNODVKTTh4OThPQ29UblBocFdIdTZTa3RRRjJMS3F1?=
 =?utf-8?B?aWhIWEVsNkMvQ1ZlWEZSNXIwOHFpblNYMHIxTkVpUHBvUVFWUWsxSHpVeUta?=
 =?utf-8?B?QVFwa3oxcjdmT2xaRzJLbUFPTkMzRXNDZlJ4V2xTNjhPeXdQbkJkSmRnQ2hX?=
 =?utf-8?B?Y0JmZFRkdFp4Ky9RYUFncXQ4VXdFdG55L1NnMTdnTzM0QnM2SHVKZlFoSVcz?=
 =?utf-8?B?a2JVcjZPelpkWDgwL1JTbUJDaytPYjlYVHBLcHRpVFNwQUVWalZSVXdVaFpL?=
 =?utf-8?B?dXlST1VlRHQ3bVB4U2phRmNBc1ByWWphZ3NFWXBJQjY3SDBXUzNLUFF2NkJw?=
 =?utf-8?B?Q3BkeXNKcWJ2NnBsQVpPZml0M1EweFd3VlVQTkt5WUFYUTREdEZIZDV3Qjcy?=
 =?utf-8?B?ZE4yRVh2U1RWdkJZb0hMZUVDanhvOWhzai9mbTduY01uMUg5ZXFEOWZaL0Ro?=
 =?utf-8?B?SExvV29KVUlBYVJ1SkNXQkpRcktZVjl0Mk5kRDB4d1hFVkxQdkRHd0tmeHoz?=
 =?utf-8?B?cWM3cFh1dXFHcUVibEJGZ3VZeDJRTWFJU3ViVWpyMGNreWp0ZEFLWUgyU3pH?=
 =?utf-8?B?OVhJQU5mcnlvRkFTSlFyYmpLOGtxK0dESlNQcTZWbys3V2g3MlY3OU1FT2JF?=
 =?utf-8?B?dS94V0ZGTnMybjNNRWF6ZUxDaWJpckZyMFA4d09rWGhxUWt0OFZ1YXRzb2NS?=
 =?utf-8?B?QzVsbGdjVDZJckRVOFlFUmxxaEpKMUZsUWNjZjVkVFlWWFgxcXpmVU5kaytk?=
 =?utf-8?B?a1VXYUVEbllzcHFHSWliK1ZMbkJEdW9xTEthQVV0d2xpQXZZUkozMlZqSHlt?=
 =?utf-8?B?OG1rOVN4K296NlBxVWpWR044emxValJnYjNwMktTbDd0NXh6OTJaR2JGWjVP?=
 =?utf-8?B?eGR0aXpzL0g5RW5qOTE5WjczbTNRYmQzbjhoNmI3V3U3MFpGRSs4Q01FejJV?=
 =?utf-8?B?bUk0OForOWE4a1N0MFlvMHorZTFxemNaaHZtTWhJbUlJVUo3cDdaZVQxYjU5?=
 =?utf-8?B?QWJ2bkxrRzhab1AxaHAvZktiTFVhekpkOHVZeFZBM1VUSVZ4VGw2ZGsyV1A1?=
 =?utf-8?B?TTR2NXFvckRHZkt3enFjQlI1bG82VXVZK3RZeWIvT0FHY2Y2bk1ZTnhOUHlW?=
 =?utf-8?B?bEhkWXA0VEY4QlFHeVBaNVRSUG9ybHl4NktUZGZVOEIzZGdlT3pWbmMrQlVl?=
 =?utf-8?B?dnpuYW9rN0NxZG8vUUwwNzFLT1ZlSFFmdlR4eXkya0NKWmNWMTF4RDIrR0VC?=
 =?utf-8?B?emUzakgyL1hCWnBadjBDanpzK2lmdUxCLzMzMDJnREFsV2lPT1pHbWxacFRS?=
 =?utf-8?B?YXNta3RQeWJVREUxakRlWFBvblZJTVlFZENwVjZTOGVEQTl2elBmV2V1YnEv?=
 =?utf-8?B?VEtpU09CclJ2MXBNdFcxZko5UzJUQVRuZE9uMVpMeFpDZjRLRDdrNWxTcklq?=
 =?utf-8?B?bHRoN3J4RzlvQ0VpdkF3dGxRVk0wL1FrL2JZTXg2YVlHQ0psd0VVUy9kaG1s?=
 =?utf-8?B?aTBvbFBzU01uV3BEa0MwWnRpKzJxYkxxSzROZW9yUmxJN1ZxRzhGWSt4VU9D?=
 =?utf-8?B?V0FxM1N4ekcvSHNacUJYWktLaVg2Y2lraGtUSFpaWkswd3R1R21YT1JDY0d0?=
 =?utf-8?B?K3FQcUxCUXJnWmo5VmdVU1lza2c5cUdBdy9NNnJ3UVczaWFoYlBmZDQ2Vmc0?=
 =?utf-8?B?UDJ4dXRQUWgxTHc5OVM5UG41SFkzQWpMcVI3eXlORGdsVDA1MjRKK2d5dGFT?=
 =?utf-8?B?dzlFN3hvVlVQemJNOEY3L0hFV2Y3ZWpEa01NVU1uM3JyOURFQjJaVnBGcUkw?=
 =?utf-8?B?ZXZBOHdSOG1PeWxGZTg5d3RIRE1qaDBpZ2d3eXZNdDBLbE9IZ1RSaXNFc1VH?=
 =?utf-8?B?ZjM2bFo4NmFOZUdTM2ExR1NUT09CSXladGRLU0tnUGgyYmJXOEtFdEUxVGxr?=
 =?utf-8?B?MWZlZ25tWUlXYTFkTnJyOTAyVTFvaUdWV2xnbHBGSlpzYTgwQUZoamw0eXls?=
 =?utf-8?B?cHlEOHdEKzJtOGRCOTY4MXRUcWNvcWowNHlCVnBSUUY2Vjd6bnFvV2RJWldr?=
 =?utf-8?B?aVJBVjE5dzV0SDhkTWNLVHlFVllOdXhHYWV1Q056Uk1KNnErNnVZY3NITG5J?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e7266a-495e-437e-81c3-08dcd1ed14c9
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 23:05:36.7695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqGRXdjH/5RH7QZLZmv3g/HItmGgpr/GFTKdtjRgfTeEZlnTvyZVnzagCYsZcbJSnGBsO5Q2t1jukVNDbe+1n2T/HqPLkE4iQTNimh5Kpuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com



On 9/10/2024 2:44 PM, Jakub Kicinski wrote:
> On Tue, 10 Sep 2024 09:46:57 -0700 Tony Nguyen wrote:
>>> You're posting two series at once, again. I was going to merge the
>>> subfunction series yesterday, but since you don't wait why would
>>> I bother trying to merge your code quickly.
>>
>> I thought last month's vacations were over as I had seen Eric and Paolo
>> on the list and that things were returning to normal.
> 
> Stubbornly people continue to take vacations, have babies etc.
> But that's besides the point.
> 
> Either we are merging stuff quickly, and there's no need to queue two
> series, or we're backed up due to absences and you should wait.
> 
> The rule of 15 patches at a time is about breaking work up as much as
> throttling.  Up to outstanding 15 patches to each tree.
> I find it hard to believe you don't know this.

Honestly I didn't, but will follow this now that I do.

>>> And this morning I got
>>> chased by Thorsten about Intel regressions, again:
>>>    https://bugzilla.kernel.org/show_bug.cgi?id=219143
>>
>> Our client team, who works on that driver, was working on that issue.
>> I will check in with them.
>>
>>> Do you have anything else queued up?
>>> I'm really tempted to ask you to not post anything else for net-next
>>> this week.
>>
>> I do have more patches that need to be sent, but it's more than can fit
>> in the time that's left. There are 1 or 2 more that I was hoping to get
>> in before net-next closed or Plumbers starts.
> 
> Higher prio stuff (read: exclusively authored by people who were
> actively reviewing upstream (non-Intel) code within last 3 months)
> may be able to get applied in time. We have 250 outstanding patches
> right now, and just 3 days to go.

I'll hold off on sending those then and try to get us more involved in 
the future.

Thanks,
Tony

