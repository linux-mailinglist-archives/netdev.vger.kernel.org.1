Return-Path: <netdev+bounces-101969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65752900D6C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 23:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D254287703
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 21:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47A01552F9;
	Fri,  7 Jun 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2TT4uyt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85314533D
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795212; cv=fail; b=iQekwg3aWmh9yEJG3faKWwKO3dT+1Pes4tL1c6fRuCa2AYTVUAKoi+KM5fGCB3nNtFvD7uqVd18gE0zrGgeSL1IDNG3OcM4SXZznkvZd+qlBmjaKG/1MXXyW5AlH+/yWGOPMoyaTG5HN3+MPVcgj6denFpezqlQz5Ua6fJkgbAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795212; c=relaxed/simple;
	bh=tKfHO0T1P3JJz7GiH71CUXdIlUdMs3GsIiXX7WT8Gps=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VARQRFxvAtIBLD0noaynkQduaPyvQc4Kro/JqztUEQLO9Sd2eC1XsORP8w+mCjiRgoy1oNF0OLbhjTcGq6Ukp6pj/OBK/SEAmixZ+BNG7ZO/0VYDI/Fq4FdsIJhufsVREb7KIWAl+zE2GDGr8yqMkK18afK2V0y283WXtX5S4y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2TT4uyt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717795208; x=1749331208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tKfHO0T1P3JJz7GiH71CUXdIlUdMs3GsIiXX7WT8Gps=;
  b=C2TT4uyt2gap3oxXnQCPF+t1ej2nqfpa5BUBvPXJoozv7+63qG3bnuV4
   vLInVrEAMQqWzZi0hhmb5+IWTIttlJyrjrIiqSGYqbTQ9HWYDbj8bslvW
   gif785jGK0UugcpGEJDshhT8CEg6MJARyEF+hkVikbOIf87a06f+i/NyJ
   vQbXGOqZQKsHU+DJwww4o8O4nbcB92p+CqsVDYMi4u/di/PI2DZ0f4dOr
   Q2A95dNg6VGQ1SdzLMPCnk022Veao+WjDqTICbhS5iyDM6ddqs2K1sDvF
   IBb4idg/v7YLmjovA+i4Gph8XFaC0T2d26YUDq0LKweJYMp8LDPinmZyM
   A==;
