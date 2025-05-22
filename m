Return-Path: <netdev+bounces-192841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F7BAC15B3
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F72C1BC1691
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2F242934;
	Thu, 22 May 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1pBIXMW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ACE1E1C09;
	Thu, 22 May 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747947246; cv=fail; b=ortHFcAIFsth0XjOPvBhqHFnYCKqIxlJpdXb9sg7UFTv5+38XQjm0lLJ1hO10XtABvV7sk+n0yPW7AGXDTa4sJigTfTGWGnEAd9i0r1DxOQVwEgW6PKJ6gAcQvUTrPng60R9WX8BqXYjbMM8uDrx79/EzegAk+9Ps4qXCxS1xQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747947246; c=relaxed/simple;
	bh=328P35+RVL/UtIBm9n0ms5e1FKmD3HrvjccR1gHMywE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MkngfUblGngkCb4C/kvDK8sUw5V6KpQfTyaIytwvcjbte9lzFE0Aq7H36uCL7+6g6YA02Yoejpt5Ftifjdqz3blvZ1mYm0f0WK+BalgV1oRTlzbwUANZMKrSR68l8c9lhqY4JW5MHWV1t2e9d8z9v2Xg3R1g9nmzAZC1yoKA1xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1pBIXMW; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747947245; x=1779483245;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=328P35+RVL/UtIBm9n0ms5e1FKmD3HrvjccR1gHMywE=;
  b=I1pBIXMWDVJXcIzheS/l4o3Go4l/yntIhOf31a78nN7e4thkjbFPx83R
   /31DFGEZcpV42snwbSTCKS2QvqX0JOhwdqnSeQjRWAx80wXfI/eTMZjq4
   ydz82YzDgKyxIoIB+ILH86dJXuiIT1enDaeaVV1O4FsebGwbZ7Y9cZayl
   VLp5dlSwtZ6Knfa55dqug/sIKNSv1A43bFoZDF/VCTknEe0TPvmmPaaOC
   Xr2qoP6O9o0m0PICZvY7xDBl6/bdTuBKpr2PEyEWsFSBKuStKt9f9PKud
   ztW8avE/H7N9XxKxeTDFzJE4uc3xsT2zQ2MZRcp5PfHMbXTzrSrekID87
   g==;
X-CSE-ConnectionGUID: gqOaj7KrSBKUGZiv1Y4laQ==
X-CSE-MsgGUID: pZ8Yw6KUQtOpfARDfSGjwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60647761"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="60647761"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:54:04 -0700
X-CSE-ConnectionGUID: wuH6Zz/FR4KMaVz3cKAwBw==
X-CSE-MsgGUID: CKr9fpYcS1WxUMXj9Kfpug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145484747"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:54:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 13:54:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 13:54:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.61) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 13:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucpoOc9m4vBoNqTkuGuQsxKYqHUQKW2vZoSh2KW3HSjaojRue3HKAsYI8G0NEKuJER5jZ5wtJ+TT9c1zgd1eXS/Hn0SyQFw46HnjoROA0VCPPTzy6EUpNbEUkgA0N4oR2H2kAdXSoXmc9k4JQ+tc8ZzLKVhbVBdepyAtN7fb/rnyLSmK2C/IwsdkxqGSxHtoWHoiLK5uGS+f8gG+So2WvlqI0VBJ5P/Dyhyp4eqfvW8U3eE5AQcZhZIeUSll9G7wXR6Ys7mdFLbbuSqQ7tkWue92jqu08RCRCOy86gumwCVOQEtmETJTMeBiBjvDsTuWUvNu9xyNPf0zlJlMwJ1JgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR9kodWQ/bzQ/f3/TmGSfFpmLbp00+NfbW0U9UsnHaA=;
 b=wQ5nx0bpBowjEzB5lWyVLq6LR5YTqtZ1GnY+tNxcM/0RLekzxJJXrV5ffG7tSt8S92sPz6WTzzZhB3gAHavAQpeQwpLc2M0BSbLYD4D0SpnVFFPU6hILaX738ldqXao/sMLjFtc1SKRbICEnFUrKeKXPgS9QsCaLPzWkpLnuz9ZnknaGnz5cFpLnNOoJDoYHi7LCVrrt2v9pZIGp0CAqSVc+suBKpJipSj4QnRAQG8GBJw2j8MATk0o+OfFtHZ6Q/zIc0iEL3ADS4TUQYrRrzRQ67UvoqM7dE6IY+olZ3NxnGaoBZ4f0/Xy1BLbdqfFlduM+vX6EAZAFMOYlKmO32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH7PR11MB6697.namprd11.prod.outlook.com (2603:10b6:510:1ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 20:53:15 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%2]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 20:53:15 +0000
