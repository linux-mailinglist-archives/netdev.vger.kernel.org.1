Return-Path: <netdev+bounces-71847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF914855532
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C96D286BA4
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9813F00D;
	Wed, 14 Feb 2024 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpHm5wUp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE4B13DB88
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947885; cv=fail; b=LLkYkGYqDL2wShu+XrFp2/t3URgljLNf1JtEA9T/szGrb77N6paDhdtqm7Rn35FTIkxqCiKt7FlE6236DCuaxd+l9cTCoLmup+ih9Ocu8jpLVkE/Bl/WHj5QA07IR8N7k+QbFWoOrM5dSxQzfzSjlqPYOkYURcWFCuFESbBqY0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947885; c=relaxed/simple;
	bh=cbiS/Po4mfUMot1nQ4SAej1LTRhTOYt117YPMk2VsVo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YCoJ49dZ+goX0IQd+4ZJP/NIHtujF1iLdml5+SEnSXliFEddUYNvK5VrD9lmgyBCcZhYynut9x+UYkrBvkeEnEzv29/CqhWLPrDtfa2Fg4jq2Mjr09Til0Ok+kAjAyvy9KpYKzAezeZCFgI32U3y5JXssnifBlNaBUsUQmED+XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpHm5wUp; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707947883; x=1739483883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cbiS/Po4mfUMot1nQ4SAej1LTRhTOYt117YPMk2VsVo=;
  b=WpHm5wUpI8J3OrSCDGoPN0hbl0TwbE9N58WeHK3Vf6FqpNz1mofHc3Pr
   l3HcEnwMCm9rIBJr3VUrawcFbrHovXqv1W5LPrU1RI+Ngm/p4oKzuc533
   tYgdN8eUDlkoeghMUMwcqxgE98B5aymBOHq0Qdvrl0OQ1JyOmO3SKcFnW
   95GZv+KH7d7EzRtbs5kYbX093Pm34V/1Kw42iCFyNK9TOFO/47LRAlTY5
   SLxB+TpBwNJF1g76NVjqXjMbK4+r9EhHofh+umAKvhUs7BraEY0cp1IiC
   jxH7X1mWMJRBJXTizBDLcaXbOvphPHwCDK3WSoq6R8OjaWptWEFSGziF5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1872161"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1872161"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3615081"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 13:58:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 13:58:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 13:58:01 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 13:58:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jun5K8M+GwewEvFHhxCViFd8DSnSHYAyJZJBI+Tc36WtK4qalZa+Q8ACqXGhE8tUfjBPg1eGFe6L++Q9wGQIXPerXN2MvkAY2HtoUEzLXe55b0tk8CnFVQE3Fa0K/zB4zeqZKLnB7/+9jTRiK6WPjjalaYduwvGS2ssiq3oe2AwMXtICGJ1KwBQv1IZJt/gYrBtS1nArCSiUy07UlF8Sb3ou0jyIQ3QshnvRT67nMx/4n7qvZ69n7IJ7Z8SKodBvhMsp4Tvosd4fB/L2/DoEE4LmZda0WipzTsPud3qqEYczkUenMLBCsl97KfIuvK8FWqNJw/WV9DPnOebJmALUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HY0rluXQ5qm8v16usIrkcWEMAJI3n7zcVZbxgbBG1PE=;
 b=OSsj5SBTLbx2OxpRkOT7KVWTcnKmvkb4semkTNtM15uWTplOToaZGs+aDvkQ2BFUvMtWty3mUAYLKAcSTTK6a2LLHBLmhERwQXilpUcDqt8Fy2ftyhRBqidpUYvmryPInAvacc7Fmt9aMP4sXBV7Oba26zHqnSrs8Kga1mxtjN9WKVDsdjsrwiTBs8RTHI7zxS0Jo3QVoXByU7c7T6Gupx/KJsOOMPNAlt0Gn0uhJi3WGGrQEoSbR67BJDQ4IyBgg54kExMgKqmZjHW6rpE5AqN4IUAwaNSFDnmI0J7x4muNZL1uLJoyHo2YPk0pEk5VGrk5w3tiSL01uBwi3bSy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 21:57:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 21:57:59 +0000
