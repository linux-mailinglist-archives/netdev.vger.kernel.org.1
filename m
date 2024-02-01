Return-Path: <netdev+bounces-67790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A549844F1B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50281F2A76F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DA22C1AE;
	Thu,  1 Feb 2024 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdLeA3BW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18C29424
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 02:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754239; cv=fail; b=RFmhFkDDOfqyJBiq5unX/kmTqvaZNiZYslBkFhzKU80U13KF2h8J8JLAIgizC9nG8RcK76LjQyK+S8NZKOn6l3OMhwrO47XCJtwSRdCYXabEphcCeP2eps9HAQ1ESZ7uHlUq3ZZYnyNgk1yB6hy9ype6thaL6387r0338JPxdis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754239; c=relaxed/simple;
	bh=ubSxhXyrV/nxl5KYo4+BhhIJsdl9LjlEg9U2gckGgfY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vi4MkhJk98x0Z0ggX3JtBTrpyv4xhc4x16VWfTP3CzKWKpMtPUMVZM/zzElKPvF8uzFLgZUQtO8kOuhYg0D/SNFhZs3x/cqFV8ogXcsVrA+z67q8+6FBqAXxNgUY4eSdgbKARAGdCTSD4gUrn4ibgfkbQGmk6CwzbCg8ymXQapQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdLeA3BW; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706754237; x=1738290237;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ubSxhXyrV/nxl5KYo4+BhhIJsdl9LjlEg9U2gckGgfY=;
  b=HdLeA3BWVfrhOeKu/+tUqHdKX7IZXAzSYKvBCn1IqX4AIO8r1sFnAOwN
   2eW387lNwM+85HT5hdtJ84zb9gW3Wcd8X4O0R8h1FnqSbA2q7jrhX5n2Z
   /Zx2YIzEtzl2aVz1bLEBtoDP4Wj2htMZ/Qcbj7N8ys+3skmh2E3JMIxck
   dE3p2qCRNnKeOmAPYO/bve2ByVqRWLMBloRELK4XRjUA/YvY7UaW3+M80
   HeM/6DgsrhR7uVTAFrk+xBQMHBM5De2mRa+YhcMw0bDmZzzTTeg563qHJ
   yx/wf10lYt0iEslHaQ2ucVfTRsrLFKTAVOJBq65p8Lm0oWC0XKbcbORiA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407503849"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="407503849"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 18:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788806221"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="788806221"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 18:23:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 18:23:56 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 18:23:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 18:23:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 18:23:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvAILrL2YSSh8iBaXkmI9pjqq6nhG6UhRTj7JzCVOd+u/ojqmlqZAbA2+Mkn/Psmv4vOj0padKMhyuuZnNgXCKALHCdFXnMFNpDtVQMcDoM14UWCVP9ffdLoc3pPvWFrfOQhsyI3BreEgnEqf2mXzxjGbEMgM3fNkThiE2ZJXQK7wDmcFpkzZMPvlEtxwHK0DnIAWAnxup8cD/snW/13UREy2pXlC3Zs+6RocbZfz0adXVDdW96CglDTjnnpgmPEC+6vD8GWct9YEbKLRIUvNReg8kR6wcrbCU3dBmb6bUDpvgAJBuK0dO8RuZQgnFNhaK6MP4TdzUhlewsytpgXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX1wlumzAsCbUE6+X1F5xlCSfzRkJOiBapfyTFp06wQ=;
 b=YhFTkum8JeDSS/XRuz9yoA+go11BqStkR2xiSnS49FTa83+DkzkTP2L0jfMPSCVXk65YsUFodWUOQEBv7A/vWwmrL02pQPRv9NnyKhgW7/GPawMVE6znFzZB8RQNTQ4PpjrJt41O2oXA96M+QoierV3MdjgO2B6yqaLAGbs2YULjc+Z13CO6etlKhAdIJ3Cea2suqLdh+dySKFgckEWS1DwnzKuPHLY0Tubn8kUhmmBxIPo9FfFABhoSMSOOVQuJMMH+B6LiTMq+z8EqyMBplONBfcsCl+QV0nNHp+oHLWNDwNsGKMGkeYuPJe9Q4xypzlH9Ub2NBJTD7zPIcPx/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by PH8PR11MB6997.namprd11.prod.outlook.com (2603:10b6:510:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 02:23:47 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::73bc:fbbc:4eb:ef31]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::73bc:fbbc:4eb:ef31%2]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 02:23:47 +0000