Message-ID: <1153fdf3-581e-4c35-a24a-55534e1e9a5b@intel.com>
Date: Thu, 22 May 2025 13:53:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ixgbe: Fix typos and clarify comments in X550 driver code
To: Alok Tiwari <alok.a.tiwari@oracle.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<darren.kenny@oracle.com>
References: <20250522074734.3634633-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250522074734.3634633-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0351.namprd04.prod.outlook.com
 (2603:10b6:303:8a::26) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|PH7PR11MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed25fb1-2312-4141-e2c7-08dd9972ac72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUx3TGR3WVM4RkFwRmFoS0lVRFJBQlJrOWU4YVBWNDdRelhScFcwdjNHcGZu?=
 =?utf-8?B?bDhxY3VtTU51b3lWZ3NXQUtkZFNSRHBxaERwakJIcUFkWGhXN05LQmpHWHk1?=
 =?utf-8?B?T3I5UTl2R28zZG5XMVVXYzhhanQyL0hudXlUOWF4cmFmVzlFYmFnaStHZ1pZ?=
 =?utf-8?B?OW1jSEpMMGZTQ1ZWVEJSSDhFMVpWMTl3UFVXbFN3dktUeXRzaXZlUHdaNHFP?=
 =?utf-8?B?MFdNWHFFYWMxOHBsRzhxZG5YQ3RpMVlhSmVENG5pNmpLSi9YUnBBQlh5UWUy?=
 =?utf-8?B?cEQ4aXk2UUtidXZhYUs0WW5oalh3eUdGS3hiYW9ZVnpZTHJoYzZXRzdSSEYv?=
 =?utf-8?B?blQ3TDZnR3VHa25DNWVVOG1lQy9CK045UTl5dWpxeUxNL0lPSzZxbU13TEUw?=
 =?utf-8?B?UkRJdFd2OXVpZTdiaWtLa2R4STg2ZXZoVU9YMktkS0tGZVB6Q29DSWc0Y28y?=
 =?utf-8?B?UWE1Q1Y0OEMvcFJ4YU1wMlR3cDJDVGVZT0FuRjRUdG92TmdMaHZsNlM3Wk9I?=
 =?utf-8?B?WVRFdUlQV2ZYM3BzZDlQL3o4WTdFOHBBYzFDT0ZOUGprN3JIaE1BNmIxazhp?=
 =?utf-8?B?aEFURVVoWUpuOUpCeWJ5aC9nUENoNjY1cHk3VVkxUHRQM21jMzJGVTU0bGdi?=
 =?utf-8?B?d21vSi8rS0dycFRZekRQY0Ixb0d6QVBMYUdyZ3FnNm9USC9GZ1daUG1oUTJY?=
 =?utf-8?B?c0Z5Y243Yis1MTJTTEMvNXYyZTJSWjBJV0FHVi8yaG5ia1c5KzQrQTJoZ1pz?=
 =?utf-8?B?ckQ2RElUTEZGcTVSZExpYms3Y1lZc2tBYTlXNGhhdWF6VEVZVHlzNThjMFBo?=
 =?utf-8?B?YjZOc1NPdzMvTko2NmxCU1lPM0FMKzArTnBWUXpQZFZkeTMwY1pERWlDZUN1?=
 =?utf-8?B?VjhCYWdaWWFGUU8xdmxzcDBkdGx4eUdhM3JnTndaRGkxQ00vVXJQSTd2Vmdt?=
 =?utf-8?B?UjZhdzRUZElBZUtqOUVwa1I2UlZZQ2FWakhwbGJDMnpyV3NiaWcrR1k0QVRw?=
 =?utf-8?B?WWNTWitUaFhOWEw3bXAxMTlIQXRhei9BTFh4ZHdjTmNoU2l6bTdDRWJwVE52?=
 =?utf-8?B?bWNtUFZKbGIxQUhveGhYYXRHc0RDS0RxUHlldG9TYyt2eTVnQnRYQWkwb1dI?=
 =?utf-8?B?QThXWmN2YzFJUGYveXE1TDIyNHlZdmNIc2tqR1RrUHNoUUZ5VEdQd2VwaEF4?=
 =?utf-8?B?c2szaXNwNTVKRjlBeEl1bW9nZFBvanpnWU9VNFFjZzZhaWNiU0NoNHBtUzlz?=
 =?utf-8?B?UXVPTFBlZmdna29iZHJueDUvaHhWbVZtc0ZwNFZCc2k5NWx4cnd5N05hR1dN?=
 =?utf-8?B?eG9XbDFvRDMrd0RxSkxDWmNTN2hQM01vWEsvbTVDT2x4dWtjcXZjQ2RFMXBD?=
 =?utf-8?B?NmUrZmliSnNWMkFXVU5zMFhYZjR6cVlTMW5wYXlqamJocjNHc3dma2lLOEl6?=
 =?utf-8?B?Zk5hd0syeW9HZk1ZRElKYmxmbmhRYlUvSXlRd0ROSStibzE3bUlnQ3RYSm52?=
 =?utf-8?B?aDJnbWJjdXAxLzlJcitIeFdvRk9OQzZKMGppU0ozZkVSUEFoUHI4YXc1R0Nt?=
 =?utf-8?B?K3VrSFJHL2J0VnNNZm42TkRGdEdNRThuRGJMdGJtbG5NVUo1cWtmM2w0SWRj?=
 =?utf-8?B?dU5NenExbW9lOHRvc2Y1YzVCT3ltQVNlU2Y2QmpMcHpWZVNXY1hWQmJjMy9x?=
 =?utf-8?B?RDZJNm42NnZXb0NSdkJxTGhIYnJGWWkycXZwM2VSdElyUkh4VkFaczI3eGgw?=
 =?utf-8?B?VFU3MWVKRGwyS2dzNkE3Q3lGV3dCV1VVRFVRVFJIT1U2c0VsZXpHVThOdHJh?=
 =?utf-8?B?WWhZcG5xSDI3MmhmaFpSTUVyNXd3REo0YkpMUmhaaE5OTlhadGQ3VjBWZEFm?=
 =?utf-8?B?Y0VwNWxOV2R4YjEwbjlDL1V1dGlEMWZYZ0d6U2w1NWZJRFVFbkVjSDNVOHor?=
 =?utf-8?Q?aWcqBEfBR/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RaL2FMT0ZWMGNUS0dnSndTOGNVU2M5L3BldXRjR0dvNllYWjloNDJYekxY?=
 =?utf-8?B?S3JYbWJNOFdJWVJqRU42b2dSMDROSGZ4UWEwTWhDZlFmMEw4M1hsQmVvWTZN?=
 =?utf-8?B?VjFhYnAzRSt4ZW9leFVkcUpWTnZNaDZ3Wlk3OVpDcXNhNlpnY2l0aTE0U054?=
 =?utf-8?B?WityWDBDWTFoMnJwRlpkcWk3cEFRN0NYbUxnQ3NZMFdkYmwxMXVCbGlFcEJs?=
 =?utf-8?B?Uk9YT0pQaGZ3bFYyWlEzNVVWQ0RPZEd2U05SVWVzRjgwS0xuL01FWnhLMElr?=
 =?utf-8?B?S2FtNUp6bnF1cUV4UTQ0NUxGcVoxTnN6ODFsWmk3YkxpVmxOUndVZ0hyTjc2?=
 =?utf-8?B?cjFGMkhTM3RrdURTamRhdWdNSlRTL2NDZUhiOFNLbkJqVmVCc2J6UXhNZitn?=
 =?utf-8?B?QlcvN1loMGpYL2lKaWY4Q1RCTkFXMzFQVnlQZmcrRUJMYkpmaGdveFVFV3hO?=
 =?utf-8?B?L3Z5VjNaTE9iQ3dUL3BwYXJoYzl0SVdVeVlnOWhYdWZPK1JCRDZVdWQwcFB6?=
 =?utf-8?B?bnJFcVFIWnRpVks4NzlKTjhLOTRqWHZuTUdkeFJuaDI4YjRLODNUQzB4K210?=
 =?utf-8?B?UW5nY1VFK1JkdnRQMVFzdDhPUlBvQVNOUldNN3FzZG5XRTVjUzlHd2FKcUMz?=
 =?utf-8?B?Mk85OHp0VVJtaUR2WkkvTVhTbUkrOUhsY3VVQ1dPa2VJRUlTUlhVRGhwU1Nn?=
 =?utf-8?B?VVAvVUczTzc4VUZEakhyemlXRVpkWlRIQ1YyRm1iajczRFhLTzJ5ZWJKeFFh?=
 =?utf-8?B?U2NzQUtYc3pvTmhXZmlxNnZLQnFGVis2dDVOT3FVdjNOcGRaaUFtbU5PbHcx?=
 =?utf-8?B?cnMzZTJnOEZUZ2dKY3ZFYXQ2aDU0bkVLeUQ0SGJxSmlYNmZhVFBLWGVoSG5o?=
 =?utf-8?B?Qm1pUGdTeWhyakFqVU92NzhFZ2xTNUE0NldDdGFGQkZxeDNYVFNWQ1ZqWk5R?=
 =?utf-8?B?aVV0MDdBS29DdU1jYWRMSTc3b1loNHpZaWhkeHdMSHVtMCtsNUhvaGJ0Vktj?=
 =?utf-8?B?SnJvNnlyV0pzSnpKRUlUc05YVlozcUI5cm5CK1Q5Zmc5L1c5SnI2V3NPbEFN?=
 =?utf-8?B?TGU4ZGRXM3JqczBzMC9yWk5zRUZJYUdFdEhPcVBhbkFMZVZGSm5wZGYrYUtF?=
 =?utf-8?B?NmRiQk0rQXAxSGF6cEIzSmFjTzQrM1dwaHdMbEN4aVlWdGpWcGNEMHI2TEEy?=
 =?utf-8?B?aTFDVTFBazdEcmRpWDUvc3NYZmxqTHRRbWYrN21vUFBQN1dzZVV2TnR6MjNI?=
 =?utf-8?B?N2FxZU1UQTZZUzFSRDVQTG93bENvSjVBYWY1TmhXNGR1SHFPSWtaMGpyUG56?=
 =?utf-8?B?ZGx6bHlWQ1djTTBUMFNVZGp4YUt4YjBwZzNROVdNN00xUDJQSmJjSGNVMy9S?=
 =?utf-8?B?UFBoNkpGNWNwekNXcTgzNmZKVW56WDNFZ1g0SUZCN2dzZHBkWWg0OEl3cWg5?=
 =?utf-8?B?YjNaK01YQ1BVMFF6VVBwVzlNWE5wUkxrWVRQNVQxMXBKY0pQVGFNdTJGSTBY?=
 =?utf-8?B?SklsRWZ1VzZxUG5mTkRtaGpCMENEMzlCWDJSUmMycXJwU296ay9QdGtYVjNw?=
 =?utf-8?B?QjBBaU0yd3pYdnVXWUYzUng0RTU1TDJYMG5GMDZxNHFxc09SWGZyOU1NM0ZX?=
 =?utf-8?B?V1lUQ0tZNjhib296VWZFS1Z5WEg1aUJudmo2dVNJYlNzQ05YZUdjK3VZMm13?=
 =?utf-8?B?UEVPUVNBV0xBakEycjNtN3JuYitiTGlrMzVCY0c3SVpycW1qTjNTU1FLeVhT?=
 =?utf-8?B?Vk9JNVlET3hrMS9qTnZPTXNCdURlYTIrNFQwdFpxRUVWVGNJcGJzTVBOL053?=
 =?utf-8?B?WnZkQTkrY2hXMUJWMGRFUktkK1ptMzJHVUpPVHkrRmxibk9EbFVRRFNvc0Fu?=
 =?utf-8?B?NjlUdlNRdjJGaTZPVUdpUTRvVlZtYUJMOThyaFRrRWFrVXpKemlsTGY2ZnNM?=
 =?utf-8?B?ZWQwVlpwRno0Wi80NEVBenlYRHFhYktZdzJ5dXlGdjh3OUp0RjAwVUZVTDRo?=
 =?utf-8?B?NGhDUzdhaWw5TkFzcUVGTGdubXBrZ2RxbTE1VWdQWGY4NEQwR1MrMzJXYWtN?=
 =?utf-8?B?ek9COTJZdndCYS9TUkRSazZmUTdWMFdnNmkraVF6T2lLQlVLczJDUHRsVEtF?=
 =?utf-8?B?VjRJK0VVSlVrNDZPdUcrL1QzMHZJZHF4Sm9XaE1RS3UyQm1EWFhxMkc3Tlpi?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed25fb1-2312-4141-e2c7-08dd9972ac72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 20:53:15.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZmb9YVN43ZjWLjw0b0jnKoOFgMAMtjmWWZf72QOw1zi2OeNB5iI69DAO67wfuC/becw1TmEhU+pwsJJ2VtK6XHtUAvoaafV4HjPDGZ5IyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6697
X-OriginatorOrg: intel.com



On 5/22/2025 12:47 AM, Alok Tiwari wrote:
> Corrected spelling errors such as "simular" -> "similar",
> "excepted" -> "accepted", and "Determime" -> "Determine".
> Fixed including incorrect word usage ("to MAC" -> "two MAC")
> and improved awkward phrasing.
> 
> Aligned function header descriptions with their actual functionality
> (e.g., "Writes a value" -> "Reads a value").
> Corrected typo in error code from -ENIVAL to -EINVAL.
> Improved overall clarity and consistency in comment across various
> functions.
> 
> These changes improve maintainability and readability of the code
> without affecting functionality.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---

With or without the s/accepted/expected/ suggestion from Simon:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

