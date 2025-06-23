Return-Path: <netdev+bounces-200168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1917FAE3897
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9411894C85
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E422DF9A;
	Mon, 23 Jun 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWx1isq0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D0022E00E
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667815; cv=fail; b=q8JlGJl3uqDx3Wq3oS9lw5WIw7CSKtuMiJfk3elw8NXlbhNB/v2A02q8YF9km4eLGoH4Q2XcrUJG1PjavdRfEHmj4E3UQSOwLFF9mwSJSUrHvRAlba5AjyHbrgC8AetdSBUETEPkc3R+kv25G5LojT784Gf54JEvB19XfbKSyqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667815; c=relaxed/simple;
	bh=jeR11nYqdNbBuuDvP5tLoZ57eLNH7XzZmvRFf/QMvAE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=brkbBqhu0iBgv5GNCdW2IGm1MsU6NC5WNvoTP2HRAXTKow3NFtSDFBU0CDlMS8r4sZQW4b43r7t2VJarGEOeatwTlZqKjS6uyPmiaduw/ZReVemYZyPyuz9ILa1MVqDCvQcP67Btii6fAnIER7oO5SgzllFC1aqmDFeQ7+BVcoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWx1isq0; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750667814; x=1782203814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jeR11nYqdNbBuuDvP5tLoZ57eLNH7XzZmvRFf/QMvAE=;
  b=jWx1isq0tkoeWCsqsVJhkSDgQZ+i7qWlPw38DeWlIcXAeaxedCcwBbtK
   3JrNcpZSVGqBy1yr6onoD+NGNV94g59Kua2jUizjhjnLxYXV6+Lpj7xPD
   MG9MOntZNxM+Z5b5+lI1ShEX0z4Yzvm+xHL2Tu/Yu7v+ilC5bTvCJYe4y
   PDGA5we0/DWy6RkIMse051cAGgF4KvMJVvmq7J6wBNZOH6+cqYM3ixj+X
   OxYheaEwZnIwwoVGw/nxGhbkBdFx/yH/Wx6e+4EYAB+Er8d7tLatmqlV/
   E5ZiRdGd+S4bUnrtTS6eZBtNPVFyR3Batamep/A3yZWQP2HW7MFF7stLt
   w==;
X-CSE-ConnectionGUID: xNSzlRghSWqY0P27hgx3Lg==
X-CSE-MsgGUID: DcYxG+k3SsWGBmLbWoyjyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="53002857"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="53002857"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 01:36:53 -0700
X-CSE-ConnectionGUID: 6TVxb9r1SaOFGDxeqs4KOA==
X-CSE-MsgGUID: Ac/HifQFQLSapgPZRvYnIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="156078317"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 01:36:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:36:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 01:36:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.45)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:36:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJ28vi41nmpTOO5Lrg1B/O+Ii+PDLVW4pgWADfHfajgZDfVQnhyLN83ZV8T0euq8WYF90QhR05ioHuIT0vOhI+9+hr+fkpFxm8rO0wyaQHS5Rc7l4wEO9FzvRkI84wkg9TRYkQQ+r3mwajVxxXewg+kzfy4ynPbMy1EXX0lM7A+AE/NrtiDRw/drmjffBOmNdsfPzu2OeIut/4OcvnRrJEZHuIbjOoT7fZemxFUNNZVWFIjYq+Ykp0WS2uq/wLaf+qrvlbJL7nAycvQVJUy2iBgZq8pcDtMCme+JqaIbQQJUZwjAQh5ogpl3mJu2JuFPXDkbheewaK5GoX+rnT4b/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAXiNkzm87TRaWmdQ+lAN0+EmB8xfEmz5aWBepfCKUY=;
 b=Nuen2+VyFtXanBWv8Aic+F+PR5IwfX0EBEjxR+gLJEKB4hyL/xblVfBAeEzFXQ0w4D4WSV/Ml/fKV/bjOQb/bgJKqR6TdaEAQaSmy1Oo8DJhPaWkvjLbR80gBtNMBc1hJ/GYDSOdDpD7QWYM2JDBbTRUr5sN9DF56EkLSYJixPX+tZDACGZ9cymaigo0M9lB1BceXoSMxuNRIRyl0ulp7P9MIUxc06Z5TB+wSqpXlW1oHDEWP2pNNpxDGOeAGUXP6M9efBvG1xMB+w8PaaISYzxPABcbV0X4rckQcqg9Y2vZ3WNjmqKnHn13/njwTXCZB7ai7/gMmtGIHNwh49K3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by IA1PR11MB7821.namprd11.prod.outlook.com (2603:10b6:208:3f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 08:36:22 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 08:36:22 +0000
Message-ID: <7960d4ec-ef0d-41b5-9589-c59c7e49128e@intel.com>
Date: Mon, 23 Jun 2025 10:36:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 0/8] ice: cleanups and preparation for live
 migration
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, Madhu Chittim <madhu.chittim@intel.com>, "Yahui
 Cao" <yahui.cao@intel.com>, Anthony Nguyen <anthony.l.nguyen@intel.com>,
	"Intel Wired LAN" <intel-wired-lan@lists.osuosl.org>
