Return-Path: <netdev+bounces-100343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E84848D8A6F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D8C1C21479
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB61137933;
	Mon,  3 Jun 2024 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVxL9lQg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2340877
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444070; cv=fail; b=LORTGQyK7iggfRiCizcLAYQ5nQDK9mPD/7GHAgiBDAp2tRpKFFX2QAGLYHRMJIR5rkDUOpOJ6w46zNgFS+p61O5eBq5nZmxHh39G8IVsUerMrpBbhjxc00rr2agBBRbnXaDBkTq64X1yahbkUECDwigrKYKo+pTgOrAFkCVL9HE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444070; c=relaxed/simple;
	bh=bu+cHn63lubUttv0zkSAy9o/IAJPfxI7CmnNkO0GXwI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DH5TR2RrLBdO6O6WDz0CrGkxCY1JLb1Gx/NWIOZKkJXL0ye/HtevOtElg+5SF0EbR6+80yXRpx/J/7kyfNyosBDi6i2V7y1J8WpgIICes8okyhWOHLGialHzSdVtyXUWZR3g8Im6kqIIA0JaElkGv+huwZeCjfaT5LaHS2c1Ypc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVxL9lQg; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717444069; x=1748980069;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bu+cHn63lubUttv0zkSAy9o/IAJPfxI7CmnNkO0GXwI=;
  b=PVxL9lQgEobtsR5wqSDzRUC7UT5dwERMBW+3HjSjWdH6mLIHzCsiwDZa
   mowBqN27e0cjv5sgk5398FtL7D0kSQe0hq+weRVF5gGI/ycBod1AlESEm
   8YkWCScX/7cWxkm/rnA0FmiXxJ/acVd+dkZwTI0x1myowWr3UeR92ILwp
   8m4OMlBK+O2XQIOizsDD1fCOCgabnU4EGoGVU/xgq5ySNu9GKqEw6zl3D
   FaqAviRnju+BgvF8vY9fUoVOXkBtchE4iLfVlwWV660sOK5BZ4hXzZ7bL
   M5fcxWuho6SS/nUqnpa6PQUCAZj/i9glku7SV4T+MappBQB6IlSYTh+oq
   A==;
X-CSE-ConnectionGUID: P6gupQtsRq6JjnZPK5tW+A==
X-CSE-MsgGUID: lIZ7srOJRwaeug3Dp/CnSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="31488378"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="31488378"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 12:47:48 -0700
X-CSE-ConnectionGUID: u/EfcY4qTc6hFsoxN3mG0Q==
X-CSE-MsgGUID: YoPJyXURQGaLlmW7XOPIlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37436673"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 12:47:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 12:47:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 12:47:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 12:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW23Oim9WKdmUbrdwkfww2v2AcLd8R9VaUATNnv6P0BaQuyrpQJYh8Slr/5YlqHnJarwRfD0Pb1/Neo8Fl/T3ObFwE3VsrUKHgxEvYGFtueHM/vUQ22996hamJ/bJXby5LY+L0iXm2uz0ZxfGB6ZUPk6mUEKhk2Is0ji7JEu8wBv7rWcIFdA1MbpdcxAeOPWhxg7L7fso7u9hsdFobG0eW2tah9hxQ+mAfOrzfGdeVflnigLBRv/8nhMAz4gV3cEtj8057f9HBfgSibDJsyR7Zb20E8yqmlvuhWV6F12KRA0xq9fm7G50PpZVHkJUCI/L69Idz8M0XEzPLEfWJE1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4dlHc8Ii6pve9lMypWrcvABjSn3aGCvnQDI4L19RUE=;
 b=KxRI3qeIX8ud1aa2Rgr5ayutkjVXI0yoc+w+9FeEyFFFz67MwkC5IAGIctRi5ZfVZSLpDcO0z4zCmTNPIiLlKnZyCX34fwFQpcH+4f8BpR4E4B0AYBnHXtIxVvNJAuSs3bbRibyHjcpApWxCyUJ99v1f5O84oGNq7uVxej8aJdh5dKb6bWRky78MqfczSGPyyjRQQbGgj6WfMJ8jk44ZhxJ6wbs84PpYIhZmEisL2nYH3HXy7ZhUgvSTkNZ17KY7liP8c+aCUAetHGwCcsZHGIUvguXnoVD+x3JBn5E7zMl7WCnoZi1JwkaK5LjW4ZZIp6aa4CwLfkV1ap3dr1oMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 19:47:45 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 19:47:45 +0000
