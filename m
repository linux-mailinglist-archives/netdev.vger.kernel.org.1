Return-Path: <netdev+bounces-241412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F81C83929
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DD7134BB39
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874422FE06F;
	Tue, 25 Nov 2025 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfmCgvGy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737312FDC43;
	Tue, 25 Nov 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053403; cv=fail; b=EdyMUWVaSP0edV4Y9pFUa4lgR3tVZLn1cVyITWMgKerXLigAiPvDWSeWfrVK6w5P2flYFBGLe7MUrfXgVIFS80fQXRRWgi55FfNLr5bs3Y/BtBqbmFdclmUjrPYyb/bmKi+xVqFqfbO8GaYSfH0b7jm/5qRJV+79vpEfseDzQt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053403; c=relaxed/simple;
	bh=G6/l6I/SuvGnFRkdkrXA6oNH7Lk07DwF6HLgwbv0mY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QSWlrn/siTQbYc3wt0wA+lr0AU2nJFbCvAZjaQzjBtoDcSOXOjlXqKOZTRObSGfAc4u/4RKhwHTeDUv2C4PyDQNzRNMmbRYZQKT6vGzHSVvSe7R8F/yUE+xP5jnRs37gLEa6ArdAPGeg/5Wpn+/Gqf9bbqZ5IFlrjwO93FJ5O+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfmCgvGy; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764053402; x=1795589402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G6/l6I/SuvGnFRkdkrXA6oNH7Lk07DwF6HLgwbv0mY8=;
  b=IfmCgvGy+NVZKuWoIgMZtqS5ZersgQUbE1ZXUvF05zE1OgBshxt+Lz6N
   qKRmXPHVH28ATjUMOzJviCPuQz4eqg/3XAy/31UzshE4T329NEsJgNcgB
   2PvCR/fX7aFMgcVTvgOh4aWg3Wbfc3E3uu1J20ivzz/uholHhhDefA5qP
   J75bimmMDoFZ0/6AjWwDtyFbGxeLDYWk0de+sIvYLcp5Bg24R56dy5Brg
   aBYPrSR/1yOSo/qLkPnradu105xwreGzcW/o0lSEbZXX7AoYf3N97AX7F
   XHFgaX1g5DaruDeDKWti6BLgNlrq7B7KvdzjQlxFcQnzHJLf9pyqVHuuT
   Q==;
X-CSE-ConnectionGUID: DOouACYiQwG+YW5wwoREjQ==
X-CSE-MsgGUID: Gh/1Sw9FTcCcWRGE7OQ84A==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="69926667"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="69926667"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 22:50:01 -0800
X-CSE-ConnectionGUID: YPxPiTN4Rr2g/6pM/9KUwg==
X-CSE-MsgGUID: lyvg5FXzSrCvJh5UvdXPcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="192441805"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 22:50:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 22:50:00 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 24 Nov 2025 22:50:00 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 24 Nov 2025 22:50:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9ToRLa70PEf2HtDZFSPCDr/xyEWaRX8CmFTcV1B3VV6ncteyBLzquWI6xGd9HJiERWZWeR2NRBUtvmcDfHVXqKBEib1cvYGLrqITBFuxpdi8UnRh6enRq8mjnM0yVs6DrVGdL5409mmLj06auEv99s4S/wLzgZXm76ZCLJq2uIWTNw/PDjp3XCNJdpnubnRw1UpxD4DcVTGN/Z/kKxGP8ySuSDRlGF6+dh+Zec9VektwdOAuPMhPTlmmSdtIdniQz52ZLjJ1SDGklYieZgSzXTKo+DZc4b9KzL87Tv1ZVIp1sPsnlIFWcXM4H/CaiH7lvgAkCTOmA+wlgvrSaGsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6/l6I/SuvGnFRkdkrXA6oNH7Lk07DwF6HLgwbv0mY8=;
 b=OTPKqDqY73vnMM/RtQdbZqVsshpS1j6UMiygvUaKkcgjq0S3m8jm1S3n4Gz4YHwihwHi6QBFtf07yO+KBiqbH+2cOPU3mtEotPuJEG14rkrLrXTKr7NDI2Uv6URw33y04xo/YwCtvSto3N5/MBr5Gmn4wezgKcB9ThpTMPF0MDLyqD9GG2p5qiKx6zli+MczIp6gWOsOtjZYlZE63TaFOghbdxkGA6ORbbF9/ZOPer3nm4R0iZjM3nIhryxIFP6ojf2XgvVvrlNl2MFiSB7hgbcofrXN3rxSGqfrUPVxLEuRh1CQdeFzCYzZBAu+s1heiGOFDRs0lz6CBboVXSB5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 06:49:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::395e:7a7f:e74c:5408%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 06:49:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Breno Leitao <leitao@debian.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "michal.swiatkowski@linux.intel.com" <michal.swiatkowski@linux.intel.com>,
	"michal.kubiak@intel.com" <michal.kubiak@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next 3/8] ice: extract GRXRINGS from
 .get_rxnfc