References: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250618-e810-live-migration-jk-migration-prep-v1-0-72a37485453e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|IA1PR11MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdaf3c0-950d-47a3-2121-08ddb23108c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG5DMEw4ZmxKcGZrb1JDc2hrbTcrVm4wdGJob2grRjR5UU4vNi9HVzRHcUVS?=
 =?utf-8?B?cHNIL0FERTNic0xnVmFtZXZuTXY4VkM5ZWpzaFdER2UwajJkWm0wSkpFblJ1?=
 =?utf-8?B?ZXhkQmp0dGViYWZoZUg3VE5vak1nQ0dsSVNwZEFLUlh0SkU1c1piUHRBcVhW?=
 =?utf-8?B?UzEvUmZzSG9RVHZ2NjB6Rk5tSE80MDRyV0lBVUhXaUxoaVU2WVVpVWJWbXh5?=
 =?utf-8?B?b0JwdzZ4SzFGbTFocHJSZjBNWldUcUJmSE5HRzhNMHhCcndWSXBWb1M2Q08y?=
 =?utf-8?B?ZnJMUzhXTC9yRVV2QnZQN1c2VktCYVV5ZSsrQXYzMHBEMk00QnVIblVjUmRD?=
 =?utf-8?B?L2s4SktuU3UzVGkyQThsNExmUmxoZFdkRDhnS1pWaFdiNWdaVFdPaEIrVHJF?=
 =?utf-8?B?VXkvbTR6eERDZWdWeWFiYk9zK3dMTENuWHBFWWRUL1owOGNsaUNIbXhlNE80?=
 =?utf-8?B?aDVqalJHekZXdVBjRmtmWVVRZnRRRlNPRDJUSlFFQVMrY2tqTDJaUjZ6ejYz?=
 =?utf-8?B?QTM5b2t4bnRSOTVrSURCUFQ4ckpmbWxSdG1BVzkwMkNnRUc3QmprRFF3Q3U2?=
 =?utf-8?B?OVB6ZWVtRWgydm9OYXg2MWM0KzhoRGdvR3VpaXZOWmVpWHFKdEFqSjJaVUE2?=
 =?utf-8?B?VVlQSmNYdXhRN0N0MkZ6Y0JkWDVkbVd0SUdUb0VpSUtEOVVKUVhrQ3VILzN4?=
 =?utf-8?B?NFVNOGl3RldKanhwK2kyZVIrZkUxaFZ2Z3ZSVFI4RHJXQ0pBZ2FFN0F6YWFj?=
 =?utf-8?B?QWZTOVdpNk12UWh6dDc4QkhDUS8yQ1ljbVJzYXBjZTdwMktGOGhMNVBTTDda?=
 =?utf-8?B?a1c3cUFmQVBqT0dkMWk5b2hxV2s1OHEyVFNuUlhkb1oraGllSWU1VVkvY0Rw?=
 =?utf-8?B?ZW05YSs4c3dQSXF5N0ZHNkRCb0pSQTMySml1NDVMNEFUQm0vc1hTbDhzTHM2?=
 =?utf-8?B?UEdHSDFVcyt3RXprQ2IydXYyR3JVK0h1RWdyR2hHUk41YjFpNnBuUzZZaVZR?=
 =?utf-8?B?anp4elErYnRqbVd3QTZqYzNCanZxdndNZDZmWlNQNjBsdFBVMFFxalVVSnMv?=
 =?utf-8?B?QitlNzFHdEtDalNMZTRxeks5V2lsTjhTS250N1NYQkQ2NVpRQzRJQWVITEg4?=
 =?utf-8?B?M0UxRDY4YUZlaEV4R0k0WWZZNEgzcXEwNXpUVmQ0WmhtSmVxeSs2KzdWQXU5?=
 =?utf-8?B?VENwV2pwNzJDVm0yRzdLd2VnMit0VnNaaTMwdGZBL2pqc2ZtNVVtMEVKd1Rs?=
 =?utf-8?B?b1lyTTdYSHVxWFh4NVA2LzRiRTBRUGxFZ2d0SzJyaFNTQmlBS29pT1JQK0hv?=
 =?utf-8?B?cDhNVXMrKzRDZzEwTmd2eDA2RlVhK2FQUWRWazlVM0IrSGxxRE1xUVhyZHBR?=
 =?utf-8?B?by9PVHlnVXVyVG1YU1V3OFE2dFd2UzhkNzR5eGNaT2pTYTMwQXpnMEpJOGtw?=
 =?utf-8?B?dXVMTWRSRWZta0NSSytISXdYS0hVZ3NnbTBoaDVwdngwdVQyRFJVbXVMemVi?=
 =?utf-8?B?ZlVKdVVaOGl0SHVjTWdZUFZKVGVqc1VabnUwdDd1OXpHNkpMRzRvaU01ency?=
 =?utf-8?B?aTNMOWl5ZkppcEYrNGFrWUVzTzZpZDk4YnA5WGI3d3crdTNETEJ3bTFRNDhY?=
 =?utf-8?B?ZUJjVFVhU3VVdDRNUnQ4TlJFTjJ0ODB1UG9HQ2lDckhRSWsyTGhqMXdDcVdZ?=
 =?utf-8?B?UktIbWpkeU5xZHZMNjVxQ1JUUmVxU1FxUXlTc1hNVkNDYTJDeld3UnptWWJF?=
 =?utf-8?B?a2tYYjVpc1FnRVE0VDd5ZVZTbi9hUmtpclJCYnBWVTBoUGpzS2QyQ0Q1cTF5?=
 =?utf-8?B?eHBxR0hnZGIvRFFWL1RYTWhPdGdOZUwvQ0NzVWo3UXQ4SGtPWDJNbndSUmlw?=
 =?utf-8?B?NnNaTm0veTVpNWNQRHdJOFNEV0FuU2JyR2E1TWdUMy9lOS8vYmhnM2syeXdx?=
 =?utf-8?Q?rhZgImRPm4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtNQnlqa3JpK2RZNlJ3SmoyeU5kT05vVTZiVzRDUzFYa0tDeFJ2dC9QeHRF?=
 =?utf-8?B?NWpIWVUraW5MTnhOdEhWbUpCLzkxWE16ZDZXcXJaSTJpUDIwS2lLRk9TOGcv?=
 =?utf-8?B?ZDU5V1dEZWZOMGxGbVdlcUw4QjhVL0F1Nk5QN3RjUDBUQkl2MmpjT1hkNFcy?=
 =?utf-8?B?NDBraTRzYjRLejVicnQ2S2RYZGVQVy9sREJiQTlnSjZISzJ2TU1mcUQ3T1VK?=
 =?utf-8?B?WnJWZzJjRkU1RlVFcTRvVGhyQ1FaL08xRmlvTjA2NldUc1pkYXlMUFBtNE00?=
 =?utf-8?B?UnpyUHpacVlTdDgyTjRxTEg3cXQrNmpvOVFrTzVaQm9NR1pVSkxMbUhscStt?=
 =?utf-8?B?MnZXZEZUdjE3S01rZDhaZnFETkxMbTByR2hEbjhmNmh5UGUrczltUkRLTWlH?=
 =?utf-8?B?NzNnUlZBTEJiallhOUdOTWwydWd2Ri9uZXd3dUcveFFpRFZ1NC90S2RTa01R?=
 =?utf-8?B?VFRFcXRDbHh2RGx6ei9BVlVLU1E1SHhaMDZZSUljOXdxMlpIZ1BpTlBzT0Nk?=
 =?utf-8?B?THFWSWNTTG1BZ0NQamRvME5GQ0lsQTlBZzZzUVZwUE10R1hSOVNycTNjeURD?=
 =?utf-8?B?SHludTg3eTE2VXJFMmhKeGZRbllDaTlGOXZEOEhaR2FMdEMwbGRpc0J3UEVr?=
 =?utf-8?B?YXdxNE1wMWVNMWFDZkI4M09INmNmYis1RHZSRVVOUUdvRkJrVmtXK01mTEtv?=
 =?utf-8?B?Mnd6MFZWWEdUcDlwZ05WRjl1ajFEL2Z5djdqUUtKdE1wSWlZd3FnRDFsTVhZ?=
 =?utf-8?B?dEFQZ05QMXgzZUx2VEZCZVZiUjVaVnhndEJiajJEc1JJcDZwK0lFMllhdzUw?=
 =?utf-8?B?aUVOTnlNSkM4NzJGRCsrRUxmeFE5MUU0bzhYaWlHVExxOStsM3Z6dTdBTU5R?=
 =?utf-8?B?dXY4cnl5SDcwcXRYS3ZKS0s1OTJaM01sZ0gvT2VqUGVpZ2ZmWGMyRTFURTkr?=
 =?utf-8?B?NkNsYnNqU2JVNEp5L1oycnNHYWFjSk1lRWt6KzZjZDM0RGpIYTRzL24xWEJk?=
 =?utf-8?B?N0YvRFVBVGl6OWMzMUkwMUxVRFhxUFFNc2ZyNWkyZTlSNGpld05ualJCRU5w?=
 =?utf-8?B?MHpERldWcTBCY2RuTTNHVDhQQmhjbjdNdHQ5K0hRNnVaL09LNnh1WW94LzI2?=
 =?utf-8?B?VkZ3Vkt1d2JEcnFDZDlFd2NqNGNUdDFmcDJpeU9LQkNybHpRTUplTmZtSGdN?=
 =?utf-8?B?VU9pVitPem1XVU1HRmZ2cm84OTcxcm5USXViQStjL3RkVWVYUHRYUVYvenRy?=
 =?utf-8?B?cTk0TllvMHRQT2NuZkhOUlhFTGpjRE9WRm4rcHJrS1JDZTVvaXg5M0lUTy9n?=
 =?utf-8?B?RzhuL1VydGQ5MFBCUjZFZ2QxKzE4ZXVUYkVoMmplTGloS0l4Zmp2VnRHWVZY?=
 =?utf-8?B?QVB6VjZycmJoSS9mRi9yaUpJNkpTUVUwc3VyMytKemQrSUJUVWVhaUtvV2hN?=
 =?utf-8?B?RnZJd1lOQ01hbFhmbFlicnNDa3FRMmtnR21GR0poVElxNDdlcVo5RXdjUDYr?=
 =?utf-8?B?YkV0c2txQXZTbzVLbUhxRUw0b2pvOWF1d09sazNVei9RbG9TdktWS2tqVzdT?=
 =?utf-8?B?NGZ1OGN3aE1meXMwNFAydHR3RVIwUzQ4K1BuNTI4SjA3c2xIUFZlSGUvRUxq?=
 =?utf-8?B?RGxJcjd1dEZmK3U5TlZCUWVYYlRCdDc2T3ptQXAzMkV0MStBenVPdkg3WjNY?=
 =?utf-8?B?eE5iRG9OWnZVRlI4eHQxcklwMHMxeVBHWEE5Q1l0SStyWDIxMm1PTS8rWGZm?=
 =?utf-8?B?T1d4ajNlS3hxNzIzZ2lIWFlMQloybTlGNkNCcDlLK1JJS2ZORDNWaFl5T3Ns?=
 =?utf-8?B?b0VIT0FGSWNUTXYxYmR2YUx6NG9aMlY0aHVLaHJxS1NEV0N5d1dWYS9OVDFp?=
 =?utf-8?B?WWR5Ri9HT2hZb0d6aFJlWXR1TmNjY014Ui9aWDBnVGtDNUlrRE1JMGVmVVcz?=
 =?utf-8?B?QmhYcVdJQmplUUthM1ZXR1ZDNFVZdS9EaDV6NlQ1QU1UbDlUcVRhb0xvQitF?=
 =?utf-8?B?VUppRkFydi9ZNlN1V1E5a0hCd1FRZ3hTVEZrcUVxRHVmU2h0elg5cUtpTTVT?=
 =?utf-8?B?VWNPUmlmdFBjR1hOeWNydVN5Rnpua2JFVFFjUFVFVFNzSDNZOW9UZTBuSDlp?=
 =?utf-8?B?MzFxRHNTSkpwdjh0eUQ0KzN3Ti8ybHA3REZ0bEhTV3djRE10YUJGSTF3SVhn?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdaf3c0-950d-47a3-2121-08ddb23108c3
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 08:36:22.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8xJCeh5gFe92WTPSgJEx5/1PglfUX6eZRiO/JpuR5/sgdUZ6hYXEPKAJipFMCJBN0n6r/vDhG70UwzwheM21AXGLOibSzdAAUtmHqmkfdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7821
X-OriginatorOrg: intel.com