Message-ID: <c9168c1a-e4b7-4474-991c-e6a66d4b9254@intel.com>
Date: Wed, 14 Feb 2024 13:57:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 1/9] ionic: set adminq irq affinity
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-2-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-2-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM6PR11MB4563:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e03ca12-3075-492c-039e-08dc2da8023b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HxE909IFs2KWg7NNEpoMpBk1nIo6dFIilXHKjTqj9tsWHt6vfc37aX3dmDR+nTmEI+R08KZD73OwxGbeCY/8QFkZP1Wv5Em6B98b3l0D7dD9M62gph7iFGG8sUN2TiP1yYYM+q4vGVd2aafLuisM3HJqSxHajiApWkTPW3FMYuXottR1lUvmixdEPP2WksLg4VsE7V7/FoYTGlr3Tva4uzkgOv+cOHh7VngXUCPPvGJ6/qgICe564ZHHmZqtCAIJGFdEa/5gMcQjSV0jYfxCUtm0129400jY3zRGXGijHx0QqyGDIR9Uavc3HJPpbyQ6E9KZfLGkFghnREKDYkXFHHJ9m5wmDgrP4Qs157EXoEbj8xYjQSQy4y6wWmCL9og+17b7z+fJExtGn5T7be/pvFkRI2OvISXxxWunjHQSY4eXChFs7PaYZ9MwvzhLCgiMBHCjL0z9cUlTyXviJFNP21+8dm2n8oILxj20UrRiMpjkpMChVQs3zJnD3EJWn6Dq1oWk66GFtty6oJ5N3pTG0/zPJAtj0cCOSm+8MThH/vaGtFlBFCzc1Z5Uxp7vy2e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(38100700002)(26005)(8676002)(8936002)(4326008)(36756003)(41300700001)(86362001)(82960400001)(31696002)(83380400001)(2906002)(4744005)(5660300002)(2616005)(66556008)(66946007)(316002)(6486002)(66476007)(478600001)(53546011)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVFyMVVUV3Y5Mnh6bU5RMk5rNWZET3pUQ2M4RC96ekZ1dDB2c3ArbThuZTlX?=
 =?utf-8?B?NnJYV3RIRmRkdGp1NHhuQ0VQMTJBdzBsYmpyQmlVMmo0NHAyTEFCN1EwVzBL?=
 =?utf-8?B?NStiU1NaNUNCNGZqekZzUFBDdEpUWGdqaElTT216dTBjTnpVdm9ESWU5bG02?=
 =?utf-8?B?OHVOQmtUMXB2UHJ2QnY1M3lHVmdKVGN4T0lwL3lvWWlXSWZZMlpYT3dFSWFL?=
 =?utf-8?B?M3BPcTlSZFJjU2ljSy9Gc3hGbFB1eWRhVjd1MW1BWWhadVpOQnBUd2c0ZHZk?=
 =?utf-8?B?RkZmRklXVlVDUlg4S1JSa2xPZHR3S1NHZWcvQlR0T0Z0VEhlNDZlOTlCaFNW?=
 =?utf-8?B?M21aTG1qaWxjNURKdHB5NmR5emVETU1YM2xJRUw3ZndjSmFCeENlZUFhRkRW?=
 =?utf-8?B?dE03Q1p5Wk9kNEVVZEV5RWh6VnhQRldEQ0libURrZUtaU3RPTlBzSklPckU4?=
 =?utf-8?B?dnZlTkR3d2swNStJRGQrUEVXdkdMVjExTEhqZjgzT0ZuaXh1K2lnK3RDb0FQ?=
 =?utf-8?B?aWM0Y2ZCdk0wQ1JtbzEvYUYyY0FwbWZFYmc5bldBMi9MaFNCS2Y5NTNxY09L?=
 =?utf-8?B?MXRxbk44NVQvaHFDMEs0WmNIUE9UaGdMQU9lcEUxVk5NRlBzYjJoMmtOR0Ns?=
 =?utf-8?B?NktPYis1WXRtNW9JNEFKZ2duMmkrM2lJY1hmTjdZQldoMlQ4aGE5d3VSeUo5?=
 =?utf-8?B?NlNsdGJNaE5JZEdEZ0d3c2VPeGxZS0haVlY1cXNFUzhRZWxjZ3RSL0o3aTdq?=
 =?utf-8?B?aXBLYk5mSUd0d2R1cE8vcEJTUDdRWEZwc2gxd2RSSFB1UVRWZ3hQUFJGbVQz?=
 =?utf-8?B?NFdFT3BRTisrSlA2S21SWG81bFMvTDlDRStvR0YrZVB3UVhwNzhsRFhyVGd2?=
 =?utf-8?B?UjhNdmtJcEJXYVFVNFZRNStZNGFRZzdBOU9Mc2ZvL0Y5ZzdBQ0xQVHNMMGJl?=
 =?utf-8?B?cDFqalFQZmNEbWRUeE5WbFFjczFtWDdjT1ZObTMxOVZTdDVka2I1ZTRIZ3I4?=
 =?utf-8?B?UCtXOEE1RTFsMzRzSElzVHNsZDR0U0lxdXdENDBvaFB0QUVCZmFpWk1iL3Np?=
 =?utf-8?B?Y2o3Z0d3UXUvQWtzbXBBSHY3NzNhbDdqQmRsMTBMYVd2TzZTMURCTFd4dGZj?=
 =?utf-8?B?T2FBZGljcGxrbC9WbUtLdjQ5cGJrQkN6by9YcWVuYkZLODRHMFBHeVhFUHlB?=
 =?utf-8?B?OERrVk5kZUo1K0VEeXpab0lEMUdLSDVWTWM4YkN2Zk1TMjc0K0JaSm1KZWhB?=
 =?utf-8?B?bFVDVkszQWxRR1l4WlR3RHZFcU8zTjIzd0E4SlVUMnFMaEd6VnViSDVPd2lh?=
 =?utf-8?B?MUowM2d6UlpKUDRValdLUnJFQjd6Unl6NGU2YjNnbHlTV05HZXFNUnFTNzVX?=
 =?utf-8?B?NlZYMXUrRzJGRnVWb0xHMDVSVW9CbzFYMWtyS0p5VDY0NmxPV0syWEl6bGJ4?=
 =?utf-8?B?QTRrZGNVazJhd3Q4REl1QU0zT3ZnZlBaYlE4cTVHZzlOaVZ5T2VmVUJEQmFz?=
 =?utf-8?B?ejJ2NUc5MG5SMjZ0MGZzeW11WWdiWXI4RGhmNUU0anJyTVlXcGU2WS9DeDlH?=
 =?utf-8?B?ZXlEZzhJRXJtT1B3RVZQdCtQUlZMajcyZStlQTBJQ3J6cklCdUJTSGVMYlRP?=
 =?utf-8?B?aUViNUpOZk9BWXN5ZGtsMjRzN1BZdXd2N1N3a0Y3NGkxeFFyMUkyQ2UvbVJ6?=
 =?utf-8?B?VWZhOUpvS0RGeHIzbWZZZTg3Q3BiME9NZDNpMXhZRTBHNWV4TVMvRi84QTly?=
 =?utf-8?B?TlFJV2VrL21rNk5CcXFRVTZXc1puVzFMOG9veFpyd25JdG44V1BPUEwzdHNk?=
 =?utf-8?B?NVZlUkdPL0tDeTRKdWlxa0JYZ3N6SThWNzZyZTR6aXk4a2hyQmdyZ2F3TGQ2?=
 =?utf-8?B?UFV3MU9EbU5JQy9rOFMzUWVGb3pqTlhYNUZ3UWtHeVE2U1p3cFhtNWFYNlZy?=
 =?utf-8?B?L3J4N3pCUDJKUzNRZGJPSy8zUk5PVG1NdERzY1IxS1ppTzdCSGp4TXZFTXJX?=
 =?utf-8?B?MTJJem1EWm4vUWtiNUtuemN0eWMvbTlpak5sYXpzdUpYVW42TGcxQ2lnZUJJ?=
 =?utf-8?B?VWd6bS82OFV3aElRTjk0MzRDdUlNbnM3OHF0Qk5wV1hLeE5tRmlrU0gwWWU1?=
 =?utf-8?B?VWxZZCsyTFVSU2xDVXFYWldNamdVLzArTjVHY20wK1h3MGFNbTBHUm5iUUI0?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e03ca12-3075-492c-039e-08dc2da8023b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:57:59.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BujONUHkCZKMOaFM6UusuqSjpVJuicf7XZc5SAa8KHOQ9ZPZQgMcBzuHmqzdMIQWUge46ZJE5UhlvsaunTXQzD41rEoir9UH0AlaNqHaF7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> We claim to have the AdminQ on our irq0 and thus cpu id 0,
> but we need to be sure we set the affinity hint to try to
> keep it there.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

