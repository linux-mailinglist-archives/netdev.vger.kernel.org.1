Return-Path: <netdev+bounces-181821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66722A8684B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB3844202D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7328F948;
	Fri, 11 Apr 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OupHe8xH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30376280A4F
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406991; cv=fail; b=oTho8lromVVJ3SVP8Ux4ECbel6EV7lHStMNNvQWWoR8HG0U479AVex2FyEtddw6Td1762dQ+xPaHz4BkOxuZ+gfAdseOvLcMmo6LtsZq4zyYPB9j2zFKLDfPWgtuC6yvAyZjTGeuSzk2hXGzzSx4CskfFVP/ITv0zYVIM5BzaiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406991; c=relaxed/simple;
	bh=wpBmQfvlxIH3h51f3oXhMaxMZNZlbYkD4LQEuYkgM0U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eDsaRsK5shX1HSfynT0boUBi/wRM0e3jipBGZnn9wCuZ+Tag+VpnqXck/EGlEip/WiPbXJdU+D0dxLaSrppnVPtutzyRUx35BAUFMwvI+PVEUA5De26ZO1JUQn7zeHFk9OC36brO5WLgA6w82TsnA7rXRTHtAcwmon9l4MiA3Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OupHe8xH; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744406990; x=1775942990;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wpBmQfvlxIH3h51f3oXhMaxMZNZlbYkD4LQEuYkgM0U=;
  b=OupHe8xHwjsVTrZuyC1CIJ2bxhIzG1YIuthIgDVmFKE/aKsYzu9lKghH
   VfQ7X+FEgcgsQW79Psy2uZNSYOBn58ykPFQxiASplZBatOhn7e/DGBa5Q
   D07R5tJ8H4BmS/mZpm8dC+ux21ewb24zJkRaXr+uZ3hdxK8iq4xcx+Ig4
   X1ZQ9Cz1slneyMIPaS9DA4QSi3g1Rt+rIt1VvA+rjhZAsNPLY6vnPNZTW
   fspbE2XwuEo8ryz50Ce6qnLJNo3QDBokiYoNl15leXTX8RFlfD4zeHpIg
   PQmDmEoV7Zr3gThWZtrmFHl/tVG7StCv8085XiZ1f+cY3M86SBCzlQk2q
   Q==;
X-CSE-ConnectionGUID: SKGyY5fuTD2nCkgSxBRn4g==
X-CSE-MsgGUID: puDHgk8rTzW48UqtMahQdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="46135220"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="46135220"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 14:29:49 -0700
X-CSE-ConnectionGUID: JKc4O9TjRZygr+OtZ/AZGA==
X-CSE-MsgGUID: rPPs6ECDS+WAqR6KMv5wEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129855582"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 14:29:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 14:29:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 14:29:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 14:29:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfX+0WPrK0VPYyCMEvVVSuZqaMDPP16F1BmytoBxUS/ZZw8IwIpAu8knfca+xvRFFAkidwpEF0bk2tTaMUCYrWbo8jTewPKPpzeFgPmkkBpFzkjWJoKoWRGUiqxXrnbFEEIlhV+kFEihK6gIWCJNUu9ZaiO7/VyakoaklC3C1BJs8P5YUHKMILfkJY8lyIq37G3oaNxJhGoziCUjYSQXD3DAm01ZwpnJrZGiV44Gw/OSTX+dcje2KWMT//upp38vftZt20tIExxh05PcDWp+xy4Q97xM6E/DcNGwrWjvC/3W12AP5OYhgQXohme0HGcSYMddwRygcZRP/ed2YYV0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtIYwwictaK3bbpzP/Dz+Wovz17Z5z7c/+q+zLp48rs=;
 b=X5hLIh8CQsU85KP9LeM+WW1O4nM7VRHtIfp/SW8nhMHZA6BaCn/x//7u6Ao55QAbEMKe+c6TbqHczHsGTpWFya4/e/tqHWI2VVIdyvzvnSFwfeIHKLQS6cujHEbW1SKLY91EBkcFDt2jViryGt7BZtumt5MQc1FZ0XDA/9Kh15Kqyenou63UZpDi9BgYXTia2w5FDRt2LVTjNL6fM5tCIS/gB0jZm5uZWQNL7uxCvpbXoks7VUw33XTSzTAHQrY7BY7NRQkQayCg/FlU+mDXzPAA6rzG6Wd9kov9Ynf2OKlrqzHXHUKW+VKCZW9xcGcUbsDK91Dxlgq3KlONN0HGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 21:29:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 21:29:29 +0000