On 6/19/25 00:24, Jacob Keller wrote:
> Various cleanups and preparation to the ice driver code for supporting
> SR-IOV live migration.
> 
> The logic for unpacking Rx queue context data is added. This is the inverse
> of the existing packing logic. Thanks to <linux/packing.h> this is trivial
> to add.
> 
> Code to enable both reading and writing the Tx queue context for a queue
> over a shared hardware register interface is added. Thanks to ice_adapter,
> this is locked across all PFs that need to use it, preventing concurrency
> issues with multiple PFs.
> 
> The RSS hash configuration requested by a VF is cached within the VF
> structure. This will be used to track and restore the same configuration
> during migration load.
> 
> ice_sriov_set_msix_vec_count() is updated to use pci_iov_vf_id() instead of
> open-coding a worse equivalent, and checks to avoid rebuilding MSI-X if the
> current request is for the existing amount of vectors.
> 
> A new ice_get_vf_by_dev() helper function is added to simplify accessing a
> VF from its PCI device structure. This will be used more heavily within the
> live migration code itself.
> 
> REVIEW NOTES:
> 
> This is the first eight patches of my full series to support live
> migration. The full series (based on net-next) is available at [1] for
> early preview if you want to see the changes in context.
> 
> Some of these changes are not "used" until the live migration patches
> themselves. However, I felt they were sufficiently large and review-able on
> their own. Additionally, if I keep them included within the live migration
> series it is 15 patches which is at the limit of acceptable size for
> netdev. I'd prefer to merge these cleanups first in order to reduce the
> burden of review for the whole feature.

