Return-Path: <netdev+bounces-215545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CEAB2F269
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F57AA3A85
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD332820CB;
	Thu, 21 Aug 2025 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bslg+Qq+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA83594F
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765129; cv=fail; b=SzXxn6xVV39rsvsdriDv6Q3ag4ZPFzGTZ87/O++oU2wV9s/SQD+D7BSqIWtNEqJPxejDlQhZ58Mu5mP0FHmV5H5tWGPBiACyVbqIMgby9X9/CniiiSH8+OtFAqBQsPa9qHufHgT5vpuQYwlZCi4bu8mDFjjXVUyeLzrfL0TItQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765129; c=relaxed/simple;
	bh=xtuFQDzxObg4Gv/rfj92mZNcPAkxdjF8ZQtKqfvv5Uo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NPjOVsihx3M6D7NBKK49mvsop2qNBuoDpU4T00KbtEvvCWmBwe22m6nVYOHP/2NN1nu1OJ6+mjkZ2YUOowbemadcDpVnuVJPpPSavp6KxQVzppdwyTJTKavbSlHHPqS/u02LRa6KTmvvAzU/egnM9B/88+XHtxLMFXK6V6Ls5nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bslg+Qq+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755765128; x=1787301128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xtuFQDzxObg4Gv/rfj92mZNcPAkxdjF8ZQtKqfvv5Uo=;
  b=bslg+Qq+dZRtcpvY+BcPqglY99pbwQnBH/0GFr7cOZLp0GAYUp5D6Aq8
   Cz6VD09vXPZ7KBQk5nH0GjYMjeWw4x+8itB8bV9YzuVCMPYAArmkgnycX
   EACy3eS0Te5FCzvyjn8fQIe5Cgxty7U1pKKXy/91sZSBfNxvFHF6k3hp4
   9EajksovP2eWLloZNy31k1bz3uuk4wvoE22G0NnyygdGlfMPeIDBCqAA7
   RWF+96qU1HPVYaCkHjw5fFq4NtDorKTAmDNFM1BMz4cf5vn8VGXv6Xj+W
   YoJp5NTEph+qWtaeTdpjRMu/hgINKtureYwyuKsx5YO2vsqw84KMMpNrz
   Q==;
X-CSE-ConnectionGUID: DTG9g2e2TOqX7oCOvW1ATA==
X-CSE-MsgGUID: MuCjCqi4SU+54bmiPqIcRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75496226"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="75496226"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:32:07 -0700
X-CSE-ConnectionGUID: ALteM5/zQqWdJEOg1lpWjQ==
X-CSE-MsgGUID: jjNvuhA7SF28d7R5SdQwug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173688494"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 01:32:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:32:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 01:32:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD0UgGAaPMto7KXzKQKtKtN2pHUtZDoXKeUtqlyu2yXW69HjmMmp7NQhNbdohjWgX/pMEInPrrDtQh51muQuZimGxwTMhYqktsDFlx/yBZ3daBsA6MyBNgID5uGTKMBzC7M2gX4OcDxGiVVKimeFF+9yhOMGWDkW2s5Cafj0egMkfyxIKzTUNEus7k7ALZrLvm4O9TwAy+upSWazwwk38FMYzSbF4s6eCZjmkmsGWMOUibtsRZZpGjieSYNuN9Tghvi6iGVaKaHmQl88zaTGHMb3scrPH7ZxD9LrnHe7iqSPJM4KepVsBSTmd1QOYTNzx4QmC2Irtn8cOU55+pK6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frA3NGVf8yt4/loPq7QyhK61VTuI7CYFy/JiIL82lpQ=;
 b=FIGNIqSwU+eXkgfwzsINiXIKHtW6nVq1kGLde5xsM4xEl5jTXmEDnOcRKL0lmDP6m+f+foYz+nzQPztQfzUIF3qv2DIImG3VmTVtN72HXR072PReWxcxdAu1HjpSfK/Rp8NyQRfdrhGGx3UNQNqIffPa1ydA+VIkriswXQHAvXcc8j7Fav6LGQXeUREAqQQ14xQzFWu9vCOPq68iMbXsY0IxdwW8zDtn4f3gB0kwM9EroLK8XkfI1kxG/nOY4RIAw7ZTJn4fsWj5BczcQTaoLlfwqDTFadetWMjJ30luC+nBkNCuU9+9ln42l2zdC5Z4bNoryt6GnrZBTXK3Xttt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 08:32:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 08:32:04 +0000
