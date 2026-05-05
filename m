Return-Path: <netdev+bounces-284221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ0hF6x9+WmZ9AIAu9opvQ
	(envelope-from <netdev+bounces-284221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:18:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 581594C6CD7
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 07:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B9493008696
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 05:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF83BE633;
	Tue,  5 May 2026 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bh5YIrEe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E74232395
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958210; cv=fail; b=ei/TfOrlz0YnvjfzFR1mkpn90KpLHMipT/BNZ/KifTzJk39XQa32RyoqW37m2gxnO1i6Q4iOJWv72SPJ8bFowecPAoSXqQmmnNaBIqvZJr6yLpVtxBVxGI6d3yImcZj6WkxGUuXVWDyFN6MvZGfx9zU5Noph1cZH2nbSy+mWiVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958210; c=relaxed/simple;
	bh=fpgv17fk8Pi1/NVgQ/8AfAhtB8n/Uz8bl2kaSHlk/ZE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D2Lln5VxwoZC4MOKb9Jn34Alhh6y62MeectR4Pm+5goXGlxj5RwuD+Uy6x1A6JOqRjy/ILC0ExqTi2SJKMAwuHnPuJ7NuvNWxPrB93wVRjHdqSdLEaB+/ufkxAXaI8JmbsDbBprU40Po0iYqfpzS4OZaUbVPfI70BW4NSk6cBBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bh5YIrEe; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958209; x=1809494209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fpgv17fk8Pi1/NVgQ/8AfAhtB8n/Uz8bl2kaSHlk/ZE=;
  b=Bh5YIrEeckBF29aeERgZA90Xhy+E8RtoTt7xinG0LwxIE338rAVRLW7K
   iSvnnhdmbsCfjyUCd46MCP9jFpo2y3k/+pYPkhHTPFaYK3e6hQVkJKW4K
   1mrTkSyUhorghaZJbJNvVXBlZBJI7EearT9DzvzqlbxMoqEBBW9UJgyIx
   0OPcZeh1J1M1X5p8KWH07BFJHKPJrPwoHN4zg4/gxMwy4k3H3+Xp4lMnL
   9Lg2nHj0ACxGrqOM1xVfH7DF3Dj27ertskqFYNOspO7n7Z58Rd3sRNTR/
   idDoOfP/qPqIqNsYI3eyNOCE3Lwv612A9sgZMO/s1p+vPu+BG6YWumobX
   g==;
X-CSE-ConnectionGUID: O1h8uE5hSRq8yCgCLjpSTQ==
X-CSE-MsgGUID: F4d4U4KvSLa9wXlBEBTSuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="77978463"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="77978463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:16:48 -0700
X-CSE-ConnectionGUID: GSD1DGpSRSSBJi2I8IMtjA==
X-CSE-MsgGUID: 1wQqQ5NzT6mNQavHM/HXjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="235764344"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:16:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 22:16:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 4 May 2026 22:16:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 4 May 2026 22:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU13giQg5se4gRksNyGjoQrc+GDofa3iB7HEWVu7uTYM0FqMMnxyNUT1OmAsLeXla7F/ALbo26yqqPyST+Nv7loyHLdNj1zrYE77QCuj5m+2aLC6trHv0+gQKmn4ozYR/tUuJxkZhx5kCugAb/Sb+t5/1HWoQjf1RPGdbLSB+YRkYs5AOSoXCtBnXQNS9QIq9v76KjdRzIbY0aEEZPVFCJ0A6qW+2/uaXjcO3F7A7/kaoM+cb87P69deefYnESxCzX4TlOrBllMrGH+tbQiNax34fTjGKNvnjCxF+NzeTbOoevvUW9opdW1xffeRdymjUF5tj5H2MvLj4dRvMjcwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JrsbObHIOpaIZiLZaaWBghecj/I+HUuq210M2thnlU=;
 b=JdONCY3mCmxx/PGAxtRjXAc5ofxXP+gk8gDDaq5xGcFhzftJyZnzfzvB3n9UMHJQljKSzVLtk42Dk7vLazGRgfGAmXg692an7cMoMxTMnfVigWGxBPWPuV5AWiBZO3KLEyxHpcVZWMCMlSV6rWzksJBNRU8AAaV9ZIi0KRV/5OulzoiqqdDiZk2pRpdNNrEi3A0M0Evgt18uKRWdZSkHBQI56YRChp9LcYHRLsNFbjpQwqSptPtJD+YZki6gg+fJMoDAsql4rVxeMfVRV5QRS7DCn9dv6C8YdOXGKZR6js/4x7JlCVvWLqiEK6tCPJKE6ja34fql/7gD4Is3w05itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 05:16:44 +0000
Received: from SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6]) by SN7PR11MB7592.namprd11.prod.outlook.com
 ([fe80::3e09:8700:df72:37b6%6]) with mapi id 15.20.9870.022; Tue, 5 May 2026
 05:16:44 +0000