Thread-Topic: [Intel-wired-lan] [PATCH net-next 3/8] ice: extract GRXRINGS
 from .get_rxnfc
Thread-Index: AQHcXW7rd2KUz3Ag+k6wGkGG+YZ7eLUC9IXw
Date: Tue, 25 Nov 2025 06:49:57 +0000
Message-ID: <IA3PR11MB8986D5D66503E84D866FCC89E5D1A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
 <20251124-gxring_intel-v1-3-89be18d2a744@debian.org>
In-Reply-To: <20251124-gxring_intel-v1-3-89be18d2a744@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB8073:EE_
x-ms-office365-filtering-correlation-id: 22c67501-e49d-474b-54d0-08de2beed93b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?MXJMSG51VnBrN3o2WmIyZE9GMlNWelNPR2U1YXB0Y0JxRElXSW15UGorME1G?=
 =?utf-8?B?WTdUc1FvUEJCdEh5dk8vejRiVlZKK2I2NXdtc014TmlLKy9nbnhFQzcrMzRQ?=
 =?utf-8?B?eWM0U2dEWmZCRGFyZTVKYmRqZ3lUb1pRcDlXaENlbUJtbHlDaUk4NGl6WFYw?=
 =?utf-8?B?UURWTTlWYzVrN252empaaGU5WFdQclJPRnRqaXc1OFgwcnFLRnhHQ1htajlS?=
 =?utf-8?B?SW5yV3JJWkxpYlE5QXRqck92QWVsd3ozc05DWHlwWjB5aG8xc1RwSkNSZE5r?=
 =?utf-8?B?ck1HeWpYMmJGRE9XREV3d1dDMDVJTHJseCt0aTVCdG9oR1FjRjVzbk5iR2N6?=
 =?utf-8?B?TGNmYkhvZGRFUk0wRUV0M2k3QS9tRTh5bDIrbTJSenFzNTFpdUJvVTVmVldI?=
 =?utf-8?B?TVB4MDN1eFV1YjlqK0g4N3c0WEVpTkhPS0JIRGJzU2pTTC9LakNwR25aY1JN?=
 =?utf-8?B?WmZlQXVhZUFnV0d2NExmV3ZBd1huVDBYbHZRcWsyd3VDRHJmSWJOTWc0dXJ0?=
 =?utf-8?B?OGMyNnhwTlExeXdVQmt5dmZBQmVjNURwcHpLU3lNWG94Z2ZnVWhyNGxrOHVk?=
 =?utf-8?B?ZnMxZ0xiMVY5bUZXU2x4SUtrMS9SRjZudGZEWk5zNzZVYUl2WFBqTmhQSGJR?=
 =?utf-8?B?dGlZQlEydFlRUGgxS3BpMG9lT250OEpCNDZRSFFhQjRaOW1LVDhwRk1HWHIy?=
 =?utf-8?B?ZVZDUUVWRFJvZHU0c2xVNmxWbk45SlRTcm9GUnlQZzNXV1NaZVJOUHNSd0d3?=
 =?utf-8?B?TEh4UFBkYTJBQnpwVW5pZGdXWGY0VkJRZDhYeWhneDVLcmRneHFWcUVPTUlO?=
 =?utf-8?B?b0Fhc2o2QlB0MFZGRC9VSWNCNlpSWlgyMmhhazlnYlVkOVlad2V4TDBlc0hx?=
 =?utf-8?B?dVFianNKekVOdmdzMWdDS2lmWXdsdFBBUGxaR2FxaGVnVURKTXhISEsrVDBm?=
 =?utf-8?B?cGt3R2phb1RUWHdwcWsvdlV2Z1J3MGdZek5ZRXpMbkhsS0xiRGNwa29nTTJj?=
 =?utf-8?B?S252V1ZpNVFPcGhoZHV2ZnFadEdiUE9BZFF1WEhVNnZ0Q1VwSlVQL1ppV2ZM?=
 =?utf-8?B?UllJcWVvVlpTUmp4VzZIa2l1cy9NYUdqWXM2UzdQdjJadHZwbE8ra1JiYmE2?=
 =?utf-8?B?UjZEV2hTNHJhQnFDWXNVY3Vqd1BNYS9kRHVRM094VnlyK1laK084UVlGM2dz?=
 =?utf-8?B?UFRScWlaQjNqU1NEdzlab29HRVZzT3dwNjIzdjZ1UXFMdXM2Y0lZU1BhL2Vi?=
 =?utf-8?B?OGYrbGFjcmFjZ2hEbGVLbEs1ZFp5TEszRlc4NXAvNFVjdFFBODFLNUxmN1Bj?=
 =?utf-8?B?YjlpVXBkYVJGbzlvTXVaRDBndjVqWnRtMzZyWFdqQnp0TkNkdm42aTYxY2hm?=
 =?utf-8?B?Q21yMCtTeDRqM0gvTnhzWHFYUjNNQkl4OUNKazltdjRXTExzck9OWlg3bUlJ?=
 =?utf-8?B?R3cwc2QzWWVaVGNjdllZVTBZMFYvZlZnQmlySVJzQ3lydEZUZzFVME9kVTRY?=
 =?utf-8?B?NFBzUHZlRmZRNUFkQ0ljRHNKWjdtaVZnTmpMY3ZuV0JBK21FeUhQL0hhUFUw?=
 =?utf-8?B?Y3Z1QXVjV2hVVXRIOEl6U1hpOGNQZVFQdWlMK29RbVArcjF0azlydzhPRXN2?=
 =?utf-8?B?cnhIOGJDOGg2N0VRc1FYTXBRWndTd3RaUkpOc05uYk9heDJlWFVBeC8xNVM3?=
 =?utf-8?B?b28yVHBkelpVUUJRalpJU3p0UG8rVEU1dXNyZnc4VTNxOVQ5S1RaUXRmZFE0?=
 =?utf-8?B?cUVHTHBUdW1CRWgrV1FhMHRIMU45ZVNvNmlhME9RcXVZTnJSZUp5VmcyZmdP?=
 =?utf-8?B?TG5QYmRhN1JaNlJBR3IydkpibElmbXhNTXhYMmRDTVgwR1V2L2VRUHpHTXBz?=
 =?utf-8?B?VGVCMS9BbFdkU015NGtHVjZGWFliR2pXNTVlTnkrWFVlS09USUxZSW5obGx0?=
 =?utf-8?B?eVBNSVhOV2RKRGpSa1JjR01hT2wyK1J6SjRieDlGS1p1dW1INGtCQlhTUDJr?=
 =?utf-8?B?MzQ0U0lGWE5wT1pvaEVLL1FLOHExRWVqMWR1MjVyTmVuMnFPQXdnZWV2RENw?=
 =?utf-8?B?dkhQTGtEM21tRkF6dFlpYTNUZ1YybWNUS0lYdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXNHUzZSMHo1VXJoUjgzb3FDejBnU0tHK1hrWHlBZmV1RisyMXR0VE9VUUVv?=
 =?utf-8?B?TUo1M1JlWGtJL3FITGhHRXhMMzNLbGZzdUFTazlZeTJjR0d1aDF0d1A3R3V3?=
 =?utf-8?B?TnkzVDZkRnJMQTdZYjlDNW1rUzBXTUpzQ0RKdVFYZE5qYVpZeXhqUy9XU2My?=
 =?utf-8?B?UHh5STdUaUhHVVpQQlk3emxianBIbE1oZ3R1T1NRNkV0ZkF6TU9wVHc5OTNv?=
 =?utf-8?B?YWxBYkNlUWZEdFlCSWV0RGFKUFVBYkUwdUI0cjlrOGpLZ21WZ0I0NXlyZlNB?=
 =?utf-8?B?dVpZQmZ5UVFxdkhiM1JQN09ET254NDUwUzViSXJtMktNRDc2aEl0RmJrZlQ4?=
 =?utf-8?B?aDByMGFVZVRySlVXU2pkYjQ0bkd2Z0J5YVMyRkNIQ3NNUEYvVG9QUXlkVExE?=
 =?utf-8?B?bkJtalgyOXphNFh1Skt5LzRQZW9JbiszcVpFQW5uUndnenpKVkswOVRuWndF?=
 =?utf-8?B?dS9SdnpvQVdUaDZSdXFwTENaclZtd2lmVEpoQnQ4MkM5WjQ4ckRJd1lVR20w?=
 =?utf-8?B?aGRmWm1nWU1ocE1IRllIK20xOWhDNTlSdndKc2VRSDNpVkZsVUR4S0pEODBq?=
 =?utf-8?B?WEQrdkt5M2tOV2FVaXFMNm1KNDVDbmVsTVRJUVZCL0ZXVFpCMnVSRU5TOGIr?=
 =?utf-8?B?SXF2U1hwbXI1aFRjcmxyUkVQVnNWMXNZb0txVFlBa0Y4c0UyRHA1R3hNR0FR?=
 =?utf-8?B?NDhqMU5SaE82S3NtZEVIdXhhRXFwRU5kVnhSajB2RjV4RzlwdlluZnQ5Y1g4?=
 =?utf-8?B?YmVIYUwrZ3M0cDdvbkNnb1JhUng2UXhpV3BnZ2dITWlUM0FJOEdHbExqQytW?=
 =?utf-8?B?TEpDWWUrTS9Dc2Y3d2tMa3gvY2xJZzRkM2JabG5EaVdQSXdPc1d1QmU4VWFZ?=
 =?utf-8?B?VmhPSk1ZL2h5OXJaS2JrYXRSYTZiYnMxTHBhSlRaV0p1TzJsNlozaEpFQjcv?=
 =?utf-8?B?WGo2Y0puNy9YZ2JSV25IQ2hPbzZuZU9uTTAyVGtCeVp6ZmxSMy8xdTBVVGNq?=
 =?utf-8?B?TDliTkYvTEdsdUNSWGZsOTBXUXplNnBZbnJxbHJvZGVzWXF1ajV4Ri9PQkJu?=
 =?utf-8?B?bWpkTFJCcUxSOHpjY0wwVkFoQU45bU1wZkZwQWgvQmZvWDNOTUZ6MkprV2l0?=
 =?utf-8?B?N1FSSnpBWnFqWGlNOXBZU0EzZ29GSDg0VlJodGxLZ3JOdEdnVUNHUzR5WmF1?=
 =?utf-8?B?U2VNQmUvN1VBMDFDV2RlOUVJekduMzFPMjZQbnRkSno2ZTdoeXorNFdFV1FB?=
 =?utf-8?B?ZFhraDZRUjI3MmRjcmozcVhERmpiZVVHZUF2NlRtMXZZUnRoVHRaTy9GeUx5?=
 =?utf-8?B?UkNJQVd6Y0UxeWtZZEdLOW4rcjM5Y201ZVY1cFRpZmM1b2t1Q2pQR1pLMXhI?=
 =?utf-8?B?UE5XdERkcSttQk9NdU1sWVQraEdaclRNMU5yWEgzWWtJTnJQbGdvUHFSdEx3?=
 =?utf-8?B?ZDExZVVONHhacFNTUi9BbnRkd2QwRjJXSGlTbTAwNzBEaVFEd1RXdWYycS9i?=
 =?utf-8?B?Z0hTMDRXVXVFUjNLaTBac2V1bmx1dnc3d1pyR3JKWXJBMTd3ZWU0VGMvc2tq?=
 =?utf-8?B?L2RmQkZnYWdORCtPazNZVUdMeG00cHduOUhJVFAvdGd4ODhhak1vNDVwMHN3?=
 =?utf-8?B?Yy9BKy9tYm1yRURLYmUxS3hoMkY4ZEJPMXVTUStKL3pCWUZmTFFOdkduUnc4?=
 =?utf-8?B?MVJIWWd6SzliVUN2cjJ6dEpsRzRWNm1RMEFmY3VrSzUyZmVIYlp3MjA2R3Fy?=
 =?utf-8?B?cytrcFgzRVFRREtqM1plQ2JSS0RJZXdRbXdCM3dtc2lESXl4NmcyVGpFMU1L?=
 =?utf-8?B?S3RIeDBVTzBPRUdlZVBvNXpWT2hjdEhxOTUwNXFkMVJCSU5uSWc4SkVHNFRs?=
 =?utf-8?B?QnNWb3FJOW1leURiTzVVKzgvMCtUMGJ6aEdvbFJMN2RQdEdTQzhzYjFCOStP?=
 =?utf-8?B?cTBLVy82K2JGcEwxZ2RsV1F3UzhQWUYyQURJcWF0NS9hRTdEN2U0WFpHQXdU?=
 =?utf-8?B?aUVvSkZMQkVLdlR6aG1NTlAxTkdWMFhYNXg2a0wwSGlPK2RUaERtWWJUQlps?=
 =?utf-8?B?YVJBYkVoa0Z4c3VqVTFIKzlPR0RKT043VWhkSGZPMW1UeXEzTTA5UG9OT01a?=
 =?utf-8?B?ZWxycDRRZzljMnhKdGRWOGVUS21GS2tNZFZhbzE0bFpzTjgxM0pVcVNrencr?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c67501-e49d-474b-54d0-08de2beed93b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 06:49:57.9508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IN/TKql/NFECpbnNyZJSzb1vVkwnmuBHM7vbRBETcWDYFMORBmDyt+si9V/+8R0fUEKfMDPwkcF7Y116TRcWcUfJELCARqenRH1P0gX3hAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YNCj4gQnJl