Message-ID: <6bea046d-326e-4f32-b6cb-dd92811b5fcb@intel.com>
Date: Wed, 31 Jan 2024 20:23:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
To: Jakub Kicinski <kuba@kernel.org>, William Tu <witu@nvidia.com>
CC: Jacob Keller <jacob.e.keller@intel.com>, <bodong@nvidia.com>,
	<jiri@nvidia.com>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>, "Michal
 Swiatkowski" <michal.swiatkowski@linux.intel.com>
References: <20240125045624.68689-1-witu@nvidia.com>
 <20240125223617.7298-1-witu@nvidia.com> <20240130170702.0d80e432@kernel.org>
 <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
 <20240131110649.100bfe98@kernel.org>
 <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
 <20240131124545.2616bdb6@kernel.org>
 <2444399e-f25f-4157-b5d0-447450a95ef9@nvidia.com>
 <777fdb4a-f8f3-4ddb-896a-21b5048c07da@intel.com>
 <20240131143009.756cc25c@kernel.org>
 <dc9f44a8-857b-498a-8b8c-3445e4749366@nvidia.com>
 <20240131151726.1ddb9bc9@kernel.org>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20240131151726.1ddb9bc9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:40::23) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|PH8PR11MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: d18f69a4-9efa-455d-ebb2-08dc22ccd22b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elKlVEE+mAfaX+KXhmfXzJ3XF/lAlpBvCtMQP881ayPwjpWnEZ5UKI1E3nMqD+wZUYbknEPWUVgWonivENOsu76pMPXEsxbt8edg47g4RDXY5tzAc/Xf4i6vski8fPD3tQpdV7WObL34AleD0tFenWYWDttwCHksiR3P2dOog8rqOBFc5Ceyz2MQrT2ZnZaEMZehEbZjT/GmETUKCqUcV4HvEBNwtmMEI5l/NAtmYVdPTdbsJ6MXjhZk0uDY2LJc0eY1+n0z6k+s2+0/P+8jHm8QEyh0/RGgkAErgKxeYh0UlpDDyHrHvJ+hCwql5Yf9MBapN/+4GLR2YyMi6wsF7kGMUQ4ZbXCjIwa36VeSKCX5k9Gmi4USm+eIIf4E/Z/+A1ks3MeuwKEFEjDeqLnMJpyQLoZH5soLjpIZn/EYOyElm+W9FKrlcwCyGnQCA0J9fXeRZMzCTtYN5XrqAEg2unf2DDIRjfrVW1IxWkaDqyRpjRpH73KIomoePkBeAcl5/KDtyn+PwCfBrz520Q4FxdGz+9U2z9BMHNpRR3gE/GyLXkk4s9dM0e1VAh6C4vPV28E+VQ5AJMAcO4/nKLUZYr3cOJ1L0U1fk7JH7bz7J6t3sYlrczyAwE+kXgJc/zT5Qx/Gf38wnVUSy+q7OrQH4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(2906002)(5660300002)(26005)(38100700002)(66946007)(54906003)(66556008)(66476007)(110136005)(31686004)(6486002)(4326008)(53546011)(6506007)(6666004)(8676002)(8936002)(6512007)(316002)(478600001)(31696002)(41300700001)(36756003)(86362001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjMxYlBsV2QxTjRPdEZleG1VSU9VYTluZVJOS1IwQ1F5aUFxMU8xajFDcmhn?=
 =?utf-8?B?RXdUbmJVTmk5clFwMFpMMGpLM3lZMHR5bCtQVE11czhXbFR1MEk3bTgxaG1v?=
 =?utf-8?B?eVQyN1BrNWl4UkQ2UVV1ZXM4bWdZQTYwM3F2cXZqU1ZPRzRzdUZXRUQ1TWoy?=
 =?utf-8?B?T3hxY0haOWtFeGUwbWZ2YjlaZ1dScVdjd3hvc0FWQ1V3UkkzVExEbFBZelVS?=
 =?utf-8?B?N0lQTXh4Ry9ndWtPb01tM2JLa2VoazU2UkVxQnNXRUtuY3pnQi9ueGJ4eHhO?=
 =?utf-8?B?Uzltd21MdllxemxhNGczcHFTMmRyUzZYRXI3V0V4b2t0Z3ZLZmhVQ0pLb092?=
 =?utf-8?B?T2orRWhKOCttUFR4Y3hsWUt4UXdleVNVdjk5aklSOGF3TzJMdEFLUzRNa01U?=
 =?utf-8?B?WnpoVGJmRE9GZSs5dGk3aVBuVTQ4WjBrVnllYTFTNWlZTWtzcjFrUFlCSkt6?=
 =?utf-8?B?M3VDbkVUM0ZmWS9qZzlIbk03ZitRMFk0SGEzcEpQVmhjSXNGRzgrb211Ky9w?=
 =?utf-8?B?ZGw1bS9VeTFITGNJakl0cmgvMXFvdi8vWE03QlJ4ZTdwbGQ4SlhUeTd6dUpv?=
 =?utf-8?B?akI4QjRKK1NuMWNIVDJMMm1kSzlPbEhVdjBwMEovTHBXRVZnMXlPaWIyVVRv?=
 =?utf-8?B?ajQ4aEtaSkNJTnorWXBlVkNISDhsY2c4bU9ONTRMZUhFM09SSzIrZjBvZTJC?=
 =?utf-8?B?N3RtbmpUNzBtd0lMay8xWmNpNFVpM2V4TjloTzRYVFM4elBKcjRyT1R0K1lh?=
 =?utf-8?B?cUVVSFVMdEdOb08wVUtZQkt6L3hXR1lPaDhaSFZUalZXWnFPZzhJY2JWbWxi?=
 =?utf-8?B?Ni8yWk5GMWlWQ2lCWmlnSVZUWkloWXpiRE5HN2lBcE4zUThkSHZUOTdMWURt?=
 =?utf-8?B?N2g0UWdwblkxWEVlTmpkMDRPSVdGcVFpcmpONmR5c0lXRGRpMmwwaFRoVXMx?=
 =?utf-8?B?c01McTFNekxPeHh0RU41QjNiTkJnY1hFWDM2ZUlxRzRDUll2azB4M0ZmVDJp?=
 =?utf-8?B?eENJVEsyVzdaclNwblV4VU1YZFRseW9Vc0NnT1QrbWpJTnJZRVhTZWJSRk43?=
 =?utf-8?B?d1hCWnA2VzUrSWRCdUNXelp4YWhseDBvNDBsZXkzUmZNS2VZaE04WGg3YWlL?=
 =?utf-8?B?WERHYzJ5bm9veTBXZ205bVJHNjhQeHFjN01hZE9EckUzT3FQUGlXRDdVeUd2?=
 =?utf-8?B?NkFpK0YvZEJ2emtOc0RqWGp3MHFIbXFSR2hHVUtlVkx4VmFOaFFTdVhFcVhG?=
 =?utf-8?B?Tk5rZWVLUzByRGZob3ZuS1dLT3RJNDJndmdTNTJ3a1N2TEN5MXBhdkp0Mkp5?=
 =?utf-8?B?K2pRaFh2cjY0MThiMUdCb1hiTmNWeVVGYkxxNGpoR1lTalpKcS95b0lUV2Mv?=
 =?utf-8?B?ci9KSmdYMTBHOGVXcTZUK1hRa25MajBaZGs3Mi9GWC80RHNjMllqQVhtbDNz?=
 =?utf-8?B?WDMvZytHY1pPM3R0MkRLMk9vOXdML2NPNjBxUlpadTB3cnVrbzM0cVBwZHFJ?=
 =?utf-8?B?NzdhbHRBeXFWbkpzcU9UeHpkZkF4VUljc2RDWko0ZTRadTc3ZXVXZHlnbC9h?=
 =?utf-8?B?bXM4anNibkNUb2R2bzhZUjZYSUhSM3lSQk5IcUtiWko4OFhlY3ZNdlNqUWY4?=
 =?utf-8?B?ajh5ZHZhck95b2FiZ05sSXV2Q0hRYkFhNndEVjhvRkJITytQZDgrSGhZUGZE?=
 =?utf-8?B?YmNveFhZQjNyWExFb2VvYmtvZTl2SXJXK1BIcVBZekNlbzJselR4ZmV3UVNI?=
 =?utf-8?B?WGZ3alRTV1kvY2wwNUxBN2ZyaUJ2aDJKMGVNQnB1NHk3MEN0ajhaNFN4OFBU?=
 =?utf-8?B?c2trK3NOcEZCZ2diUUtUOHpmUUJpK1podjhEZUgyaU5IcDVMUE9OaVJoNTFh?=
 =?utf-8?B?cmRiMFNzUWFLb2tTdFVRUzE4ajFpenZEeHpPTjUzMUhGcVRjS2pkRFRSMGU2?=
 =?utf-8?B?QW1td2JyMWlNMVNGMTZBSGNuOHVTdzJCOU9Yem5XWGk0Tk1za28zaXpGbXBE?=
 =?utf-8?B?bCtHcVRiV0NuK3YwRUlDSEQ2WEZKR3JVbnlpcGIrekZRVGx6Q1pjaGpsVHNl?=
 =?utf-8?B?UitnWUtlMjBaZ1A2SHhZKzQyYUFsbkVxN1EyOVVjSEoxenBoTkYrVFc4MG11?=
 =?utf-8?B?OHRITWIwSW12ZmJGelJjWmVwU0MyVWh6TXFJVE82TDRhSWFkTXhqZDEzWEQw?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d18f69a4-9efa-455d-ebb2-08dc22ccd22b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 02:23:47.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODu9K0SDgBgN/kzsCdRk2ZsNFcl4U+LACetmUMcGcMSGJayPVQO3BtIYnMu7zpZokcZY7fgcttq7Q+Yu/Tw6hy4asSAzKd34c2Ta8M2ZI+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6997
X-OriginatorOrg: intel.com



On 1/31/2024 5:17 PM, Jakub Kicinski wrote:
> On Wed, 31 Jan 2024 15:02:58 -0800 William Tu wrote:
>>> I just did a grep on METADATA_HW_PORT_MUX and assumed bnxt, ice and nfp
>>> all do buffer sharing. You're saying you mux Tx queues but not Rx
>>> queues? Or I need to actually read the code instead of grepping? :)
>>
>> I guess bnxt, ice, nfp are doing tx buffer sharing?
> 
> I'm not familiar with ice. I'm 90% sure bnxt shares both Rx and Tx.
> I'm 99.9% sure nfp does.

In ice, all the VF representor netdevs share a VSI(TX/RX queues). UL/PF 
netdev has its own VSI and TX/RX queues. But there is patch from Michal 
under review that is going to simplify the design with a single VSI and 
all the VF representor netdevs and UL/PF netdev will be sharing the 
TX/RX queues in switchdev mode.

Does mlx5 has separate TX/RX queues for each of its representor netdevs?

> 
> It'd be great if you could do the due diligence rather than guessing
> given that you're proposing uAPI extension :(
> 
>> This devlink sd is for RX queues not TX queues.
>>
>> And devlink-sd creates a pool of shared descriptors only for RX queue.
>>
>> The TX queues/ TX path remain unchanged.
> 

