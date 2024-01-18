Return-Path: <netdev+bounces-64295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7FB8321AA
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 23:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E13B23995
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 22:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B74A946F;
	Thu, 18 Jan 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RALGhOC7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1359447
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705617710; cv=fail; b=taoyziivUwPxCy67CYvnmKpDxPqHvQzKX9JMvhgPw35988BMQWZiVUaa1/V2fxHFYdZf9kzUu5+E21sXXh2AyR+upLXtFzECnR4+5eRUb2h41gPKKDxCSQ1b5v3x+DwMWecFGFW6yXX3ZjtaI/V6J+A8LfAs57XpugxVYLkhsY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705617710; c=relaxed/simple;
	bh=BW0cQo+joarf3EoUi/ZPOZ4NF4kLlzjlovQl7A4BMBo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Du/HhEPbxbKpdccEtFSVSYusVmALBAGB9rh8huS1KuBmSigyCPcIlS2/2vnasuvTsAisBEjCpCRvGyjFirPGG5dPshCI0tVS+6rim5YlBaVpqxMKHAWOniWkIFGOa6Nd9XH4IuX4mjaIc8bPz1fAqqdxUIBCW4frYUOSTWhmTac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RALGhOC7; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705617708; x=1737153708;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BW0cQo+joarf3EoUi/ZPOZ4NF4kLlzjlovQl7A4BMBo=;
  b=RALGhOC75CxaffaJXFmLrYk2JNvr71wjbZ7iYl/9KHbGSgbBRzkUu9hD
   /MMEyExke1kUwHUwCy3bqZ2qogpdp7A1KVXAGnHqDjjTgLs3N5KqTbdET
   nRRe9ujSc/9k4ECOA0c08ukVLVE7iNspiZK9nkjHd7tWfQcCKc2YHHX19
   y6HvN/7ap3XFYzcwJ/5pAnFYID3PnF3prd8vS9mlxo6ww+EXpPqV4kyTl
   lg338hZRY6aSybS83+2smw6SjRk2SHylbn/dogd0WE4R7TJf+eFDKtgNx
   /soISAP+rx12ciEMA36eBv7k24nNJYwxi2BJ6jVqly7YtSIn4o7fFs/g3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404356350"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="404356350"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 14:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="26886112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 14:41:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 14:41:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 14:41:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 14:41:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAfDP3z/fcNkDRISIPz8TmrrdALGBFjF8e1C6TQWTULN03kjF6EJeJlj9815o3bMlr2g98A5l3tp/4A5upZrjMMnkABcWt6v5hnKxbCYFZhr+e9FSlJQMhzkxI443Z0hLPltVaatLhd02Kn2tCtwZypHdhVe3PYZLzAS25+qX5r3EpzihSRz2PxoCK2j27Wc1ncXtT9EDlhNC67Xei1aXmNvk/YL1KX4+UX+lJuvcCEsMYbjzvk+mpDJ1RjTbxhDhRr7/+cmgn+NqCazbo+vbDy58HI+CAFHhT35A2CzRhlZVOgkbJzhw0npZXHq1hRtJjRj26ZUeA76aYUF0aKQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD6eumU67XikUhZUQAIWLEr/BsJsVUopcupCbcXzvBE=;
 b=ZHDdJVchjKGnwee1EywBGp3Js9TceLas66H/IGjzIF+WG7dkM2zyoj/MxohPOQnXnGf0Bsqx74uNj5DFYZvKKouZO9md9isvN9HP2GGTWOj4twe6SHLxRc2sg1rzwdBDHhlJnZ2CcdIMzXGMmXlCkZ4O1vJDrF+GBNEwQ+CtEp5BTAo6cOQbik/qOHmtDedapb3a+BwwjtJtIM0EREp9I37uDs7S7gzmCparJxXaeJIGCz3Q6K+QUnmRGbz3hXT9O4tKwD8azb1ciP/QGPLrv28lMpm5DZpDrz2HuZWBvBvRA8mZ79VTGqbbEX7mt0qcU8rIUVcOZPH7Sf43ffuu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.18; Thu, 18 Jan 2024 22:41:42 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::7706:285b:27d0:2c5d]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::7706:285b:27d0:2c5d%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 22:41:42 +0000
Message-ID: <4dd14272-eacd-43e5-acff-eb97d0442e44@intel.com>
Date: Thu, 18 Jan 2024 14:41:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: distinguish vports by the dev_port attribute
Content-Language: en-US
To: Michal Schmidt <mschmidt@redhat.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Alan
 Brady" <alan.brady@intel.com>, Pavan Kumar Linga
	<pavan.kumar.linga@intel.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Shailendra Bhatnagar
	<shailendra.bhatnagar@intel.com>