X-CSE-ConnectionGUID: zIYE7SH7Tq+CQ7688Jad7w==
X-CSE-MsgGUID: g8WEdOFIQ6iADKi8Ykhhtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14769593"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14769593"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 14:20:07 -0700
X-CSE-ConnectionGUID: 5XmteSsrSiGwu0J2DCwfzA==
X-CSE-MsgGUID: 48kcQIluSyarcyLOLeIf8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69226755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 14:20:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 14:20:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 14:20:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 14:20:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 14:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCEO3mEsN9Dcvw2by6cOHxUG0ZF4IsNYG4oF6ODIzv3Nh3gIP20LsSsLPUc3Q5E7f9BQai2E2yC+6VXx2zlmyd80mg67w8VdYUC+JFHjjt7a490Fq5iJWwehNQmck19pUXQZ1KV/EQjlE2MYUP87/2kyA8HTWKG8UUAhqjDDTysZgvgRBuPLDFbqZsSoL4IStC3YGvXNoeHFWqxU4gwvZRBxSFowj54LiZXbSpOS5uB62yfpQLPK0a0Zr6hB/CiCQ0k4xxPJF1vKHSQiI5R20aveUi6hsbJXcntRdOwAxatkkMTaEZ3vssUbwuKOJhXf8Sn7Rdt076Q2Uqv00YLOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAbfJ5iEPISJyKq8tGWpVlk6pcGs0g99xo9Bllo6b2o=;
 b=HpIz2N4LaEJavaAOnnAP6HVnELFEBrwLwZQURj2ekPzQKjuBFtnQHCq1vd9x6fECgaPpmwu6/YYPgSkXZ0fDJm25+jGigMKYMrKr3MTk2CPuNVlKV/NzcSSQHfcNr6emAtbzoXIJAo/46hT4RK4UglpxnectAGXWpxol/mlym05ilxxDb2NQzpLQQMIM7DPlWkUhaFWl+f0bT+uQ5NShqowC2rlvtiNCfbrMeLwxZSjYmqRcvj5PfZgu3cf6tpNXc029eT+ixDbvBs6+YWzXJAqiP8jEK6W9b4WlqsBR4no45iP3rNXaRQCsTQuHYrVUBc2U2+6vawAnUdwfLOiQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5090.namprd11.prod.outlook.com (2603:10b6:303:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 21:20:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 21:20:03 +0000
Message-ID: <49f3020a-1b2a-44c5-8ea5-938aa2195144@intel.com>
Date: Fri, 7 Jun 2024 14:20:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] ice: move devlink locking outside the port
 creation
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Sujai
 Buvaneswaran <sujai.buvaneswaran@intel.com>, Jiri Pirko <jiri@resnulli.us>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
 <20240605-next-2024-06-03-intel-next-batch-v2-3-39c23963fa78@intel.com>
 <20240606175634.2e42fca8@kernel.org> <ZmKWNbY1V+ZvP/qX@mev-dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZmKWNbY1V+ZvP/qX@mev-dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: 22698185-261d-4747-15a0-08dc873798b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEVPa3Zpa3hRcE9BcXJaMFFwS2hjRW94TkkvZ01peHpXaFNDUnpSNUlSRDZB?=
 =?utf-8?B?TTU5elFuS2RSdk93UmVML0VhNG9MOUk4V3NJYmZydktncGpsYmxmL2RHOVlZ?=
 =?utf-8?B?aUdQSFgxWEw5Nkx4ekVTdWRYYUdpM3dOOG9Ib2VDZVZTMTNuUXZUUkliNlBX?=
 =?utf-8?B?SFVVckpEeW1SSXlXMmxSWlgzb0VjTUJITlQ0eThiU1BNWHQwTEhaOC84NDcy?=
 =?utf-8?B?aVcxOTRJMDQrMDNVdGNWWnVBSUFyMXdFWmpRdyt6dm9ZN1BzdXRzVEhkK3g2?=
 =?utf-8?B?V2dyVnZZZjB1M0ExeHNCbUhFRlBzQkJ3bU1laXZPT1Vpek1NRVRBSTVTRlFX?=
 =?utf-8?B?N3pkRDRyT00ycDFweHFjdEtzVmxmdStZYWx4MVFXVlBEUDgwVHg3aHY3a1kz?=
 =?utf-8?B?WmdzMkxwZVhBTitBUVU3S0ZXMjNaUEcxRUFtYTlOQXNEZjJYZHFEdXpvV2hj?=
 =?utf-8?B?V0NDM3RwYnNKdWV2MjVHeFFYVU9rZ2Z2ajdMZUE4RVRTZ05MTEZKVmR4dXNO?=
 =?utf-8?B?YUtidi9zNmQrbGRGZmZCaExTdHRMcmtiSkd2TWNtUVBDUGRIL3ZPVWVuc2F6?=
 =?utf-8?B?ZHNwemRFVWFFWlZoR3MzZWVucFpKRGpHVDl0ZnhGS3lMcSs4YUI5M3Z4R2NI?=
 =?utf-8?B?OThkU0p6NVMxUDVVeGlwWExqWjQ1Ni9qNGcwc1ZQZ2ltVkNTRE9xQ0JLaXNK?=
 =?utf-8?B?ZDAxVW5tS0N2UXhkS3ZkYXU1bnB6UHFRRlpVVUwrQWpkNDJ4U215czN5cSta?=
 =?utf-8?B?N29XeXFEeElpRGJpWlZjMU1pSnpKSjBpS2h6ZnhmRlB6Sk1lR09hSWh6a2Uy?=
 =?utf-8?B?aWF2d1VkcFVuc0R2UnVUREJ0N3hWemVlREpCYUNLU0hHcERtVkJFOGNjRzhw?=
 =?utf-8?B?b3VoVENTVnNaLzZVTjRHTzJacnpua2k5b2FFVm1tSXNpRHEwYnNOamF2MVcx?=
 =?utf-8?B?NHNJbDZ4KzF4cGZoUUZRRS9hZ1BpMEYwOGJDWmtZS1hrckJWTDZ1a3IxNTRC?=
 =?utf-8?B?L2NmbFpoS0lPZ0xnanQzM0M0R0pEVmg5cWZXUHB6UTNxaWVETkRXYnNSTjJM?=
 =?utf-8?B?WUtwdkxyM1phWVlQYkNsTnA1L0J1YkppdVVJTGZ5SnhYbjRFZ2x5TFo2c3Iz?=
 =?utf-8?B?Nzd0bVgwb1ErSEV0dTVuWEQyNFBpZ2VESW1Oa2lKOEdGOUlxWlllb0czaW9o?=
 =?utf-8?B?RkVBdDYwNExKSXBTekNWSDdnTE1zUFZSS21RTHNwbVRzdGtBR1k1N0NvaDg3?=
 =?utf-8?B?Umx1TVZwRXpwbDhPYkFzZFNjRVlZaTV0a0FaaFBhWEVBOXVLcG90c1hCdERw?=
 =?utf-8?B?amE1VmErSDdoVk8zMUdpZnMvNGZTdHlNYkxHT3ZVUzJPaHRjeExvY0VMQW9N?=
 =?utf-8?B?RnBEdlZ4ODJ1ekxTK2E4ckRZUmtlMmZmT05scTU1N2dDL3lsSVVteWczZzNU?=
 =?utf-8?B?UklEWDhtWmdweVpqVTErdS95ZHRFMklieGZkejRkajVmbDcxVDU2YXoyVVBr?=
 =?utf-8?B?MEVOdlFwdTRHcEk4VlBqVTEwUmY5K1laT0dJR2VZMW5xbS9zUi9BSlluekhB?=
 =?utf-8?B?aDVMdHY5ckRucUNnQlpUdU11YlRtVm02cWdHc21qV3FRRjJPZzV0TVJQNGZy?=
 =?utf-8?B?TnRTdkhaMnFTU2hYRnFuWndBbWlCTGFzV0FQWndTSWk5V1A3N00wQVhWUWVJ?=
 =?utf-8?B?Ny9TLzRkeFJuMVh5NzhJeDM0RGJubG9iZUtkRFRYWnhnMUJQSWRjQmF5YXlQ?=
 =?utf-8?Q?3HmWGlVPRZ/JPCRAjIpBl6CIU521bXrKqfxcGMr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnQxdXpJanhVWUJyWWhreFNSWk40WHlVNWhHQXQvYmZxZC9qMzFZNGpIRlJy?=
 =?utf-8?B?TmdJY040OGJYOEtoeC9paWdRR2txWHl0OTh4b0tuMFlOa05Gc295QlZTcXJM?=
 =?utf-8?B?S0IvTDRwRkhZWHFPSEJIdjU3MzZuLzZJSkJBSWVRUEh5RHZ3dmp5US93cTAx?=
 =?utf-8?B?L3dGUVJ0TGxhZFlWTmxCVGlOVlVSOFY3RWN6Mk1ZRlI5NWhhNUJjZlVPUjJM?=
 =?utf-8?B?eTREamFZVUlwOXpoMHA3eU5nOWQ3Y2dkK0NxS3BUeldOVlVSNE9GS0dBR3RH?=
 =?utf-8?B?Z0cvOWJNN2FzM0JXWWU2Z1A2cnZuQTN6UC9LL25Zdy8yYmszdmNwMTBwVm9i?=
 =?utf-8?B?alRWaTdJSlBWMng0bHIrc1F2YXRNV3B0bzhEcDZHSzVxTTNqRkRsM1VBZ3RH?=
 =?utf-8?B?Y29LOENYcWNsWmgxa1phQ0I3OEhVUXhwV1ZVWTByeWJjQ3dYT251Y3NMTytR?=
 =?utf-8?B?YW9mOWs0RGtMWGs3UGQ2VkJ4M2lKWnFqYXlDRnVvdnZOT0Z3LzgxQ2U1VFgr?=
 =?utf-8?B?YVVPSzd1Z0JNSVh4NWRtdlQvSndyQVhUTm5WYXBNYlhhYkFIcUh2TlBKcVox?=
 =?utf-8?B?N3poeFgxMlFSVjNXcXN2QXFNY3RCemlmNWV1a3VNTm5xeEk5ditDZW9RLzVS?=
 =?utf-8?B?OTBybFJKSU5mTkJRdkNhQ2J1c1Y1Ynk1b21SZys0bzNCVC9DNkY2cTdITVdv?=
 =?utf-8?B?OUlFVGI3OEE5c0kzOWJLcTFWOUxyNTBYeFlnNkR4d0llYVpWcXNqVnltUk9a?=
 =?utf-8?B?cFBSdWlsVCtabjVoN1JQTXd2VzBQTEFUcE5nQlo1TCswWkVDcDNaeUM1SE9O?=
 =?utf-8?B?M3kyaERKT3lSM1dJb1pGMEFyc05PcUVmdzQyam4vaTRtbHk5NUJDQzhHd1hH?=
 =?utf-8?B?SVRKTE1KUFlCbWNPYXRLWlBTVklET3dsRmZhQ1laL1dBVmU5S2xXOHYzbEtt?=
 =?utf-8?B?Zjh2d1RmNjRNdEUxYnB5bDhZNXAwYWJhYlZMU2lpaFdSTFBwK2hUTGsyOXoz?=
 =?utf-8?B?MUZ4d3ByTFJUUExLU1N2WVFBMm4xQW1PbFhldEJPRVE4cVJrbjVURnlwd054?=
 =?utf-8?B?TnVXL3YxdG1aR1hBazFRamhXeWJUQ0h3ZjVBSktBUUgyR0hYeHJNbDZ1SGEx?=
 =?utf-8?B?aVdGWlJCSldneElBSWFUbjcrWFlTdnlLYmk4RC8rTW9Wa2szOHMxaDlXc0c2?=
 =?utf-8?B?eE5rdE03Z2JaZ3pjbUxyMDYvcDdSL0dOemtWWXlFMnA3RTNZLysycEdhM0hS?=
 =?utf-8?B?cWFnN01CdmtFZjhMZ3VVNVF1Y1JDSGlVNGg3aHVYOHZBOXFpV3BXT3BTUDAr?=
 =?utf-8?B?bjJWUUtjcjhtSUdDQ2NVOGVEeldlOVlwZXdxUHpoS3grd2RmRUQyNWlsMTlI?=
 =?utf-8?B?d01KZkVxUElRUUp2bHFqbUxXQVh4VUkyL3NRMEg4NjNhaCt6OFlrNVBVZzk5?=
 =?utf-8?B?UkxKZGhsRkNLZ2dLNFh0WnE3b0plNEU3WVNBc3pWNytPVFQxNy9sc1JlSzNH?=
 =?utf-8?B?S2FiYW5XYWpJNklFeTNRZm00dTZTcm1TVXNERFV5YVE4YUJEdnVuL2JXWDlC?=
 =?utf-8?B?NUZCTGRCMEhGNWJPemdMWmJ3aWxmMEFIWWlHdk5OQzFDZmdKMkFPUFRvSWdk?=
 =?utf-8?B?TXlsblQvMGltd0xuaURRdXFUT1FnSEtWQ1BmLzhDYklybG5HUmM3ZThhWnBh?=
 =?utf-8?B?aUE2WkFJanBWOGtYakZJY0Z0VmFhdjAwQzB5YWxKQ2JKdTJCaVQ2YkJkTENQ?=
 =?utf-8?B?V1Y0K25WTkMwaGlaR2o2VlhFYW1aZlMzdGNCMWRUWnkzZGdaQ1lxUFNXV25r?=
 =?utf-8?B?c2pZRGRRTDN3L3pSVWNJWHBsMnMvMHk5amRWYXpjWWpZZCtuTUV0UXJ5Qms2?=
 =?utf-8?B?dm5RVGdocWdreFY5RDZoZ3phMlN5Q0VnWEtTRUl0elFOUk9ZMFNCb0FKU2E4?=
 =?utf-8?B?TWpiYzkxd3N3Uk9PWEZCZXkzaFNCRDY3UnB5TEZjSU1CWE44ek1DMXg3R3Zi?=
 =?utf-8?B?cmhUMlE4Nkx2M25GTXV5Ni9VNHg1aFN3OTNBcGEzWHBVNFFNWUxWaWhhZ2tK?=
 =?utf-8?B?bWR6T28yaXIzTC9EcFFodE4va1VDNWhkWDV0ZEdrcFIzNkpEOTUzV2xSVklv?=
 =?utf-8?B?ZUwrNmllaFhxNGFFaSthVUZCaEJxczBTRytaWjFhMDZYQjZUMFZUVzJzL0Ns?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22698185-261d-4747-15a0-08dc873798b4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 21:20:03.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBgue6MlO8shZyx7gzdIL0dbPL9AjlZL70XJW4F+r2m57oa7S7wR3jauUBjlqYhtoX784TigVzmXd1tiiTSrayQnCyToUlszHbah8Zuqlvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