Message-ID: <da68671d-a58a-48c0-918c-c4f1b10b0a88@intel.com>
Date: Mon, 4 May 2026 22:16:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM
 instead of IP/IPV6
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<jramaseu@redhat.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksandr.loktionov@intel.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
 <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
 <44623db1-8b86-4e8e-82a3-46d65b055ebc@intel.com>
 <aflzeKTaOUBy2Xsn@mev-dev.igk.intel.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <aflzeKTaOUBy2Xsn@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:303:83::23) To SN7PR11MB7592.namprd11.prod.outlook.com
 (2603:10b6:806:343::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7592:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d3aa63-7fb6-4cfa-db35-08deaa657f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4FXpLeK0VrNo0htTWx0LI7v6j4IiIKF8CHRf2ZcJc70KftTyVDyeI92Wd1BKHFzd5b40l4X2mKeNRxZLCtB2mFJx8D2wQB18isyQj1ULRWp14raPic46xTzjGAB8GuJTJChV5rcS+uK6zJIj6MxbgdoD7lXzZ+WNfLMUBT0NwB64vlpmESlXrLxMVfDt+WWkIPRXayRO+g7WynwCpbMnmTWfNgP2o3E43zXqz0pmO4uKVk2eBZTBAWvo2R/UL0JvU19Uvrw0/aD8mkt40xSuDDaEPb65pgEDi3tvo8WZIWqWn0m2hp/zpQQ+g3SNgznwMGOVvDns+ICnntP6N4Negk2DtOsBcU37j/3nxzc00yOYrrManRtbeVdash8bpBlbAW8VTQNNZMDO0gdbaIyjf4UCEhYc63K91eUHvers5qtwg/Sibqp11QQNUxGrx2lWwEoeUa34fJsb9kwVMVXWkZ5GE5mXCXU5i54DfsQZAOGqyRgT+eY3x2krupVxgwrq/DB4431BDQwv/3Hg2iXQaZPIzM2RrMnlG1vy+ZB1kpHBGJDpeBSrsjf8QBP4j7SaZxCK6YSJCoe4P88NL4BQ7ka9D7CI9eSYLRI2DqOqMWnPIjPFWj5N691RZPsIzKrLYY7p1TGsbenvkqWOP9GVcNQaUIt7C7KVWE7NIvrGa81n4P3aofuZ5DNTJAxkUeUyKrGQqZADtNkF6AyVS8PN3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7592.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmcyUmpPVys2UVpndE5Eay9xMktpNlpMbnVMb01aSzlmeXNOUXhpNVRhZUVH?=
 =?utf-8?B?RG03eVlla0IyMXhmdXNYTWlJU0RwNXVWVG1QdVpXbG8xY2ZmaExzeUpIQkI5?=
 =?utf-8?B?R0FyTXhoeEttbHU2WHY3SytXQTZUWTFIdWRZUWRHYkZ1cnlrcGw3SitxWTZF?=
 =?utf-8?B?QnA3dkFXMVAyZFgraXg0NGE3d3pCa2ozQ05TeUFhQlZBdzNOOW1yNC94S1N3?=
 =?utf-8?B?RWI3RnBIVTlUTmljb0JPTTQveEpPWUxYajhDNUNqUzAreVV5eGJsNUM0YXR4?=
 =?utf-8?B?UUFLQkRyd2VOSmk5UFFNQ1FVOExJcHIvUmthbnNiVm5CcG5VTDNIMEdyb0Nm?=
 =?utf-8?B?Q1I0OFRzT3Y3Y2ZuaVcxK1dqRVlkRFlKQk1hekd5QTBlTlhjSDhtVFF5Q0Ju?=
 =?utf-8?B?QTk5SE13cVovVDFXOEtsanpyMmJ4UExiZER0Rzl3Sko1VDY4L3VYaHVhdzhv?=
 =?utf-8?B?aXJuZ0xUSnFOaFpqZTZLZ2xjeGdvUGpzdkdxRTErMEhRVWwyZVpwWi8veG1u?=
 =?utf-8?B?dUJvTnk4L3o4K0hSeUNGQm51NS9jUFArb2lzczFjQkpBSFhvbk5aYkx3RHJi?=
 =?utf-8?B?ZVluZ1pMYTlhckR6Q3BlSDNSR0FPRG1LTm9lRmpNTmVmTEYweENWNlNZWWJk?=
 =?utf-8?B?MWJYYjhsUFowSU1vbjBpN252Mis4bXh0T2RXQURhbE1QcGd6aGFyWk0zV0NZ?=
 =?utf-8?B?VGJXVlorUGcvb0hlS21BSEkra3BLbFVqYzFWZkEvOVBGRmZkK1pCMWNmNm44?=
 =?utf-8?B?MkNLckxJZkJaTjZMM1hvM0hSOG5ZdlVnU2hiaW9vUjlCT3AyT1pDMmNBc2ZM?=
 =?utf-8?B?SHNQMDZsZktWQWJKS28ya2p4a25QbzhveXFIMXlwOVFtSGhNajRMbThVYmdQ?=
 =?utf-8?B?K2puWlBRRVlxT3dDNGpoSzU3ck1DVU9vd29PazY3ZE50bnp0Um5udjdWMEE3?=
 =?utf-8?B?emdsZWdzNDhRNlRaRnJlSytmOTlJRUdCWXVZZnBwYThIY1RsNFFpZlE5QURR?=
 =?utf-8?B?a2hVTnJMVnd4cTdoZElHVTA5Um02cDgzL0dGSGFhUlFrQjgzUTBta3ZldUJV?=
 =?utf-8?B?RlhkUHhCSG90aVNseVlLdkJNVmp1VlcxenQ5WWpwNGs1OTdqVFNSNGtuakdp?=
 =?utf-8?B?NkZ5VXZ1T3k2NDNTYVpMdWJwQXhaYWlTMWhvTjNNQlMxSHkvQjhxSy9tZ0JT?=
 =?utf-8?B?bHJYdFc2cThCaEpYRzYvejJlYjZ2OFNiZHVxTkN2U2M3V2l2dkZicEpZTWxS?=
 =?utf-8?B?c3V6YnlYWXVnSW41QTJjWkt0dGlERWNCOVIrS2lPQklqSzB4bkovZEl2TXlu?=
 =?utf-8?B?d3FESmVreTR0OFA0dmFEeFBPa05QdEgxTEJtZC9aMHhwa0VWNUo2d1pYem5E?=
 =?utf-8?B?cnYxcUNwVkxKQmsyWGgrNzhteHZQQzJ1YTg3QVJkQ2wxL2NmVHhyZys3TWhP?=
 =?utf-8?B?aXRkUEdhbGdncExiazNiOU1mc1BhZUwxZEVCOXNDajh4eElER0tPWnN0K0F4?=
 =?utf-8?B?MDFaSDFLa0thaHh4N2JDcGFPTSs5Zjk3Z2FOYVUxa1V4dkx1V2dlcFFpOXZI?=
 =?utf-8?B?MVY4eXBxYlcwYzEvVVl1VDhWS21aM1NaVDM2MmN4MVgwWFIrdzYvYXJTNUE5?=
 =?utf-8?B?ck44MlFud1BiZGJsSGNXWERueWs0RnQzMG81d045RW81TjR6YTAvQ1QzL2w5?=
 =?utf-8?B?bXBCUzBPaXNJcjROcC9NaTBXM2xrR3lEOXRvZ0ptY0lkMlNFZ3cwcGVWRW5l?=
 =?utf-8?B?VFkvYjVlRWZjTXhwR0xPWUQ1VEJNSU8rT0ttand1WHNpU0IvWDhVbjVDbVUw?=
 =?utf-8?B?ejUyWXR5Vlh1RnMvWldjK0pqSXRqR0NoczZsYWpHV2VPSHNkKzFCR3RaRmxM?=
 =?utf-8?B?Tlk5UzJWTkFRdGF0VDFSSWQ3TStueFN3ZUg3ZC9uT3B0MkVKOGNiN3pBRGh5?=
 =?utf-8?B?M243UExVVUowTkkvS1FYLzdzd0lSMk44OEZ0K2FCSVFQdDdIYmdHMGdpYUVD?=
 =?utf-8?B?MDJjUklZZnRodnF4Nkd5UzZPdWZpS2VOT3dKUTI5aHVORWI4YUUzaW50MWpr?=
 =?utf-8?B?WjJTNUNmWkY1M2F2WHBmT0FTTDV6N3hpSE5FZnhUVDhWS0FPOWszSFBwaUZT?=
 =?utf-8?B?Smo0OXNiQUg5bmxodjUxRnh4elNSZVZwekQvcGM5K2NSdXJCYVREV3l4bS9Y?=
 =?utf-8?B?MHZjdFBqYkpQSDcyZE5wR0NwcWM0UVgyOFQyR3E2ZVp1OEtEamJlZnhRQnht?=
 =?utf-8?B?RDRxbS9MZ0RSdkMzWE5WT2d0bytDZ2pDc2FYYXJkRXFSRExObWdhT0lZZERH?=
 =?utf-8?B?cFhOQzR3eU8vb3NuQ1hxbElnNFhoUWdjaWZNVERGNXZXT1F3cUVTdz09?=
X-Exchange-RoutingPolicyChecked: FHTjWd5qaoiMOt1r00mEtkqhnCIZguBglG//pM4TtmMcXhpT2wOxgFPdECPNMAYFCy8Rc8Q+bjHR865wh4o7IodojEp09ZcZ8Rs5OMYef/Og9hbJaXolEZLRq9N34JGtUpVDkwM09CFu/IHPvgT3yv2PAUwbmkgKkhCxg8vc+G3xfJhKxuA2ankc5kAhmzjsW27wlqH5WCqYDscTlZlpni4sQWQBWZDCHOsFnBObytJpOcD8qgnDw9rdAi9OSe25mwPMdEQZPG9jnIpcClAD9pFxElgLvHZgcjeUr4eut8XmQk7xbd25g35RI/YqrdOcRBRxD1ndjSp5blqQDSdOIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d3aa63-7fb6-4cfa-db35-08deaa657f96
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7592.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 05:16:44.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPaKJL2HHUKfXQ05WF3GCwuCPd69NIfw/9fm3qR6eT/rE7SIYliE9TZbiCQuywM68vUaC5KOD6lu0mDfgN+4hskPlk4HV40zXSJ4PLRtYqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 581594C6CD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284221-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]