References: <20240118205040.346632-1-mschmidt@redhat.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20240118205040.346632-1-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae38475-2f3e-4652-4447-08dc1876a42d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuhPOBSBPY1uIjlgncy33Weioe/UOxDuoWEwtmSx3D/Uiz5K5b4RNl7ip59Rifo/zWkZn3v2AN1VK9kuq4e003BoHTfO5KFoiZyI41tF1TUu+Z01/UztR+8DJ8XSmMlZGRgrKvqoUaJDC0FxTwXIpwxv5lWiHCmxPIajE/NzZpkb7O585TZWTY5dsxsoSLTCZLtVmCgdfli/CdwSgu6PfzDQwC4t9DYEOvlY08V3K6p512L9vYOFDjeM6x7xGr2FUjHL88TwX7YBFPk9oYCW7cITyidv7yb14IL4P/k5AcN2bpfh8fNIZzuklkV37vpSSIKHBJnvDx08T+ykmXgItJFU/i9WE7+wKdRsGfWYnOuyyddOXD4JmFE/GGP3CKFnBs914XAo2U2O9DEaCfKWVyQc3LzilOeoTHLm+QBBpBrZmJFD6jpeGYCXO5MIF1IsqLUJcPTtDafB8XAMC/eBsHMmTerzUKep1PEQBvrghknIM4xddLHIVOKaXOBtlgwsk7DkucNNkYmLOR+VKtNJuoD9OKb3ibiU1Q7XUyW1G9D+l7+UvVD1w7ZcdYQfMz5xA8g3dx/S0mMqUuofB1QvsfXIDJFhY5mFQ0GJrDXaqkAXe6+YS1vTBRvUM1nq/oeHVZwg1hZMr72Gqf3d889PPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(53546011)(6512007)(4326008)(8936002)(8676002)(82960400001)(44832011)(26005)(36756003)(41300700001)(2906002)(38100700002)(31696002)(86362001)(107886003)(66946007)(6486002)(2616005)(66556008)(478600001)(31686004)(6506007)(316002)(66476007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEgxNWNsbENGMzBuYmxVSGphemFYUjB2VXNteTJmazVjc3pKcGNYZ05ZNjZ4?=
 =?utf-8?B?WTNsSXdkQis1RDdHelhBY2IyTXY3WDFjekx1eHlpK2pGTmdwWlFaRitlUGls?=
 =?utf-8?B?U1EvVmJBay9OcXFBUkpQbU9OYnhaK2xMN3lUYk55Q05jcThmUmNDU0JTbHVD?=
 =?utf-8?B?Tlc2cFZwT2twUldYWit2S2IydFZnY29DVmZHcnFqTVZvTExVemYyZkxqQm5S?=
 =?utf-8?B?VFgyM0NlVDg2cXJjL1NhMEtLMGo1VFBvTFNQaWk2ZHRBM2p6M0pqR2FjTy9C?=
 =?utf-8?B?UGEwTEtwK3NHQXdRK2FTRldpNzAwVUEzSzdLSlFyR0lTQmxib0JBTGdzUWpx?=
 =?utf-8?B?TGtBODNjL0FNc0J4S1hOSXJyWjVyTVJZUHdWaTFNVzZFVHBvbTNNeHhSMnV3?=
 =?utf-8?B?M1Y3TzQzcFFlK2x5WkdPSGF3K0pHTzFkY2E3bWg3RlBzejJNaWN2K1phZHUv?=
 =?utf-8?B?NCtUZlhYUUZrOXFtZWVNTjFXRmN6Q1pXUXlKaWRvTWl2emxXQVZVc2VyY01H?=
 =?utf-8?B?Z2VOcFN6Q1RENGFXVTVqYUtjRW40WlFwUVNPV3RBTFhFbkxkQlJ6RlFoR1BY?=
 =?utf-8?B?UXlzNlpmbThHeUZuSnFXTXhvK1EwN2txcm9YVU1vN0ZoclVuMXgweS9Zd0lH?=
 =?utf-8?B?clRwNjNNUnY0YWhDT3ZEa05sb2MwaUhPZGxIdTNGQ01jd3h4U3dCS00zT2tx?=
 =?utf-8?B?MGZWVlU3N2lVaEdQcWxpSnovekpQTE9ramNyeXpOY1lIZXNjMGFPOXVFQmNr?=
 =?utf-8?B?bnNBMXhLRWczUnNVVGFycUp0QTRueUtiQ2tEekx0bitaUWM1aXVKNHJBMjI2?=
 =?utf-8?B?a0ZXNStLVUNTb0tJdDEzYWZsV0VBMkhwT3M3OUdhaXl2aVh1b2lXWGRxWW8x?=
 =?utf-8?B?cmFaSldjUmVTOGh6TjBKQUxhVG1zVkVJVlpwOTdLWDJSWS9JMXNYU3JENzNS?=
 =?utf-8?B?QVBFSU5TT3BhOWlMN3pGaytjbndkMU11dmxlMjJCSDZoU3cydnRDM3pzODU2?=
 =?utf-8?B?ZDZ4TUY1ZWV5L0Zhb1pwQ3hVQ1BvZ0JsT1laNHd5M1FPYWZtNGtzQXFKUUIx?=
 =?utf-8?B?OXdiS2VXSmtXY0hOeFJIQ1REbVNuM3VYRnJOb05POU5nSk9DaXVvMEpTRHR4?=
 =?utf-8?B?aEFHWkQ3UFR0dzVjZDBKZHBoaFVQK2o1S0N0NEtEYjl2OU5HMlJXdDllU2hU?=
 =?utf-8?B?TUhqZ3dRMTU3aTN5QVhZQXJyVjd0SzBTYzJMMFlqMGJYVmFlYTR2Q3NCMXc2?=
 =?utf-8?B?ejhmT1hpaDdpMHZTNnU2Q25yVUpSVFVLYzlhYlNTakNVRlFtZUpwTWFDZjBr?=
 =?utf-8?B?ODA3b25PaFNobDJEYVhTdXNDNzBWQnNDNHJNdHJjN1ZIR3JtUVBic1VZRktk?=
 =?utf-8?B?RVFlT3pqWnZ6dDMrbHRNanNRZkZEQTJDTHpSWENMMjRHVGFKVmRzd2lPMGxL?=
 =?utf-8?B?UzMwNTRudGlQNWxvdGU5K05RVnA2OER4NnIvVjBsc29zaWM2bFg3SHJTWnRW?=
 =?utf-8?B?c1hyTmVqYW1sZ0grbjR3NHFxdkVNNlZRU0pJRWJFbzNHb3I3NUFnNk1WaFlR?=
 =?utf-8?B?VVNiREU1QUt4T1VWTldRbUhwUzMyOFZBKzRmRDVHL3FUV2dQdzR0VmZXc0c5?=
 =?utf-8?B?N21FbVRtdEU1cUIxYmpveUh2RDgwZ1c4SU8xWHEyTGxPZ3U1TXZ6cmRldXhJ?=
 =?utf-8?B?SWQxU3dLd2RsYmIwZzlSWlZobjFYT3NKdkczbjFNdFhjM2RXK3pENUhuRjR0?=
 =?utf-8?B?YlBsVWVyVk51b003K1J4N0lUZXRwRnA3Wi9uY3JHWGtjUHJVdGR1YUZzMzRO?=
 =?utf-8?B?K1NuckdOVkZmd3ZYeUhzcjJpaGIrWjNyM2JFd0lpZENaUVJQTGpjVW91UGdM?=
 =?utf-8?B?UnVVU1VYaEhYV3pMNVRzWlNTdFNmQUszSVVTNzFVTnhIeEFYckF2UUNiTzg1?=
 =?utf-8?B?SUZwdjJOSVlFTWt1NmZRQnViSUpPTW8wMjlLdGV6WmJRYWxtUXlqbmRHcGdi?=
 =?utf-8?B?QzN2eXhvcDZ0OE1TZlYrNEdWZU1vVFozWkVoQmZlOXpaQ0pYWlYxTUtnRGNL?=
 =?utf-8?B?djFqT3dBZVZPSjdBKytrUUxLYStCcHJ0dk1XaWNSNHU5UjBhZ3Jsc3pxbC93?=
 =?utf-8?B?MWFDNUNCN2FOSTZ4ZG9tWm9nNE56ZmlJVlRnYjFkeUI5TmpzVUVKZHREUDdI?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae38475-2f3e-4652-4447-08dc1876a42d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 22:41:42.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLsqT/oI8F4WGrao05sDIKPcKBM5od2nsj1Y9wv7xDPyMci/8ugAaue0UakKftpJpmXEMJB3fu0MAVFzN3dhVYL8yR61TqyGbWVfrzmUV1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
X-OriginatorOrg: intel.com

On 1/18/2024 12:50 PM, Michal Schmidt wrote:
> idpf registers multiple netdevs (virtual ports) for one PCI function,
> but it does not provide a way for userspace to distinguish them with
> sysfs attributes. Per Documentation/ABI/testing/sysfs-class-net, it is
> a bug not to set dev_port for independent ports on the same PCI bus,
> device and function.
> 
> Without dev_port set, systemd-udevd's default naming policy attempts
> to assign the same name ("ens2f0") to all four idpf netdevs on my test
> system and obviously fails, leaving three of them with the initial
> eth<N> name.
> 
> With this patch, systemd-udevd is able to assign unique names to the
> netdevs (e.g. "ens2f0", "ens2f0d1", "ens2f0d2", "ens2f0d3").
> 
> The Intel-provided out-of-tree idpf driver already sets dev_port. In
> this patch I chose to do it in the same place in the idpf_cfg_netdev
> function.
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

LGTM! Thanks Michal! I checked our latest internal development branch
and it matches what you've added here.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>