Message-ID: <60e5f92f-009a-4ce7-a489-224e54342542@intel.com>
Date: Thu, 21 Aug 2025 10:31:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5][pull request] Intel Wired LAN Driver Updates
 2025-08-15 (ice, ixgbe, igc)
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
References: <20250819222000.3504873-1-anthony.l.nguyen@intel.com>
 <20250820184550.48d126b8@kernel.org>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20250820184550.48d126b8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0272.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM3PR11MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 837bd76f-abd2-472a-28c8-08dde08d34cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0FRRE5vYS9CU2NKdjd3TkdKZldNWTNTaWFaZktTSExMVVd5NlRRdGpNdzYz?=
 =?utf-8?B?dlpsR3MzdjNyRGM5T1FYOGdZRC8vczRlc2Uza1R5OTNQb25pejNEekxNQjFT?=
 =?utf-8?B?RG9UTVpPdkpuZ3ZsdmR1U2ZhellXWHpiRlZDVExqU244Vm1XN2s1WDVwd2pN?=
 =?utf-8?B?aG04VWZmdHhlZ1g1Y2gwQnRpVlNETElFNHAvSEF2NkVpL1FQbktrVXhESnBY?=
 =?utf-8?B?dmluUlNXZ1ptdkVLYzR5amNNdnZhYWdMVUFGSkpkb1J1cGdOT1lBUWhEc1NT?=
 =?utf-8?B?OWVTZnB1blUyZnZzTzdKOFJaRDlRWVNBYlZkMmJEWlc5aGcvd2o2eng1VUdr?=
 =?utf-8?B?K0pFV0tCU2JaRkFsYVJtdytOQ1lXaXpJYWpnbDQ4aWtqdHI3Sk9nVFVIRTFO?=
 =?utf-8?B?MXEwbmZqdjVzYWo4eGhtWjNNeEc1T3gyeHhPRU9yM1Y0a3dJZXRnUTZvbUZN?=
 =?utf-8?B?VnJWRm8rL0s1eGJwa1FhbGVGNGpBY3BIR0paL2Q0SDhZWXJHcnhtTXBRYjdp?=
 =?utf-8?B?T1k0VjVMMkVVQUVJNzNuWTBUZTVGUVczQ2d0K3pXZmswYUpWRmhkNDVkU2dZ?=
 =?utf-8?B?c1dTWEcrQjZPMUczL3lhOVlUNGRWNUE5L3pTWnNvaVR0NTVmUXJWZU9BNXdh?=
 =?utf-8?B?L2M3WWJMcFFUd0JRckZLakdMZU9ldTNiNVR1UFFPWjFteGgxazdJMzVpSTBB?=
 =?utf-8?B?TXR3RmsyUG54bmVwVXQ3ZkQrR3hUempqWUdCbDRlbEMzczluNXB6RzFZUHFS?=
 =?utf-8?B?RUpNeTh0Yk95NWhZZURxUGFrVGpLYUxLS2tvZ3ExZ2lzRXlQSFNiaWZVTjNW?=
 =?utf-8?B?TmIzWndXU2kzWUFqZ2EzOHllcEFtakNRN2c4TU5sQVk4b3pzV1pmODQxamto?=
 =?utf-8?B?VHpQRUErN0hCMVBJdkFzc0d1SWpKZk15ZVBPTDB4T0RLVCt4eks4WHZZWU1j?=
 =?utf-8?B?cXJwSmZiTTA2NS9FQklsdHE2U3NrYitMYzdDZVd1YU1uSHRGZGw0R2Q5Y1h4?=
 =?utf-8?B?VUVDcGZQTGFlWFBPc0IwQnIzUGEvT1VzNVJzMktwcmNTRlpHSVFua1ZwZHBu?=
 =?utf-8?B?R3hFSEJaRC9ibmxPSGlrNFNERGJyWEtUUzNYVVBYejhNemlXdzBYUXlmS2dn?=
 =?utf-8?B?eXpBLzZJZVRobWIyUVNScEwzZFlzREo0NHZxOEhLQ1FNeVRpMWpIQnFhR1h0?=
 =?utf-8?B?TFgvNGlvWitKbUJWT0hFR0pJRTFPanE1azcreTMzRWduL2ZnRU9pQk85bngy?=
 =?utf-8?B?RDUrSGYzSDkxTi8vZUprTzE1THB0aCtpNVRyK2VlS0RJdGxTa2ZMM2pMeFkw?=
 =?utf-8?B?Zll4bko5UmlTbk5COFFQT2gzbnFEbkVvWVp2T3JtZUdnaGoxQjhIRTNlOGRi?=
 =?utf-8?B?cFZ0dFBqOENDVXIwTzlGNjMvU0w0QW1JYnhtOUhFS0cyWWluSStVYi93ZTBE?=
 =?utf-8?B?K0x0a1hQVDlESW45WWV3bG4vSjBHck9ZcTBadXNWbHdzOEJYMGRGRmJxUUVy?=
 =?utf-8?B?YWIzYkRBM3J5VTZOREpINHJyeHVQMFlsbUNKdHcxMXQxS0d4bDFmRHo1R1BO?=
 =?utf-8?B?OHduQjNlMldZOTZRb2J6blg1bEJ1TGoxWTRnZ0R2OWNmVUN2NitlRkFTWm5E?=
 =?utf-8?B?SFZzT2xVZUxGMXdXU0dEUVZKT09pcFRnUnQxaGJBQnhzeTBNaEUyZlhlZFBx?=
 =?utf-8?B?NGJBd3ZRZHBkMHBwNk54OTJENVR0MUF5UlVqM1FYUFdHekVYVVNmS1poMUJo?=
 =?utf-8?B?YTdmaEFuTFNEUTFTeHVhMG1IZzFuZ1ZPMjEyczNHVVVqLzJzR2hVdnZnSmNy?=
 =?utf-8?B?MStYQ050SU1nMlR3SDlRdWRJVTZUaCtYalFzNExoOUJJUjVGVmdYRXlGVFBO?=
 =?utf-8?B?YVRBaHpiUFhhNzgyYnRVQS80NXJnc1o5QS9KUUZpbTZZN1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHdacG1VejZNSEs4UUpVeDB1VUVKU0J0b2t2NEl5Uk9WU2ZwTldxalRTM2l4?=
 =?utf-8?B?RGFyRklLZ2xLOFlXRXFjd3BXSXJvM01nRzlXckxJS0RnR1piSlF3RjFOTWJO?=
 =?utf-8?B?d0N2TTZ5aW5mTzFKMDdab29samorRUxuNEtxVW9OU1plSHNEQWpJaGkzOUIr?=
 =?utf-8?B?dS84aGY5cmpXY0xNT2FhQktXSWptRHdJSnM4bjFmVDc3U0FVc2FZMGJpWkpk?=
 =?utf-8?B?a2pkREJwNkZWTGhyNEVhbWczQWtnb0dMempvdVY3clRSSFN6SjhKZmJwYnlK?=
 =?utf-8?B?R1d5MVNiSTdPNm0xeGIvOTVCL2MrajI1ZGJCc2V4ZUdUbEE2QjdnNjQxVnpG?=
 =?utf-8?B?c3lldjdzNmhBc0ZJOE0wWko1RTNGY2JMbUhlNi8zWjRreW85NlVOOE5YSzN6?=
 =?utf-8?B?ZFhGVk1Zci9LcHd6RmFKWG9hOXNQYi9PKzB5Qk80cWlNTGROWldmY2xjbFhB?=
 =?utf-8?B?UmVVdU8zajUzd0pFL1RJaFdrVTUxYndqVmg0Q3U2bkJsYzJTank1YXlWcWJq?=
 =?utf-8?B?L1VZcXlMSlJrWjl5TVNoTTFWYlNhZEkzVnp3UWlISi93UTZzTmQwSi9RQTZy?=
 =?utf-8?B?Ym0yaUZsNUEraDNkOGVoU2IvRWg5TG9ESU9WN0VRaXBldUlhc0dMM2w1dHBq?=
 =?utf-8?B?c28yazdDT1hSVG1FNHBMOHRqS1YxVGxrWDF2d21raHh3djI2U1dhSmgrWU5F?=
 =?utf-8?B?OUc0RDBVQTRpbVRQZVY0YllxZkJ0ZkxaVUV6ZEp6RWFYekptSGNlNmJnQzdS?=
 =?utf-8?B?eVRuSE5yVHJiN3JXc2libTVkY2loT3VpMjVMcFdURU1zQXhBdVMxa1NVdWhU?=
 =?utf-8?B?bTZLamsvYlZyTjBua1AvdU85T0dmWDZRSlpkbWZFUDBCaUtkNGNUeU82QjQw?=
 =?utf-8?B?TXpOSmJoSzFCYVRCS2p4QW44RlIrSXNxZkZKaE45SWg4bk9KMStySElSM2la?=
 =?utf-8?B?TmxHTGFqb1ZRS3JQeStPOVlVUklVbGxua3VMUGFFMnFtejVuQ1hhZHFHZm4z?=
 =?utf-8?B?amZ4QjZWTDRjajkzcnRiRUYvdGhYcGtwS2FPUi9uYkdXT0RQQzQvWnNMSkhj?=
 =?utf-8?B?M3ZVbUJsQ0JmWE4zcVZwK0VrZmdIZmxtcHVtWjZmbWFPTTV4RW5rOHZDQ294?=
 =?utf-8?B?ZDhGbElzYlJHOEJ4a0laTlVNdWV2dWtrb1NkLzRJU0Z4cy9jQ1Q3RnRIQWxC?=
 =?utf-8?B?OEY1eEJ5cGNROXFPUVFpeGFIM2NkeHB5ckNDWXZmdGlDVE04cTUrRURDWXdX?=
 =?utf-8?B?SlNNeExrTVBnb1JEQnh0b2EwNkRXWlM1ek1TNGlNSUd6WE5lMVZINGZqaWJ3?=
 =?utf-8?B?NkRMUGtNc3hYdXZ1M0t4b2VUUGdJQno2enVKN0FKMHlnRmhpVjNJWVNTVEx5?=
 =?utf-8?B?cmhadjBnb2tXVDBSc29SQndOUmttZFg2cHZSb0tEWTd3bVpaSUo5ZmlVeDYy?=
 =?utf-8?B?YVc3S0JNVWtQR0RKdzRjUU9xVlVHVWsxSFVpTkFZTUwxa0pZTzRMM0N6SFpz?=
 =?utf-8?B?b1hCakZSbmhyUmpXc3RtUitDLzJ4dEw3S2lTM2Z0aCtUS1R4WHpFbkV5WGlz?=
 =?utf-8?B?TkpOL1hhU3hqajBTR0xnV200ZHROSjZ0T3p4NHgzY2x1dmlFWjBOdW9sc1dI?=
 =?utf-8?B?ZUJ5NjlEcmdBRVFaU0VFSWxVLzQ1ZWRIZ1hJWXdOb3dDMUJxSW5iT1J2RDk3?=
 =?utf-8?B?YVpFTXZ0My9wYTJjQmUzR0g0ZDhnVkRTMW1kRmxLOGp2dHFXREtybW1ycEJz?=
 =?utf-8?B?U1lSSTNKVUw2ck1GS25LbkJ6enNqUGZiZ0JUd0RqdHF6MWxid3pDRUJKdmtV?=
 =?utf-8?B?Ui8yZmdhTVVuTldxbTM1L0ZZL0FhTG5tUnBrNlFhczNWeVJXSjJGRmx4cXFG?=
 =?utf-8?B?V3Z2ejRqYnBOT2ZFMm9Nb3dtQmQ0c0VVWmtLZXBUdTV6WXhBb0gwQ2V6ZDRY?=
 =?utf-8?B?NUZyUFNnd3VBazlJZlVuQ2hOUnFVUkk1RisySWV6TkhrL2RJSXlDSlU3aFFn?=
 =?utf-8?B?WDE1R0dNNzVIRzYvNExwVmh0MnZndGFZOXlJSGd6NC9UQ3ZTZy9qU0hiZ05P?=
 =?utf-8?B?Y3Nsc0hzQm9KbFFVS0NEZXpzQ1Z4TnNFZHVhTDFDajdEN2xQRUpCQzBSZEFF?=
 =?utf-8?B?c2JKbE5ZNjRDWGwzcVJJNEVCaTRaejduTzE4RldQaE4vUDNPazZYYnNTaUt0?=
 =?utf-8?Q?knb1lpKQq44oYoriZZu5yJ0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 837bd76f-abd2-472a-28c8-08dde08d34cd
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:32:03.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgWqPDJKXmDj4MFhyxTlNho5/1yZ9Blkw5494VV3PUi+tms8398FRR3FwyQYEwdxoKn67nbbREdjy5hk4kQexjgvMjiJ9hdCBORk3BhSgJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8735
X-OriginatorOrg: intel.com

On 8/21/25 03:45, Jakub Kicinski wrote:
> On Tue, 19 Aug 2025 15:19:54 -0700 Tony Nguyen wrote:
>> For ice:
>> Emil adds a check to ensure auxiliary device was created before
>> tear down to prevent NULL a pointer dereference and adds an unroll error
>> path on auxiliary device creation to stop a possible memory leak.
> 
> I'll apply the non-ice patches from the list, hope that's okay.
> 

the first ice one fixes real problem, reproducible by various reset
scenarios

