Return-Path: <netdev+bounces-103402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A95907E1F
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCDDB24623
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BF013B787;
	Thu, 13 Jun 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJDII+Rm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4882F50
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314046; cv=fail; b=b6zqCvWQTxKfNueZroyCQPkV8FUCBJu/kqND3WkeCBK8JbKqSGTCzXPFUScOgXoXMJAD3TV2Bs2a9WU5Ack1vQoDcooCG4Zk9OGDxTJYJ+/AODxmeEfEoqzDdsvDAfd2SNUwC4Zdvw6/Irs7rgeyfeiviOS3NEJA+VlB/wgpNes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314046; c=relaxed/simple;
	bh=0vkxf2pPJ0a6D6y8yjM8yN/hmMuZvR7W0YnGKUGTx/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DlOz1VKuan0pR4eSd1yblU2EogcXyBmOfcZRmzuAKwuqumbnx1r2zQ3tQZ0WhjsLOJFjcGwTeMcqCrcxRdRonkQ48Apxzy3NQiDZwBzT1kh3vPui5cKHyqCNODtjSm+aXqifu7cJoE5jQbBU0yJJ5S8UZi3ot+1tJFyybdlKyn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJDII+Rm; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718314045; x=1749850045;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0vkxf2pPJ0a6D6y8yjM8yN/hmMuZvR7W0YnGKUGTx/E=;
  b=lJDII+RmzOhTCVcIs1GvOACPpgVztYGfWRmNxU1mVtF7K3Jxuk2a8dmp
   NO1An/8L1naVb96cERLHef9wqkPYc3w3vFSt1M+jvFAnYnQgXYX27XU+8
   oEyOm5+h2Kj2jgkCdV/AVPq1FVKqHDlPTsmELpq3MTHx+UvLnI1Rx0YlR
   gvkEIXxXvKHO1vu0PhULRF3z/ThtQiD/87Kpfc5ThwtvRgNStjW9XlSdm
   LOURrHWs8qayU0QkTXGfpOSe4Wm3nwQqT3WGl8SuFJs7KJto3f31iB6WJ
   y+eZJAmaHVG/LfCC7qKzC2ot1/cj8RDvXnJ5IwqyxfoO6bec+mJHD4Tqo
   w==;
X-CSE-ConnectionGUID: /KrTe6cLSbCmtXxA05fZdg==
X-CSE-MsgGUID: PaLVgxOHQlazkGKLbpCFXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="26292777"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="26292777"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 14:27:25 -0700
X-CSE-ConnectionGUID: cF0b1yOoSDytjlBLmUBwwQ==
X-CSE-MsgGUID: Kd6VTOboQ9y7YfbwGEsBsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40950384"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 14:27:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 14:27:24 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 14:27:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 14:27:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 14:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+UFtNk1aHgGcR6oDAAnqXavvKqj2ZKjm1NEcNZqFNkj8evVPHxsSBd8UwcckN5r4tAeSueXdlEtMzpQ3/fkNTobn9iQl98O68iglHZDFWoDh6T3SdY5YSl8sZxJNZl+bQBSWJwjSiDpPL3tqKiYfrCvCQWNYtRq7DSAGxGjY1LJtvg/8VXO9O2tTZeIQlvnXMKJlNpODf66pQkUpD+eZentLs64XQIiH3pQxy5dnCp/G3D717pg/1lmE2HaUcmEv2RPG9mso+5+OlEYLrLMOCcsLbsOJ9AQ+Av+OZ+Jgp5LmNTdGHzIL8AueE7XKrINaDmKro7/NDL/zzEp0Ee7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9O6wtADbX7JuofHNugNebb2xy6MZemZI6v3mPx8sK0=;
 b=LMUjtSZt6wxCAup09j3jqjYt/lVxwsjeZJp+DxC6UmKUmGO7mq5O35p1tWRJJJVpX+SpXV52d5jwbsGGQan8fDb7WBpmECrSNkeRT9aRZOZcOl3XLZLGEyVQxp3sfdK+s5LUnZATo1puxp7NeJ7VWn3K3KRAWKkt/l+zuKpTs7bRmzUn8VFb/RsHEiWNTbsknQ4obqJTrYh3gSXfCR9LwDe6dMkUiBXWLkRLyxEKixmqwUaQc41UCQVNq8yoBDxgc+HXt+hjx5fTl+9s4EL6xogoUEuVH8LIUjz5nybLYKgnKYTYHHwu1nd/fhuk8O1yvJTMAEzHqMm3xBP0oemJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM4PR11MB7208.namprd11.prod.outlook.com (2603:10b6:8:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 21:27:18 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%3]) with mapi id 15.20.7677.021; Thu, 13 Jun 2024
 21:27:18 +0000