X-OriginatorOrg: intel.com



On 6/6/2024 10:10 PM, Michal Swiatkowski wrote:
> On Thu, Jun 06, 2024 at 05:56:34PM -0700, Jakub Kicinski wrote:
>> On Wed, 05 Jun 2024 13:40:43 -0700 Jacob Keller wrote:
>>> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>
>>> In case of subfunction lock will be taken for whole port creation. Do
>>> the same in VF case.
>>
>> No interactions with other locks worth mentioning?
>>
> 
> You right, I could have mentioned also removing path. The patch is only
> about devlink lock during port representor creation / removing.
> 
>>> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>>> index 704e9ad5144e..f774781ab514 100644
>>> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
>>> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
>>> @@ -794,10 +794,8 @@ int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *v
>>>  
>>>  	tc_node = pi->root->children[0];
>>>  	mutex_lock(&pi->sched_lock);
>>> -	devl_lock(devlink);
>>>  	for (i = 0; i < tc_node->num_children; i++)
>>>  		ice_traverse_tx_tree(devlink, tc_node->children[i], tc_node, pf);
>>> -	devl_unlock(devlink);
>>>  	mutex_unlock(&pi->sched_lock);
>>
>> Like this didn't use to cause a deadlock?
>>
>> Seems ice_devlink_rate_node_del() takes this lock and it's already
>> holding the devlink instance lock.
> 
> ice_devlink_rate_init_tx_topology() wasn't (till now) called with
> devlink lock, because it is called from port representor creation flow,
> not from the devlink.
> 
> Thanks,
> Michal

I take it you will make a respin of the 4 subfunction patches in this
series then?