I find the split to be very good decision, here we have the easy bits,
with the complex things left to separate series (instead reviewers
facing them after reading eight and already tired ;))

for the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Link: [1] https://github.com/jacob-keller/linux/tree/e810-live-migration/jk-migration-tlv
> ---
> Jacob Keller (8):
>        ice: add support for reading and unpacking Rx queue context
>        ice: add functions to get and set Tx queue context
>        ice: save RSS hash configuration for migration
>        ice: move ice_vsi_update_l2tsel to ice_lib.c
>        ice: expose VF functions used by live migration
>        ice: use pci_iov_vf_id() to get VF ID
>        ice: avoid rebuilding if MSI-X vector count is unchanged
>        ice: introduce ice_get_vf_by_dev() wrapper
> 
>   drivers/net/ethernet/intel/ice/ice_adapter.h    |   2 +
>   drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  14 +-
>   drivers/net/ethernet/intel/ice/ice_common.h     |   6 +
>   drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  12 ++
>   drivers/net/ethernet/intel/ice/ice_lib.h        |   8 +
>   drivers/net/ethernet/intel/ice/ice_sriov.h      |   7 +
>   drivers/net/ethernet/intel/ice/ice_vf_lib.h     |  34 +++-
>   drivers/net/ethernet/intel/ice/ice_virtchnl.h   |  19 ++
>   drivers/net/ethernet/intel/ice/ice_adapter.c    |   1 +
>   drivers/net/ethernet/intel/ice/ice_common.c     | 233 +++++++++++++++++++++++-
>   drivers/net/ethernet/intel/ice/ice_lib.c        |  35 ++++
>   drivers/net/ethernet/intel/ice/ice_sriov.c      |  19 +-
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c     |   3 +
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c   |  59 +-----
>   14 files changed, 384 insertions(+), 68 deletions(-)
> ---
> base-commit: d16813402994bde9201030ef877c9d753227e6dd
> change-id: 20250618-e810-live-migration-jk-migration-prep-838d05344c47
> 
> Best regards,