On 5/4/2026 9:35 PM, Michal Swiatkowski wrote:
> On Mon, May 04, 2026 at 04:53:12PM -0700, Jacob Keller wrote:
>> On 4/28/2026 12:06 AM, Michal Swiatkowski wrote:
>>> The hardware is capable of calculating checksum for IPV6 packets with
>>> extension header. To not drop such packets switch from IP/IPV6 checksum
>>> to HW_CSUM.
>>>
>>> HW_CSUM is also used in previous generation (i40e).
>>>
>>> Previously HW_CSUM was used to indicate that hardware supports general
>>> checksum. Drop it assuming that if the hardware supports it, it is used.
>>>
>>> Disabling offload for E830 in case of TSO isn't needed anymore as the
>>> check for TSO is done in Tx path just before preparation of the special
>>> GCS descriptor.
>>>
>>> The commit from Fixes didn't introduce a bug, it just shown that the
>>> driver is doing sth wrong with the checksum features.
>>>
>>> Suggested-by: Jakub Ramaseuski <jramaseu@redhat.com>
>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>> ---
>> Am I correct in thinking that this supersedes (really, properly fixes)
>> the patch "ice: enable NETIF_F_HW_CSUM for GSO packets" at
>> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260310150557.1138437-1-jramaseu@redhat.com/
>> ?
>>
>> Thanks,
>> Jake
> 
> Yes, exactly. I think I linked it in cover letter, but maybe I should do
> it also here.
> 
> Thanks

I think its fine, I just wanted to make sure I was correct in marking
that patch as rejected in patchwork.

Thanks,
Jake