Message-ID: <202fbd8a-4863-4655-9e2d-8c8e8902dc2c@intel.com>
Date: Fri, 11 Apr 2025 14:29:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] netdev: depend on netdev->lock for qstats
 in ops locked drivers
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<sdf@fomichev.me>, <hramamurthy@google.com>, <kuniyu@amazon.com>,
	<jdamato@fastly.com>
References: <20250408195956.412733-1-kuba@kernel.org>
 <20250408195956.412733-9-kuba@kernel.org>
 <a2768226-854e-464d-8e76-240f7c76e987@intel.com>
 <20250410164614.407e6d98@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250410164614.407e6d98@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0289.namprd04.prod.outlook.com
 (2603:10b6:303:89::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b079d5b-b2c7-4bfa-bf04-08dd793ff11c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UktKaXpVOUlrdFhXRGNVNzdYRy9vYUFmbDBIYUU1VVl3Q2x3UkZsek5NQytp?=
 =?utf-8?B?V29SSWdXYjMvUlZIT2J6MXpJZjBpYVEweDQ4SnBVWitUOXExb0gzWWN0YWly?=
 =?utf-8?B?b0UxbVFJd3pveEs1L25aOW9ldmpkclRiUGFScE5hbzYydG1lZnh2UTdwRXBC?=
 =?utf-8?B?cXQvM2o3aHBEQU95SnZsSTMySlBsZEdwazB3ZUFCRjRjOGlHb1NGTUEwNlc1?=
 =?utf-8?B?b0ozMk44c21kekRCTUkwTFIveWpXY0NTUlNQRkVBMkdQSHBZb252OElLbHdS?=
 =?utf-8?B?U2tuQ3c2VG5RcTR0WmR6bHJILzlXVkEzYWtsRFlpNUZMbVlvdHV0TXZWa0pz?=
 =?utf-8?B?anFoSG5hLzhURFB1ZXdHZXgyb1d2UndwWU9ScndUS245a3NHTnZXUFJMNnRL?=
 =?utf-8?B?NUtla0tXT3hvUUZmOEZ5QnQ5V1VsT2prSnhvYytuWkp1b3dpNUJlT0FOcGhr?=
 =?utf-8?B?d0tibTJjMHRKRGtqMUMrVGRpRjZtL1hnQWpzenA2UkZCVktRLzU4b0U2Mm9W?=
 =?utf-8?B?ZUdvYjlKS0ZobmlFK01jMmhPMHpRUnlLZXNmTTVWZjRnVi9yMU14bjJVMW9Q?=
 =?utf-8?B?ZGQ0WU1wVWpnaFhIZlNPMHVkWU9DWHhQK3FxSVRMdFRuQ0ZoUEgxM0RFRkNs?=
 =?utf-8?B?RktSZmluWVlYaEVLbHY5T1hDZm94ZUhrdGdOV0VOOHNOY2dEVnhtNDRDNlBl?=
 =?utf-8?B?cWlvZ0xiK1V0TDBEUWxnVExsMDZYMDNmaTQ3TDZyRFU2UE50dHNVY215WWJ3?=
 =?utf-8?B?MkwzbktnZ3grTk9TcmF0Yk1FS0M5MEczK1ZFK1RFTitNS0RtQnR3RSsxdjBi?=
 =?utf-8?B?UTVUSmRRN3Y1NFFCZG5LaEE0eENXMnZDaGpKSk9DRXZuSWV3TzliU3lIWm1y?=
 =?utf-8?B?bDhGTW8yS2U0RFQyYjJWeTM2bmZIOFIwMXA4V2JvY1RtRVNGbEdkUU1IaUls?=
 =?utf-8?B?Z1dDYkJJSUtOQVhCSFNzRW41Z0FlOXZzVW9mbUpmT0hUdUZDa2JUb3Byakls?=
 =?utf-8?B?QUtUeDFhSm1wajJGUzZQRGVZcFpZbnVHbzdsSVFoTDIyaElsWDE5WEswWXcx?=
 =?utf-8?B?VlFmL2NxQWpCcnlJZzNveTlSZVBVWnpmckR2S1U4R0ljMkc4T1d6ejFWbUtv?=
 =?utf-8?B?UVFtQzNmRGY3bmQxMElYZ3V5akhGaUlrUm9oSHMrWVFNUEdZaGYzNkpjUE8v?=
 =?utf-8?B?cHlNTXh4dWVUc1VuVElnT3JoeENuMnVrZXRYbnljcEtHejVnR2RHNWkwRDV4?=
 =?utf-8?B?d3BxeUJSR2FieHYvTTZmbTNydmZsaUlacGxvN05FUXY1QkRsL043dWE0NWoy?=
 =?utf-8?B?VndaNnl4L09JSzNtNGdaQy9CSWEyamh3VUc2aDNLRllzdm5XYVJiNXBxRTRV?=
 =?utf-8?B?SEthT2NPWVFjdXFWQnRWeCsyNEpaSDJia2tvS0l4a1U1WTkvOTBNZkRtWXpw?=
 =?utf-8?B?NFlabVpmbnZ4ZmFsbUwzbGRJUkpLemtSdzhlWkxxZDRtWUhTVDRxRHhTTW4x?=
 =?utf-8?B?NWwxMDJSUFVsNFBQSnpFNlZnNFRScElIS09XV25wZDMwOUlDU3d4OVMyK0h1?=
 =?utf-8?B?OUhnVGwwQ1NpRDJqSll5MnNTK0Q5bm1JVkVLTTdSbEpDK1VaVEt2VHVUR0ZN?=
 =?utf-8?B?dGtNYlV3TTNMSjlrYkNOMm80L0wwY1R5c3hTWmttUDhDWTQ1YUR4L3lDQWxJ?=
 =?utf-8?B?ZUJkcCtFdFRGU3NRUW9xdFFUMHRNUURJZEJRa0NaZXNVeFp5eEJPQjA5ZVBW?=
 =?utf-8?B?Z28veWVOazRLclF6ZG9CdkdrTkRpL2grRitrbTM2QmtvNTRNZkx2Z2h0WGVo?=
 =?utf-8?B?NTFHTk9tMTBiZlZ1ZTlHTHZOa3dSOGZaczN5ZFhFUVA0KzNvZGpDQzIrN09l?=
 =?utf-8?B?VHl1akR0ZC82dHBkNkVuU3RkbFcxMkVjeGJLRWtncEkzeTFEVFFjb2x5dTM3?=
 =?utf-8?Q?QvN76+BVtKs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ync1VS9KNDl2QW1rSTloaHRYTElkbzdQbmNvYnFmQ1dmMEV6S2xLcU1CY013?=
 =?utf-8?B?V0NhbVN2YWp3T0hzWUxNUEE1K0tiUHN4VHZlWXdxODkwUlhjdWxQYmZDV1N6?=
 =?utf-8?B?S2tndUxodGZ2SXZ3ZVR5cEo5dnJHQzQ2eFpPUUQ1aW1YNmNubytoMjFLZ1Za?=
 =?utf-8?B?RHRtNjJWSXhGN0daWnpGUVY3bTlCQlg2eWR4KzZ0L0hLdFZvSzJocVhYQjJE?=
 =?utf-8?B?bElpdmp5L0ZPSjE3RjhpL2dDYVN0N0M5aUY5cUZBZ0VMaG55ay9BUjN2OC85?=
 =?utf-8?B?aDlvd01sRER0VTREL082Z0o4YzliQmtpMXp6NWc3OUJBd0tydVgwdkprc3VK?=
 =?utf-8?B?MWZsY2dPM2RiVXlFVldOKzJNdHRrRlRpRkhpai91disyVGJhbUhTcTErZ2Q4?=
 =?utf-8?B?enVQMjE4cThrVHRPTHl6M2N3M05oNXFTcTZvYWd3Z004L0pGNW5QZTVQd3NQ?=
 =?utf-8?B?SXh4eGhLeG1kR01BOFYxMXo4NEg5NHh2NlUyaHZwRmVTSHRrMWNweGRzMURL?=
 =?utf-8?B?Y3dXVWRmQmhvMFBhbng1bzJiMlRYZEFZQS9xTkxmYUZvTzdPaHF0QzhwVjNM?=
 =?utf-8?B?RDJPRFNJd0xIVGNYNm91bFFjNEdJUWt3ZDkyK1pCQ1VzdXZXbGE2MVNiYTlG?=
 =?utf-8?B?dnVBbVRHTmR6L2lYUk5mYVpkS2xEOTJSZDd4NUxoczE0TUxsajc4bElRanJL?=
 =?utf-8?B?ZzlsK0YxYXpqdTIwRGlvQ3pFNThDUXVZSGJuNHh2OWpwWmV1TzVlRU9RSGpv?=
 =?utf-8?B?QVBYNGpoMW1GaHVueTkzaXdhYnR6U3ZEVjJXRnk5NFhrMUlDeWN1VU1Ga3hE?=
 =?utf-8?B?M3huRGJvTlQxeXZNQnZ3c2htdFUvMG1ZZUdFdE44b2RSZlBVdXNUODdoWEVJ?=
 =?utf-8?B?TjNHbkQ3aDM5Q0RaUnFqZ0lVTUIvS0pzaXIwdDJweTk0YU5NSERCcm94TWIw?=
 =?utf-8?B?NHRGdURsdDVvQTY1VVNDcGhjTDhYanVNeTdGZVNlVEtjaURSWEdOVmZIR3lB?=
 =?utf-8?B?SDhZUjFlN0kyZ0VCVEVQeHc1SDJ5aVRhV2h0NStIbUM4ZWg1OXlTTmc0SVg2?=
 =?utf-8?B?c1hraVp4L0hSZ3NXLzl4VEFqZjRxUmFGM1F6d09ZS2tyOEFRcmsyL2hubjA3?=
 =?utf-8?B?MWczQjFUSFFUbDQrYi9YQUI4Ymt1bDhjaVNIL1Nma1hHdFBRNEN2cEg2OXQz?=
 =?utf-8?B?WE16b1l4WFR3Q29WdWw0QVdrdzFFVTRVQzhickxsZk9aZVQvdjlJWWlBQXcw?=
 =?utf-8?B?NWZDd2l5UUdpSEwxem04dnNUTmhLaXE2cEl5ZTlDUm5nbCtNR0w0U0Y3cTVI?=
 =?utf-8?B?L2RQK0pjOVc2N1JQa3JLdVorOGlWYmNtVTY0akk2dEVMWW9NenZ6aFFnWVVO?=
 =?utf-8?B?VjdEQ2VZdEowL1pYbE4wZmMrVitKTTJTNGFQdUFFNzZCQXFzUldnQzllK3hW?=
 =?utf-8?B?dWkzQTJidDNuVDk1eFZyU043ZWNQUFZvaHdyMlI5aThJNTNUdGtZZWVYN3d4?=
 =?utf-8?B?cXZBUVB5MEZVMFgwcENhM0xtemNzdnZFMldZTk5Gc2ZYeTQ5dEp5bGdlZUhU?=
 =?utf-8?B?eDVKUFhXcG9hZE1yUVpwQnFyanp1UEpONGtpOEo5RldKTnA3RUFkQWVMdmZU?=
 =?utf-8?B?MTh4QndxRitjQ09XbGtMaFVqNnJRM1JDNUg5anZQQy9PQnpnanZxampzL29r?=
 =?utf-8?B?SUNPcEJqMVNjMXl1Nk9CY3hpM3NPc1FFbnNyUzhPRXFqUG9QcW8waTZBUXlD?=
 =?utf-8?B?RCtNcC9WN3pNMnh2TFhCcTQyRXRBSWtoWVRmTkN1dUNSdElHUGZMQzFKdzQ3?=
 =?utf-8?B?TVNubXVLb0I1L3E1dEs2d1gvcVNlSTNmRXZ6RVlrVklablAvVVBiMlVtVmF2?=
 =?utf-8?B?VkhMcndZK1VHM3RGWXUyMjBZSVF5WG5kVFNlSk50M0hGTnh6N2NGNWlIakg5?=
 =?utf-8?B?YlJqVG51YkhsN1VPOFM2SDQ5azN3WmR3WnJBcHEvVTlMUTdvbWZlcTdKZ2Zn?=
 =?utf-8?B?ZXV2eHVqaHJkb0ZPRTN3czN5MGhBVHhCc1lJZy9HQlJUb0F2RCtqYW43STFs?=
 =?utf-8?B?ZXpRYnFLRThaWkRwS0hNU3lJaE9XeTBPSkdic2MvUzBpb1kxbmJGbHVRM3Vo?=
 =?utf-8?B?SEVrUUpTN0RVMDAvMjN6bjhoNG1DN0RhcTJ1aUhMUnNLR1RENGV3ckdWUTdx?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b079d5b-b2c7-4bfa-bf04-08dd793ff11c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 21:29:29.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf+8NaocC4JGkT49XAbTxDHAd0FoyAmSL98PowXCDsXrHPsfZjWkidVbzoQaKiK0wU3zy9y4alXVeelub0MLm4GVHWVHuDAOJHB2VPtfLUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
X-OriginatorOrg: intel.com



On 4/10/2025 4:46 PM, Jakub Kicinski wrote:
> On Wed, 9 Apr 2025 22:23:28 -0700 Jacob Keller wrote:
>>> +struct netdev_stat_ops
>>> +----------------------
>>> +
>>> +"qstat" ops are invoked under the instance lock for "ops locked" drivers,
>>> +and under rtnl_lock for all other drivers.
>>> +
>>>  struct net_shaper_ops
>>>  ---------------------
>>>    
>>
>> What determines if a driver is "ops locked"? Is that defined above this
>> chunk in the doc? I see its when netdev_need_ops_lock() is set? Ok.
> 
> Yup, it was hiding in the previous patch:
> 
>    Code comments and docs refer to drivers which have ops called under
>    the instance lock as "ops locked".
> 
>> Sounds like it would be good to start migrating drivers over to this
>> locking paradigm over time.
> 
> At least for the drivers which implement queue stats its nice to be able 
> to dump stats without taking the global lock. 
> 

Yep. Lots of good reasons to do this work, even if it takes a long time
because of how interconnected the problems are. A measured approach
where we do things slowly is great for reducing the risk of such a big
refactor.

>>>  	if (ifindex) {
>>> -		netdev = __dev_get_by_index(net, ifindex);
>>> -		if (netdev && netdev->stat_ops) {
>>> +		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
>>> +		if (!netdev) {
>>> +			NL_SET_BAD_ATTR(info->extack,
>>> +					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
>>> +			return -ENODEV;
>>> +		}  
>>
>> I guess netdev_get_by_index_lock_ops_compat acquires the lock when it
>> returns success?
> 
> Yes.
> 

Thanks!

>>> +		if (netdev->stat_ops) {
>>>  			err = netdev_nl_qstats_get_dump_one(netdev, scope, skb,
>>>  							    info, ctx);
>>>  		} else {
>>>  			NL_SET_BAD_ATTR(info->extack,
>>>  					info->attrs[NETDEV_A_QSTATS_IFINDEX]);
>>> -			err = netdev ? -EOPNOTSUPP : -ENODEV;
>>> -		}
>>> -	} else {  
>>
>> But there's an else branch here so now I'm confused with how this
>> locking works.
> 

Ugh.. Yea I should have noticed that :D

> The diff is really hard to read, sorry, I should have done two patches.
> The else branch is _removed_. The code is now:
> 
> 	if (ifindex) {
> 		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
> 		...
> 		netdev_unlock_ops_compat(netdev);  
> 		return ;
> 	}
> 
> 	for_each_lock_scoped() {
> 	}

I should have fetched this to review locally, that is much better.