Message-ID: <10ffa7ab-0121-48b7-9605-c45364d5d9d4@intel.com>
Date: Mon, 3 Jun 2024 12:47:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 07/11] ice: Introduce ETH56G PHY model for E825C
 products
To: Simon Horman <horms@kernel.org>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Sergey
 Temerkhanov" <sergey.temerkhanov@intel.com>, Michal Michalik
	<michal.michalik@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
 <20240528-next-2024-05-28-ptp-refactors-v1-7-c082739bb6f6@intel.com>
 <20240601103519.GC491852@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240601103519.GC491852@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:303:8c::21) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SA0PR11MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e11d836-4c03-4023-3d60-08dc84060a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmFVUTE1QWVPQWg0eHFscWhtTHVpQmkwVTNPdFd3dXlZMDJ6N2NaZ2R3dVlH?=
 =?utf-8?B?VG41aHd0SXBmQkM1K2U5QW9vTlcxNmdhdG80ZFhtYnFuQkVMY1ZjZG1zb2pq?=
 =?utf-8?B?RXhVNnFwY0lCZGNkUWI0VmR2VHA4eHNrZmRySE4xOGlaZytjUjR5eWJmTCtL?=
 =?utf-8?B?MmJYaHBPM1E5R3dtL1hhbEhxUjZleVR5aWt1N1JmenU0KzNoUFJXY2tzd2Z6?=
 =?utf-8?B?ZDRiY09PTTE3djNjUVVRYklJbXZBMGpJdktvd3JaZ2dENGpRTXlJRXVwSDBu?=
 =?utf-8?B?OFVWdXlhODBGOGZ1dDE3QkFHSFRiMkR1OGtudjA4K1BqaUhSaS9UYVRjb2tL?=
 =?utf-8?B?OVhMM09EQnRBbm1wbEhDeGpUOTNBNDBnR1RPSDNYMWxja1c1WkVCamV0KzBQ?=
 =?utf-8?B?SFpxSmF2dVE1V2FQYys5a2ZqdEZYWWs2ZDdaNHJrUUdCWkdYcEFLbGV6dFRC?=
 =?utf-8?B?Rk56WFRZc0laR0s1dnExdHRJdDZxV29jMHc4RzRIUVpZOFVPZzh4ckc3THZN?=
 =?utf-8?B?NUpwZ1h0QjBQYmFXYUJnQTJRREtKKzErTDJkaE95b3RyTkpjL2NzNG82MjhR?=
 =?utf-8?B?ZUFEcFMvRUU2bzNQbzlIdXNXNDVUenY1UHRpR0U2Z0NyVkxVVWtxekMyeTcw?=
 =?utf-8?B?V1daZXpDRHVROFBndlNyVU53cnhiWnpUeE5QS0JkQXJxdEQwV1VIUEZCckFt?=
 =?utf-8?B?eDdBSzNVWTVnRmI4d1FTbjVwUW12VGhRTE9IcTFMVEFvM2k1amRLa1BFdFlI?=
 =?utf-8?B?QVRIcUFwNnptMi9MdGtlcVZoaEN0Zkk5azFod2tDNVJZa08xWTZObXdBbmNq?=
 =?utf-8?B?M1BHVjcvb3hLWkpUVjhxUnpoYVRYbEw3L0hSYmdBVHIrdE5zM3NYWjdiRVdy?=
 =?utf-8?B?Q3g4RWxRSUFPZmVPM0dtaEY4RzZSck4vUzY5WkJLSkxsRDJBUmtrcWxzNnVZ?=
 =?utf-8?B?d2tiM0puVytLMHhaME1IK2VMT2hQcjhIdzBIMTFndHY2ckl0M2N1Yk5nQ0pw?=
 =?utf-8?B?Qm9qVWlZRFF6ZWF5ek5DcSsxWlJuRTh4em53a2NqZW8velpFdjdEWEpoU3Vo?=
 =?utf-8?B?MUJPL05wSzV2VzdvcWFmUjJ3ejRmNS9KWHU0NlF6eFhHcWdQZEliUU9USGNq?=
 =?utf-8?B?SzkzMWV0UHl0c2lpUk96OUNjc1NvbUlWY3h1bWFtcTlZcVRLNk5EWnpXblZS?=
 =?utf-8?B?YWFsNlNiTktITXZmNGgrVVZERVcvbXp4VThrZEtNUFZVTGdGSG5mWlVXTnNY?=
 =?utf-8?B?aERJUVN1S0ZFWkNGaS96cmhYZE03L1dScWdtalJuNC9lbW53elZWdUxGMzBZ?=
 =?utf-8?B?U2dIUGpid0I3OFVGbWNhOGRmYlN4T1NvaVlTVkw0dERjM0gwSWpQdTdReGl2?=
 =?utf-8?B?K2ovbkJHWmtETW15ZjJQTExlWGhnWlVQSXZwME1xRzhCR2NKd1Bab1dCZXJw?=
 =?utf-8?B?UFJ0MzE3RlVrL2NrTmZzNWRTVjFSd0tGczJOOURXODlhb0JkMEVRUUpxVEJ1?=
 =?utf-8?B?Qk1vekM4TS96K1BhK0JhdTBDSjE2Nno4REgxcWZMTEhGaUd1bXE4cktJZFJL?=
 =?utf-8?B?bmFwYUVkTTRJUDdMekk3Zkp0dUFKRUpPUEk3a3NSR253RWszTTRMZ1M2V3BX?=
 =?utf-8?B?VXI2Z2pHWjN2aDlhZG5nU1NqeVAzdC9WdkRjOUVDRUV3Yk1mK1ovd2FLNExs?=
 =?utf-8?B?SFVLUUJEQjFGQkY0ZTRHMHQraE9SYlQyNkpLeXU5eFNCSDEvWE0vQ2xRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2p6ZmRFNzYxZWVFUjFZZHBjMlZ4ZTM0R3Q4SkJlMnkzSkRDMVBaUHQrVisw?=
 =?utf-8?B?YUtvLzA3ZGs5ejFTbVUwMXVzaVFMZzJTUmx0UkdraTlIY211V1loZGZjUkNl?=
 =?utf-8?B?ZkRtTnlKbWROa2FLMHljVkR3YTU4Vk8vR21ITkUyT2NvcFNaZllSV1hUUEhG?=
 =?utf-8?B?UUhKb25pcHVjSWFQaWp3OFFtMVM2SmFLUkhQVUdJUHc3ZVdvSEtSb3c2QUM1?=
 =?utf-8?B?V2xMWWE4Nmd6TUhZcUY3WDVwTnB3TGJHL01pM0FQVVlabTdINUV6L3orSklx?=
 =?utf-8?B?QnoybEtqb0d1MnYzbXBPbm9MR1J6cCtnRTRXNEVDTHdCeVM5azZUcSsxV3BE?=
 =?utf-8?B?RFRkT2pQZFdWQWFNWDFjemt1Y3dFaHVuSlR4NUpOYjlodDJLWXdGMVMxNVJW?=
 =?utf-8?B?KzV1SFhrOWptL2xJb1VnbXc4QUV3Nmxnd1lFdUdMd01jQXo5N2RBaGZZQWNS?=
 =?utf-8?B?RDdYRHBlQjJMbzczdytSa3hWcEVPN0dWVXM4VUhpa1JubnZaWENnQmFjZHpq?=
 =?utf-8?B?bWpTdnFWM0syYWdUUjl3T3V0U2xFR1hLUTZRdThnMnRTWGM1Y2R5SUxNOXRr?=
 =?utf-8?B?Q0VTSGZXaW53bEFZeVZEZDZ1TlRoRFkrNTZ3S3JwSDkrTEFCbDhpTDdaVHRM?=
 =?utf-8?B?dXBzajBVZEhMUFRpa3lYaW1qYmU3bDhPRGxwb0lDRksyZFRKODdqZHFKc2dL?=
 =?utf-8?B?SXlYdWhlYzhsbjZPK2M1bmdtOFQ5V2xhb0NHa0NyWENQaCthV3JqMmY3UGda?=
 =?utf-8?B?RDhOZ2ZrMkRIY3VvUFZwU2FwQ3I1QlhrM29uMWpLTTFxU3VCanhwdjI0RzZ4?=
 =?utf-8?B?WlV6bis4MzJKRE4xU3FDUytrbm1VUUVtTnRBMGxHWnFPSG81TytXcnBlQU8x?=
 =?utf-8?B?YngzQVAwazM1endWNTY3M216RDl4eVNOQ0tOSTZyemxNbHBuekFTWW5MUzFV?=
 =?utf-8?B?ZDMwdUpxbGw0QVkvMklqM0w5NFZHcWRmQWtEc2NaNThnYlMyeFhqN2lLLzNB?=
 =?utf-8?B?ckZvcDlXT1MxRmVDK2VzSUxlTFN4a0dUZ2k5Z2NZOXhMeG9kQnhvMDFWOUVT?=
 =?utf-8?B?ZElLQ3pCdUZ3MUxYeW9HNXMwd2JvTE5lUlF4SXgxRnNub2d5KzVuY1NHZlZz?=
 =?utf-8?B?Y2NMUzIveTBhVjlYczBHb1NrbnMrYkNyN1U0NUNkcGNjSldyV2E3d0c1QUZr?=
 =?utf-8?B?V1Exb0VYNzNqMk5WSjNTK2orL21IZ25BdWZ0YzVVNTZyNld3MGc2Znd3OGxB?=
 =?utf-8?B?ZU9GdlFWU3RXTGx0d1VGWHpFOHlNRkUxb1FKajNBK0poeXRmRklUbHRnVzhq?=
 =?utf-8?B?bGxRanpOOVNzSVY5MTJ4NWh0T2V5V3plQ2I5enZrMkQydVhFR0tBNTNIbXB3?=
 =?utf-8?B?eDBuMGo4TE84U29KQmVQOHhWOGpSRFpFT3EwbVM3eEZrdFoyNE85OVBtUStG?=
 =?utf-8?B?alpNRVFYVUs0UmxjVHpMMTJhaXV2ZHNEODJCSFplM0RsMW5zdXE0MHROOEtZ?=
 =?utf-8?B?K1pnUC9HSkVBNkJucHNlTUFSU0swL3MvQzYrNy9kTm5aTkVjemlHMFZEYmEr?=
 =?utf-8?B?SjIxMHdSTHpSRmUzbVJSaDZ0clVnc1c5YkdGbkxPWEJCUW1aRXQrdDJUd0lE?=
 =?utf-8?B?Snhhc0xGRTZpcnFJdVkwTlhQSzQxckpXMUxuQ01aZ0YwVEZESmx0UmdwT1hP?=
 =?utf-8?B?S2NrSS9Dc0tXeHU2dU4rZ3YrdlZmMnFjc1BNS2JpblB3K0ZSUGw4djdWby94?=
 =?utf-8?B?YS81NmxSRjIwMW1KMHN6YVhjVVUzVVdSdjhWbXdBNzNEdWZoQTRtRStDZ3Jw?=
 =?utf-8?B?YnJQKzdYb2x5bmVkUnlMeVVRRW42WnBGSlV4Z0V3UVRld2U0cElrZk43Z1FW?=
 =?utf-8?B?Wi8veGs4SE5Bb3RtcUY2Y3F2YjVjZ2tPQnVwZms0SkRsR1dMOEhhNDVPbU5z?=
 =?utf-8?B?S3d3SHFJdXpQVE9kVUZydDZTaVRDOGd2SXhnM0M2VDhLY3ZtTVNybUUvcE9R?=
 =?utf-8?B?RE9HdTl1TkRmVW1kWGgrTjNqdDU1NnlGU0ZqcHIvalc4NSt5YUNZbS9tb3JN?=
 =?utf-8?B?aHIyTXhJdVJQK1NBVkowcFJERXhjNDd0dFI0NEpFcU1QVDFmdlhBQ0c1Z2Ex?=
 =?utf-8?B?T0dmL2tET0NEVGZuRHRBRTZsVFkyMXZoTFU5RHovR3o4ZmswT0tCbStiNC9l?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e11d836-4c03-4023-3d60-08dc84060a33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 19:47:45.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmEKVL796nLsBEtysa0qNERWd3Apuphsq55/A1N8IlVi26A2BScqg3bTMUpu6lc28neegYZyCpxseHy8JWpkYQS97jbW2B9B2vyED+VKv8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
X-OriginatorOrg: intel.com



On 6/1/2024 3:35 AM, Simon Horman wrote:
> On Tue, May 28, 2024 at 04:03:57PM -0700, Jacob Keller wrote:
>> From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>>
>> E825C products feature a new PHY model - ETH56G.
>>
>> Introduces all necessary PHY definitions, functions etc. for ETH56G PHY,
>> analogous to E82X and E810 ones with addition of a few HW-specific
>> functionalities for ETH56G like one-step timestamping.
>>
>> It ensures correct PTP initialization and operation for E825C products.
>>
>> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> Co-developed-by: Michal Michalik <michal.michalik@intel.com>
>> Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
>> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
>> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Hi Jacob,
> 
> This isn't a proper review, but I noticed that your signed-off
> appears twice above.
> 

Yes it does. I developed some of the original code which Sergey used
here (hence my Co-developed-by and Signed-off-by). But I am also
covering for Tony and submitting the patch so I added my sign-off-by to
the end of the sequence since I'm the one who submitted the full series
to netdev.

I'm not entirely sure how to handle this, since its a bit awkward. I
guess there are a couple of other ways we could have done this, from
dropping my co-developed-by tag, to moving it to the end..