Message-ID: <03515112-e2b5-4bdb-aebb-16797a59b3fa@intel.com>
Date: Thu, 13 Jun 2024 14:27:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net v3] i40e: fix hot issue NVM content is corrupted
 after nvmupdate
Content-Language: en-US
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Kelvin Kang <kelvin.kang@intel.com>, "Arkadiusz
 Kubalewski" <arkadiusz.kubalewski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
References: <20240612110402.3356700-1-aleksandr.loktionov@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240612110402.3356700-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM4PR11MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f108e35-7aee-43b0-5bc4-08dc8bef9a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUdPYkhZNUVPTWpXZjJvTDVtVi8zU2x5enU3aGlWT1J1SW1TR1MySEJBeXlS?=
 =?utf-8?B?MzR2ZHB6eDZjamJxZGUyUStCYzdTSUpTeEdaaFpycjBzZlJIL3pJN2l2OG5a?=
 =?utf-8?B?NlBBQmJxQjQ2MEpFQTMvQ3FhdUxNRk01VWxmUzMzWEZlQTNuUFNSRHl1K21u?=
 =?utf-8?B?VHVtSWI0WFQ4Y2M4VW5PSGtzSDhPSGdTMlRQdnhxUGZtQ2NZd2NpYTdpTDNh?=
 =?utf-8?B?SVQ3aWs5WVRLRGozWXR5R0RPTEtlRUxoNEZQNVFHckxNUEs4aUFvUWdkMnFw?=
 =?utf-8?B?eGtUaElBSTJ3U1FXUDN1N3hmc0RCR21WMVVSdnJEOHRRQmdSQUlnbHBZb3p3?=
 =?utf-8?B?N2c1V2FnTm9QUjNGeXd3TWl6bHZjUk56NEMzaHJSUE5USTBGWElsNVlYWWJ6?=
 =?utf-8?B?L1h6V3lEaUZBSEtjQUpJb2JrU3Rob0pXaTNLMGluM1RMK0JGYXg4N20wRjEx?=
 =?utf-8?B?ZExQY0pvSkRKZmw0WEI3V3M3R0h2bVc3SitBKzBrblhOZTl1UjBabHowdFFC?=
 =?utf-8?B?V2ZLRTNBT3czeGJYNUovanRPemIrSllvV2dtRHhpVDhaY3FmOFdabm94SEZa?=
 =?utf-8?B?cllqaDQ5U0grSUdEeGc4cEZlTWpVelRleUg4bnE5eGtKRWdxZStGODJORnBo?=
 =?utf-8?B?YjRpWm0xby92eThkaEFFRmJKNjNNM0RLSUxoQ2tSUGo5b1dQRVl3VFA1dnE2?=
 =?utf-8?B?ODF2UHNMTGxFYU5PeDJjTzZzS0JPdi8zTzlHb1FKaTVLTWdVRVI0NjczZTlw?=
 =?utf-8?B?blhCbTNHVW5vZHFZOGwyR2F6ei9renhBL2trVmtrR0p6c3ZjTSttVTBacHlB?=
 =?utf-8?B?ZHkyM3J4ME4ya2VqeU5vZFlPWXZMb2hmWElsRGZxeFU4YTBtWnN0TUpWYk9Q?=
 =?utf-8?B?czl1eU13b0ZPcGErQlhZWXQzak8rdW5QcU9PYTNSR0QveERRVng0NGFWbThI?=
 =?utf-8?B?RzVCTGRLTU9zVlZUeU0waDFCV09jZ3hMV1VzOStpZzc4cTlxVE9IcS91WXZP?=
 =?utf-8?B?Z05UdnZFWndtam1MbnJzc1l3OGRmOHVSSVlITDNTaGppeFJULzhPVE84YmpR?=
 =?utf-8?B?UHgwQ3YvOVRCenJQdklXQUxMM2xpRFZDbnFUTkt3ODRFWDBSMFVsR0NpYzhN?=
 =?utf-8?B?d1NRRWt1dFdqbGp1Vm5sa3lkQUV4UDFWYmpSVk56bXZkcndib3ZwWXRaT2Vy?=
 =?utf-8?B?K1kwTXBiWm9wOGlMR2tEWEgvTWRoK3JRSFJudTROQWI4eVZOUHpzbDVjRWE5?=
 =?utf-8?B?alFNaG53MmNQTzdNREhwVkdya09zTVlyUkgwcDVWTU41SS9UVnJiakJLM2tE?=
 =?utf-8?B?cDVnRWR4ZGRhT3hXa3B2dG9ZNzRwVWlEQk5oTklDSUZrUDY4ZVE4cnFyNnM4?=
 =?utf-8?B?SkNIb25EakF0Y2Z5bEhDMm1kei9yRSsvQWRSWDNtUWFwZm9aYjBQSUQ4aTN4?=
 =?utf-8?B?MFlpTVdad20yOVEvQTV4QTFNVmNKRytZVlBpZWUzT09jdzJtUGlSL2ZFZFJr?=
 =?utf-8?B?N2pNSDdiQkpHRXlaMWFrdWlnZ2NxNW8yN2RXamdiV0FrQ3FxMGVpQ0dwVUI5?=
 =?utf-8?B?Vk05TFpNK2ppVE5uVm5xY3IzZGNvSldMZEYzc1NPVTl2RXRobW5TVHZBU05k?=
 =?utf-8?B?cTBEN1hTdHQyQXg5ZkRDS2cyNzUvNTN6aWVvKy9kcXZZRWI3Q0NDVkI0NDRY?=
 =?utf-8?B?RE4wSkV3YkZobTg3Q0g5NTFyd3hRK21nbUVGKy9UV3RxVFpZRXBYUk5JRnVB?=
 =?utf-8?Q?/uXARhhI0Aiot2XM0FBS2YQKBFo94zS05mEn1EY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpwc2lFQjBNL2grSFg2b1RxSm5oZXhNbUlHSkpKazVtTjE5bklGWnFMVXRF?=
 =?utf-8?B?dHZrTmhrYzdqRzdCSFJteVA5S1dJQW5RazJLNVUyQkhzQlVUY3V4NHVtVHF2?=
 =?utf-8?B?aXJlTko2SStEUFAxaVhtdE5QSTlveDBzd1FFWTdYa0hpVEFPUnhHT2hPei9J?=
 =?utf-8?B?YVdtUEQ1aGt3Z0lZd1BwN0ZIaVdtczBxTlZCMEFDSm1qcXdEVWxIaGdjQ0Vv?=
 =?utf-8?B?YklLL1BjZldDMHcrWllUeFQ5cEJjeGZaR2xlc2NhRVNyang5UWxQNHkvMHZ6?=
 =?utf-8?B?anE0Z0tGd1ozN3FucjB3alBCM1plS2NxdGc1clloRVpMdVBiYVJGL2JLZndk?=
 =?utf-8?B?bGlpNWw2bVhDSGgxZFhwTWQ3YVpFUk0rYnlnRVBuQlgxNlM5VlhudHhRQ2kv?=
 =?utf-8?B?THN2cDc5aW5adjV1ZW55TzFPRm82b1pGRHNnaVdBQVRDbTQrbmlSZERFZzVx?=
 =?utf-8?B?VHRuN2dtT3hxelM4ekVTbFpqa1hBdDhtbkU3NEZua2V5bUgvd1RIMlVMNjRp?=
 =?utf-8?B?dVZ3bGx3d2Z3UnR1ZU1aM1VrUnFwaGYxVjZxM3pLNEFPUk52TDlreDNHODJ4?=
 =?utf-8?B?ZVhvTEwybTF1UTkrVjVqSFMvOUFOeFRXVGM4dE9penM1RDJ4MytXVjNhdTBo?=
 =?utf-8?B?aUIzNk5lNmRYYklRWThDQmhwc3lNQ0VIbnFKYklYWlpUdWRzbXNYTGJObDJY?=
 =?utf-8?B?dm0yQjFmdmM4Z1VFTFZmZnkwdi9RTlZHZ0dKZFZQUUNTQjRwOUNYZmNKemx0?=
 =?utf-8?B?UzlVWk1qSkI3QzVTakVjTUk3Z1lQelVSbFBWNkErbkVPVTZtME5tQ1UzYU5n?=
 =?utf-8?B?VkRaT1ZNb2s1UWVTZHhxRkFtWmgyMXhGZTZjajBiN2dXWGlHTXppWkhjQVpT?=
 =?utf-8?B?TENPVGQ4WUJZTVkyVU01L2JVcjNjeUxlbkh2eW5SNlVBU1RVVitmQlc4Q1hU?=
 =?utf-8?B?YlkrbnJyZUs0M08wSmpFcjlFM1FqUEx0NHc4enJlNWcyWWZkaUtqMHhFWUxF?=
 =?utf-8?B?Njg2K0sxWE9EZzJRUWh5VXp5WXg3TytQVkNsejErMWdPcUpYVzNKTmZrNWpO?=
 =?utf-8?B?OGFESWN6NytzQnl4UDV2U3J3UzZ6aU9LTGhuaVBIa0dpQkxwM0Jvd3V3d0pZ?=
 =?utf-8?B?NUVONFkra3dkemNscFA4ZjY2bFJHelRIUXRNVTdCN3k5dSsxOEFPeTB6Uk1B?=
 =?utf-8?B?THVnRTZVdWpPV2tLb2Mxc1p0Sk1KanJKSjRGS0FraWRYYWtRdGVMQ3ZRUlVh?=
 =?utf-8?B?Zk9pTHdYcmZ2bGpnSmV5Mkt4Y2NlV29xdms2cWFyRXpMWWc2MUpZbjJSN3Zi?=
 =?utf-8?B?a0JGMFc2VWJmdzFxV2JUOUxyQ1BTakVrYTZKb0Y0Q1g3TStrcE1ndnRiYzlU?=
 =?utf-8?B?c016KzBSbVJra1lTQlJUZjFjdSs5OTV3WHpocmN4ZFpnYXIwQUozTkZWK2FV?=
 =?utf-8?B?dmtzTEdkSEw1ajdBYllGSWF0TFFMT25WSWJxV294QmxaNi9rcGw0V1NpTVNJ?=
 =?utf-8?B?ak13TjdZT2t6ZFV3a3ZDVnc2bHVrc1hsR0Y4TWlNandXNDhLV0VSMWM4K21s?=
 =?utf-8?B?ak8wNDB1VStFRjJOdGppYjJGZGN4TERScm1rUVBzczVwUjFHSGI4Y1ZsQzJ1?=
 =?utf-8?B?bGJ0VXNueWdxcE5oTUJCQ3JVNlY5WHNwU1hLdUNUcExxaTYzR0JOMDRMd1Ey?=
 =?utf-8?B?NHdKMzVDa3hwL0xYc0VuUjJSb05iaFZFNS9SV3VNR1IwaEUwRlg0Wmd5TDBv?=
 =?utf-8?B?RjFyMDgzcG1KVms3cGNORmVDNlo3NXV5T1RoaUZlNXVOWnc4ZmJkUjVKaGl4?=
 =?utf-8?B?dC8zODlROXNZS2lzbVJ6eXJSd3JTU09DM0Z0UEtjOVpBRDFPVW1EUWF4YXdZ?=
 =?utf-8?B?bFZHQ2pScVZLdHJiY3lFNDdLL1FnMk14K2taRFdPd3Z3Yk9uY0JBU0pURjlJ?=
 =?utf-8?B?UlFuaEx3bEZTTWVFVnUwcTZ6Y1NBbWZyK0FMQVJIRkpWdE5seUhoWXlDOEdE?=
 =?utf-8?B?MExOU2dLQ05IQUp0cHp1QjYxMDk5ek9ReDhTYlZ3Umo5dU1BUzRGVWJURUUz?=
 =?utf-8?B?R2NBTDJOaVl0d0tyR0R6eHBRYlk1VnJHUmVzZTV0Qk0ycGxRS1dxc2FJcEJs?=
 =?utf-8?B?UmpBU05zNEcvR3V4bkd4RWNwTGJadGRoQXBVNmJ3cmtKY0VkRG1vSnEwQms2?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f108e35-7aee-43b0-5bc4-08dc8bef9a06
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:27:17.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/lSt5ay30nDLwetkQ486gRNyjOCB6T/He5DN3V7YYS1k2WuL2Jxz152ryVJwa26fqydzV9ZXOLr/6d8tbTbiDdrdsSSCBwDQVqRP2hEiHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7208
X-OriginatorOrg: intel.com

On 6/12/2024 4:04 AM, Aleksandr Loktionov wrote:

As Przemek has pointed out...

"hot issue" doesn't necessarily carry the same meaning; better to just 
drop that out of the title.

> The bug affects users only at the time when they try to update NVM, and
> only F/W versions that generate errors while nvmupdate. For example X710DA2
> with 0x8000ECB7 F/W is affected, but there are probably more...
> 
> After 230f3d53a547 patch, which should only replace F/W specific error codes

Could you cite the commit in the preferred style of SHA +title?

I'd suggest

'After commit 230f3d53a547 ("i40e: remove i40e_status"),'

Thanks,
Tony

> with Linux kernel generic, all EIO errors started to be converted into EAGAIN
> which leads nvmupdate to retry until it timeouts and sometimes fails after
> more than 20 minutes in the middle of NVM update, so NVM becomes corrupted.
> 
> Remove wrong EIO to EGAIN conversion and pass all errors as is.
> 
> Fixes: 230f3d53a547 ("i40e: remove i40e_status")
> Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