bm8gTGVpdGFvDQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjQsIDIwMjUgNzoxOSBQTQ0KPiBU
bzogTG9iYWtpbiwgQWxla3NhbmRlciA8YWxla3NhbmRlci5sb2Jha2luQGludGVsLmNvbT47IE5n
dXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWws
IFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBBbmRyZXcgTHVu
biA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQNCj4gUy4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWINCj4g
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNv
bT4NCj4gQ2M6IG1pY2hhbC5zd2lhdGtvd3NraUBsaW51eC5pbnRlbC5jb207IG1pY2hhbC5rdWJp
YWtAaW50ZWwuY29tOw0KPiBGaWphbGtvd3NraSwgTWFjaWVqIDxtYWNpZWouZmlqYWxrb3dza2lA
aW50ZWwuY29tPjsgaW50ZWwtd2lyZWQtDQo+IGxhbkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWwt
dGVhbUBtZXRhLmNvbTsgQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4NCj4gU3ViamVj
dDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDMvOF0gaWNlOiBleHRyYWN0IEdS
WFJJTkdTIGZyb20NCj4gLmdldF9yeG5mYw0KPiANCj4gQ29tbWl0IDg0ZWFmNDM1OWMzNiAoIm5l
dDogZXRodG9vbDogYWRkIGdldF9yeF9yaW5nX2NvdW50IGNhbGxiYWNrIHRvDQo+IG9wdGltaXpl
IFJYIHJpbmcgcXVlcmllcyIpIGFkZGVkIHNwZWNpZmljIHN1cHBvcnQgZm9yIEdSWFJJTkdTIGNh
bGxiYWNrLA0KPiBzaW1wbGlmeWluZyAuZ2V0X3J4bmZjLg0KPiANCj4gUmVtb3ZlIHRoZSBoYW5k
bGluZyBvZiBHUlhSSU5HUyBpbiAuZ2V0X3J4bmZjKCkgYnkgbW92aW5nIGl0IHRvIHRoZSBuZXcN
Cj4gLmdldF9yeF9yaW5nX2NvdW50KCkuDQo+IA0KPiBUaGlzIHNpbXBsaWZpZXMgdGhlIFJYIHJp
bmcgY291bnQgcmV0cmlldmFsIGFuZCBhbGlnbnMgaWNlIHdpdGggdGhlIG5ldw0KPiBldGh0b29s
IEFQSSBmb3IgcXVlcnlpbmcgUlggcmluZyBwYXJhbWV0ZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQnJlbm8gTGVpdGFvIDxsZWl0YW9AZGViaWFuLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2V0aHRvb2wuYyB8IDE5ICsrKysrKysrKysrKysrKy0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRo
dG9vbC5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9ldGh0b29sLmMN
Cj4gaW5kZXggYTFkOWFiZWU5N2U1Li5hZGI2ZTEwY2NiMWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRodG9vbC5jDQo+ICsrKyBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfZXRodG9vbC5jDQo+IEBAIC0zMDgzLDYgKzMwODMs
MjAgQEAgc3RhdGljIGludCBpY2Vfc2V0X3J4bmZjKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYs
DQo+IHN0cnVjdCBldGh0b29sX3J4bmZjICpjbWQpDQo+ICAJcmV0dXJuIC1FT1BOT1RTVVBQOw0K
PiAgfQ0KPiANCj4gKy8qKg0KPiArICogaWNlX2dldF9yeF9yaW5nX2NvdW50IC0gZ2V0IFJYIHJp
bmcgY291bnQNCj4gKyAqIEBuZXRkZXY6IG5ldHdvcmsgaW50ZXJmYWNlIGRldmljZSBzdHJ1Y3R1
cmUNCj4gKyAqDQo+ICsgKiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgUlggcmluZ3MuDQo+ICsgKi8N
Cj4gK3N0YXRpYyB1MzIgaWNlX2dldF9yeF9yaW5nX2NvdW50KHN0cnVjdCBuZXRfZGV2aWNlICpu
ZXRkZXYpIHsNCj4gKwlzdHJ1Y3QgaWNlX25ldGRldl9wcml2ICpucCA9IG5ldGRldl9wcml2KG5l
dGRldik7DQo+ICsJc3RydWN0IGljZV92c2kgKnZzaSA9IG5wLT52c2k7DQo+ICsNCj4gKwlyZXR1
cm4gdnNpLT5yc3Nfc2l6ZTsNCj4gK30NCj4gKw0KPiAgLyoqDQo+ICAgKiBpY2VfZ2V0X3J4bmZj
IC0gY29tbWFuZCB0byBnZXQgUnggZmxvdyBjbGFzc2lmaWNhdGlvbiBydWxlcw0KPiAgICogQG5l
dGRldjogbmV0d29yayBpbnRlcmZhY2UgZGV2aWNlIHN0cnVjdHVyZSBAQCAtMzEwMywxMCArMzEx
Nyw2IEBADQo+IGljZV9nZXRfcnhuZmMoc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiwgc3RydWN0
IGV0aHRvb2xfcnhuZmMgKmNtZCwNCj4gIAlodyA9ICZ2c2ktPmJhY2stPmh3Ow0KPiANCj4gIAlz
d2l0Y2ggKGNtZC0+Y21kKSB7DQo+IC0JY2FzZSBFVEhUT09MX0dSWFJJTkdTOg0KPiAtCQljbWQt
PmRhdGEgPSB2c2ktPnJzc19zaXplOw0KPiAtCQlyZXQgPSAwOw0KPiAtCQlicmVhazsNCj4gIAlj
YXNlIEVUSFRPT0xfR1JYQ0xTUkxDTlQ6DQo+ICAJCWNtZC0+cnVsZV9jbnQgPSBody0+ZmRpcl9h
Y3RpdmVfZmx0cjsNCj4gIAkJLyogcmVwb3J0IHRvdGFsIHJ1bGUgY291bnQgKi8NCj4gQEAgLTQ4
NTMsNiArNDg2Myw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRodG9vbF9vcHMgaWNlX2V0aHRv
b2xfb3BzID0gew0KPiAgCS5nZXRfc3NldF9jb3VudAkJPSBpY2VfZ2V0X3NzZXRfY291bnQsDQo+
ICAJLmdldF9yeG5mYwkJPSBpY2VfZ2V0X3J4bmZjLA0KPiAgCS5zZXRfcnhuZmMJCT0gaWNlX3Nl
dF9yeG5mYywNCj4gKwkuZ2V0X3J4X3JpbmdfY291bnQJPSBpY2VfZ2V0X3J4X3JpbmdfY291bnQs
DQo+ICAJLmdldF9yaW5ncGFyYW0JCT0gaWNlX2dldF9yaW5ncGFyYW0sDQo+ICAJLnNldF9yaW5n
cGFyYW0JCT0gaWNlX3NldF9yaW5ncGFyYW0sDQo+ICAJLm53YXlfcmVzZXQJCT0gaWNlX253YXlf
cmVzZXQsDQo+IA0KPiAtLQ0KPiAyLjQ3LjMNCg0KU2lnbmVkLW9mZi1ieTogQWxla3NhbmRyIExv
a3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

