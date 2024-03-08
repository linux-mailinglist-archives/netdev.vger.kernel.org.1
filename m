Return-Path: <netdev+bounces-78674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B248761BF
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4977E1F214B7
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF353E25;
	Fri,  8 Mar 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bz5e52Rz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8753E32
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892995; cv=fail; b=ZZBWmdXaZKvtjpZN1ebT+7JUTnYVHIEGnLqzvx8ZZKk761ltKnA+7lWl2/xfRIRYrm5+CxQpw9USLhWb+VHTNlS3Ek/PPBrD+fGV/LcBE1wPsSS57hzBzaIOIOOjdjMgaYSju4IniILF8HTqlSkoKHr7Wqa7utP1H0TDvp0HmVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892995; c=relaxed/simple;
	bh=lXsMKpbDPHNyXi9a2632m/UlbWjK/rD2hM4iNNWsSJg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HlKnVl28zxqQAdWHvsOsJ8HsByvdI6UAQvol0cxbxUvNibye9sW1abXb73K3YynDp7djBeoZ31pHx/0ACRsLwcp9/kbhMRHZj4T/rO6arY9Je5MTH9kdjrF3SqUYKGzZUATBzf2xmbWg4nR7RhEt//TyUm/BZNmuXrUAh0fpdFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bz5e52Rz; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709892993; x=1741428993;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lXsMKpbDPHNyXi9a2632m/UlbWjK/rD2hM4iNNWsSJg=;
  b=bz5e52Rz5WQZgRqIfbXasoZlsUzzLv3i3/7+mPujq2thYBH6gV59UW/V
   QJ6CiKT2nyt75YtGk4mFxYuswCCxROeYqyKvDPFxaiKroNhBRikg1yEqp
   QAOjBOOxhjxmFOkqp+6DGH7bgKQRFurqavWr2FVj2jYsksyPaJ/0YhuE8
   fFCg1Xo4C+H59Ca5iNHchgq4JximTsYHhfdNkKL7jtKoLzdaM2iB3RM0n
   gHm0Mh00n8Mqp7K7/un62RmwKOYCQ4DKe5ch6TH7yK+FzjTnQ4Dr5d6wy
   +c04yLDgzob587XG5KZc/z1k+63F9EztpZe0jRW/5n7P81X3SMdZ5nSNv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22132712"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="22132712"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 02:16:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10865037"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 02:16:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 02:16:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 02:16:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 02:16:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdtS2LlI7fu91uHHh51oBt6lVy0+gRh//OB7w1gCDGHIe0wTf+YVzAhr2/VOFglIXUYhGdthGrLS8hdsyKBd3H/He4QQEXR2AoAuf6XhF2Yn2BgIQjU7PcG4HaX+lEgBDmqkDSn+LDpvkJBkWR+hd1Wk1Fo+VmfKBtioEBKrVgvpCONl4hqZp6LSlv+RkLeae3a4BE8uypjK5CYg1wIP+lpNKQ593KN4jrh0kX7hStXzwSa9Q03mmqviRkfKCaX3fJ99C03Gn/hYcFC7OFwaYlify7i+8J+dD5G7WequPGmDgINyB8ZZhMnPiAVuvQ+N5blGpTWl2irl+//wylnfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3bz0QqRl8BdZTeUgAyI8pJzvo83V7YEt/b+LhOg0Rs=;
 b=TQNYElydXn6k9yYh91g8ILq7U7MsANIZ8j+APSxLasev831MYQaNW3YYXzS+41MrcM0X411Q+GmxpuxBKoincq5RiqueN0f/P4jWMo4pIcwjAqKVqTHFmj5P0krxWAxUiRMQVxVaredgcfx3WoRxR3VAqPL1zv2YZMAtrujtQtnjID7axj76oM7uuOYEA2WYM9bul60WvxrVray34EydvND55ePq+VOBqsC6Xm34n0OQMwFArfNRGrkqMOkGieJRdZt1PLcOXTNSQ6kb1UqYxgV7Vtuy8zqNM8odNuMVl67tuomWJFaEpKnVrdGb7kQXGS51q9yjY+I9AT5AOCXGKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by SA2PR11MB5068.namprd11.prod.outlook.com (2603:10b6:806:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 10:16:29 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::1de2:160a:9f9e:cb68]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::1de2:160a:9f9e:cb68%3]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 10:16:29 +0000
Message-ID: <5853cc14-f630-4394-9d87-6ee5b1e10228@intel.com>
Date: Fri, 8 Mar 2024 11:16:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v6 5/6] ice: Add
 tx_scheduling_layers devlink param
Content-Language: pl
To: Jiri Pirko <jiri@resnulli.us>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <kuba@kernel.org>, <horms@kernel.org>,
	<przemyslaw.kitszel@intel.com>, <andrew@lunn.ch>, <victor.raj@intel.com>,
	<michal.wilczynski@intel.com>, <lukasz.czapnik@intel.com>
References: <20240305143942.23757-1-mateusz.polchlopek@intel.com>
 <20240305143942.23757-6-mateusz.polchlopek@intel.com>
 <ZegsMb-U8WbbT-mr@nanopsycho>
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <ZegsMb-U8WbbT-mr@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|SA2PR11MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: bb58dd5c-1a84-4e3e-05be-08dc3f58d1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLIuslcMhjezoG5zJWHufQdX65SFONekBm1SRL4iC1i/rz2afMRI2RJiiRLCFgB5NK6V/5O936oVuy1gn4drXi/0PejakK9b9q8HVulkM/Hw7eO3hTIatXDnG79Yy1p2LNhengfXvJVj6WBo/6KCS4pLRquoVOOfoslbWjA+9qk5zJ6Nwhl7KrZsaAsujwAgGtI2+Itskje95iaoaGlllU+Cvl4y9U5JwYU/nzjpnMWFdlHs/ZiqHHiO32f4EdVE/feso4BBuKBHnvseBWX+Ap6s8JXR4u3/+vT34Jekv08Y+p+Pq9tXqJ8gz10mMS4QJEnc79/Ri66gZpf/g3W2WQI4hN6fWUBj5pUjtB/veC9pi87XrYz/6Bz5MIY6y+h5S4ShfVEa07DQDfmqAhfbt5CTa1SOdc+EIBg197C8DdE9bqRhnHd0x5YLh5/Vfp5CThu7AfGDH9oGEdPwjRBgVudfEQ1igTyUyvp2wEIIzbbUb9QMO2GxymaCfV5eXZpNdML/9y7RssPO0Jqqcb1tW7yJNmftXGkOTE64x+LgxZ6XyvUrnFsWDZLBymZjRUfxl66mVTk/hwBWnGxtHuumlzJNNP25+4fD1VWdDqfWASk9lVoHRwWj7TvI4Tarb6Wi2UoduUt9WqJh085c8jEZI160PLNuPLi50UwqOia4sJ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzVBZHl0QWd4RGcwa1g2QUc0SVQ5am0vYy9sb3dHRmdmdWFsMU00d1JnbGgr?=
 =?utf-8?B?RTJUSGE0WHo0NUxRaXkyVWtRVFVtZWZsSEpQUnFMWEs1WjVWRTZSVEZ5OWtI?=
 =?utf-8?B?OG9RYkJseDRXd3NFdHdnWmZUV0pZaG9uSWJKc01rNnExdWFoblEzWHFrUWhT?=
 =?utf-8?B?NjdsYkRmU3R2ZSs5VjhXYk1JWnpLQi8yUWQzZ1dGcXl2VE05Z3VrQUxBTklo?=
 =?utf-8?B?UzhqRTIyQllEY09Qd09IcDdkeURZRVpWRzRjNFhpQTBqcUlnUy9RVkVpbWR1?=
 =?utf-8?B?MTVCMmRSVFg4TzZGMFBPell5eEJ5bTRaMnlYeXlQSzVqSTBxZEcvVFUwVFl1?=
 =?utf-8?B?OE1BUUJ5R0phbll6UWtYYkNXcDVIbnUxRlpGTE9DckJSajlVK0ZEa3pheGVK?=
 =?utf-8?B?R3ZxL3BiLzVCdzNoUDdSalQ1aE55U2I1SFhQS252cEJ0RklVVWpSMDBKWXZJ?=
 =?utf-8?B?anYvSDZ2OGdueGwzNC9QVmZBZ0NTWkNZekVRYWpuT2xaRjZDeTJvTUZYalF2?=
 =?utf-8?B?OVUvdk16U0JOdC9zbUU1ZUE0RUgxZHhEcmI4OHhmYy9IRnZtK01BZlNlb0Z1?=
 =?utf-8?B?enhDQ0hCT2RBWkkrOXpTRmc0OE81U0Y4Z3VEQ3lWVG5hTURpL1ZkaHBic0E4?=
 =?utf-8?B?UEV1QnRsUko5VmRjMGxob1hyUGpiNzI5YmVCVGhlazh0WFM3V0dyMkloM20v?=
 =?utf-8?B?bkE2Wi9NRU1RMytmNjRkcFluSHd6K1B6VUVaV2pnRmtqL3hvejdvNHJoMEFW?=
 =?utf-8?B?ZDRaSUxiaXdaaDVTMUkrMkEyNXFJNHFzdEtvNzRnRXZjV05Gem9pWUlDL1k0?=
 =?utf-8?B?ZE8yRmVMUHFmSEFwMGFKTXpSdkdHRFlySER6dGRKYWIvQVlUaTg3TlQ2UFVP?=
 =?utf-8?B?REkzY3pMajZaRjVxTW5MZ3dZK2YxNWRDSGZ0ZW4yd3MwcEdZaW1mM2gyTnU1?=
 =?utf-8?B?eDFUb1F4ZjRqaHg4K1VMQTBobXNuckhqcVQ4NTdnR1VVSE8yakk3WG8vYlp5?=
 =?utf-8?B?MmRNandoRS9RU1k4R1Y4dk83WnhNYm9ZbWg1U0x1VEpFWG9TcGVtUHUxdEJy?=
 =?utf-8?B?RmU0c0dmQXErVllVSm9ITTVxWDk5cHJxV1YzQjRwTGNVVU5oL2hLdWFMMzBO?=
 =?utf-8?B?RnVSeVdqZ3dTUTBoS2N5YzZiRURzTjh0akxSOGRqWDlBRWwrVU9TeUFaQUJY?=
 =?utf-8?B?Nll5VHJBT0wzUTJKQ05KMkRVcEVTTDA4TGhPNmYxYWJsN2lpU2pBRXJ4WlFN?=
 =?utf-8?B?SWpzMEhiV1R6eDVXeXJ1bG5OVVBYaFRPbk9aYzR6NGNYaHlnaWR4dkRybnFi?=
 =?utf-8?B?d0ZMbzU2bEh0c2tkN1VoWGtPTVIwUUtBajRMV3BaY1RIaGVDekxnYS92WUVB?=
 =?utf-8?B?SFY4NmU3WVp2M0x4bEd2RTVLWjVNdVdNOWkzaHdFaU03aXE3QTlDcGNXcjYz?=
 =?utf-8?B?aEFDMXVROVR5UDBOMVkyVUFpWEFSMldLTk5mVDl3ekVBZDRrZ1owdTZvTU5W?=
 =?utf-8?B?WTk5elBJd0UybVdjTjdCZFRWVzlaMVZ0d29xcUZkSWtXOHhNL0pOdkU3dVgz?=
 =?utf-8?B?NHVUeUZXVXVYVDB6WE1VeVZjU3Z4eXdHQ3o5TXhJTWMyWlVBa0NHcU9Ybldi?=
 =?utf-8?B?ajAwNGIzbHN0RjZoMG9zTlg1VVNNTEtYTHI5emxBcHZTeTFuTndZOGlLZTBh?=
 =?utf-8?B?QmQ1YUF5NWx4bDlBbkVLL01yNkVycnUxK2t5ZEZoaVYrUkM0dUJWdm9uQmZi?=
 =?utf-8?B?ekE0S0owb3o3RWRpNGc2VHlWRnZDSXZrallEY29TSzNPSHNUYUdmQjlTS29t?=
 =?utf-8?B?NWJHSHcxandtTkdENlcxeXM3NnNOdkhwVlJWbCtUUWE3ZTBZOS9tcUJ6ZE9F?=
 =?utf-8?B?cXBuODhEKy9CUGpTQk1lUkNGTkJ5VXorZmlFcncyR2pCU0hIOWNTbFJTbHVE?=
 =?utf-8?B?ckJrNHJwZ25jVzRkNjBac0xHcUJ5SDRrdHdhL3VsWk5LdnpiTlFhL3k0VE52?=
 =?utf-8?B?ZkFBZ0gvbHBTYXNZT0Ftcy9YU1h1NGM3U2Q4a3BqS1h2eVV1SE94MVYxeG1G?=
 =?utf-8?B?TzFyUC9IdXhGb21jenRQRG1xd3RYbW5nYTJMRlJHcHpWNWYxT2NhbGFqMHJ5?=
 =?utf-8?B?RHZlclhESDd0c3FXcmlGVjgyQUlXUXJZMUIrY003MklPL3FNYzY2RkRZVFRs?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb58dd5c-1a84-4e3e-05be-08dc3f58d1e1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 10:16:29.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwO5YNy1TzvYSm4HCvFQvqaTUBzuJYL7zwgxn25wsdV04pZ6ZXqsjw4JfuGph3JkxHSb1qII2tnrb7pTbib6Aw/bEdeHl0UriITHaa7q1ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5068
X-OriginatorOrg: intel.com



On 3/6/2024 9:41 AM, Jiri Pirko wrote:
> Tue, Mar 05, 2024 at 03:39:41PM CET, mateusz.polchlopek@intel.com wrote:
>> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>>
>> It was observed that Tx performance was inconsistent across all queues
>> and/or VSIs and that it was directly connected to existing 9-layer
>> topology of the Tx scheduler.
>>
>> Introduce new private devlink param - tx_scheduling_layers. This parameter
>> gives user flexibility to choose the 5-layer transmit scheduler topology
>> which helps to smooth out the transmit performance.
>>
>> Allowed parameter values are 5 and 9.
>>
>> Example usage:
>>
>> Show:
>> devlink dev param show pci/0000:4b:00.0 name tx_scheduling_layers
>> pci/0000:4b:00.0:
>>   name tx_scheduling_layers type driver-specific
>>     values:
>>       cmode permanent value 9
>>
>> Set:
>> devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 5
>> cmode permanent
>>
>> devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 9
>> cmode permanent
>>
>> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
>> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> ---
>> .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   9 +
>> drivers/net/ethernet/intel/ice/ice_devlink.c  | 175 +++++++++++++++++-
>> .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
>> .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
>> drivers/net/ethernet/intel/ice/ice_nvm.c      |   7 +-
>> drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
>> 6 files changed, 195 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> index 0487c425ae24..e76c388b9905 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
>> @@ -1684,6 +1684,15 @@ struct ice_aqc_nvm {
>>
>> #define ICE_AQC_NVM_START_POINT			0
>>
>> +#define ICE_AQC_NVM_TX_TOPO_MOD_ID		0x14B
>> +
>> +struct ice_aqc_nvm_tx_topo_user_sel {
>> +	__le16 length;
>> +	u8 data;
>> +#define ICE_AQC_NVM_TX_TOPO_USER_SEL	BIT(4)
>> +	u8 reserved;
>> +};
>> +
>> /* NVM Checksum Command (direct, 0x0706) */
>> struct ice_aqc_nvm_checksum {
>> 	u8 flags;
>> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> index c0a89a1b4e88..f94793db460c 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> @@ -770,6 +770,168 @@ ice_devlink_port_unsplit(struct devlink *devlink, struct devlink_port *port,
>> 	return ice_devlink_port_split(devlink, port, 1, extack);
>> }
>>
>> +/**
>> + * ice_get_tx_topo_user_sel - Read user's choice from flash
>> + * @pf: pointer to pf structure
>> + * @layers: value read from flash will be saved here
>> + *
>> + * Reads user's preference for Tx Scheduler Topology Tree from PFA TLV.
>> + *
>> + * Returns zero when read was successful, negative values otherwise.
>> + */
>> +static int ice_get_tx_topo_user_sel(struct ice_pf *pf, uint8_t *layers)
>> +{
>> +	struct ice_aqc_nvm_tx_topo_user_sel usr_sel = {};
>> +	struct ice_hw *hw = &pf->hw;
>> +	int err;
>> +
>> +	err = ice_acquire_nvm(hw, ICE_RES_READ);
>> +	if (err)
>> +		return err;
>> +
>> +	err = ice_aq_read_nvm(hw, ICE_AQC_NVM_TX_TOPO_MOD_ID, 0,
>> +			      sizeof(usr_sel), &usr_sel, true, true, NULL);
>> +	if (err)
>> +		goto exit_release_res;
>> +
>> +	if (usr_sel.data & ICE_AQC_NVM_TX_TOPO_USER_SEL)
>> +		*layers = ICE_SCHED_5_LAYERS;
>> +	else
>> +		*layers = ICE_SCHED_9_LAYERS;
>> +
>> +exit_release_res:
>> +	ice_release_nvm(hw);
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * ice_update_tx_topo_user_sel - Save user's preference in flash
>> + * @pf: pointer to pf structure
>> + * @layers: value to be saved in flash
>> + *
>> + * Variable "layers" defines user's preference about number of layers in Tx
>> + * Scheduler Topology Tree. This choice should be stored in PFA TLV field
>> + * and be picked up by driver, next time during init.
>> + *
>> + * Returns zero when save was successful, negative values otherwise.
>> + */
>> +static int ice_update_tx_topo_user_sel(struct ice_pf *pf, int layers)
>> +{
>> +	struct ice_aqc_nvm_tx_topo_user_sel usr_sel = {};
>> +	struct ice_hw *hw = &pf->hw;
>> +	int err;
>> +
>> +	err = ice_acquire_nvm(hw, ICE_RES_WRITE);
>> +	if (err)
>> +		return err;
>> +
>> +	err = ice_aq_read_nvm(hw, ICE_AQC_NVM_TX_TOPO_MOD_ID, 0,
>> +			      sizeof(usr_sel), &usr_sel, true, true, NULL);
>> +	if (err)
>> +		goto exit_release_res;
>> +
>> +	if (layers == ICE_SCHED_5_LAYERS)
>> +		usr_sel.data |= ICE_AQC_NVM_TX_TOPO_USER_SEL;
>> +	else
>> +		usr_sel.data &= ~ICE_AQC_NVM_TX_TOPO_USER_SEL;
>> +
>> +	err = ice_write_one_nvm_block(pf, ICE_AQC_NVM_TX_TOPO_MOD_ID, 2,
>> +				      sizeof(usr_sel.data), &usr_sel.data,
>> +				      true, NULL, NULL);
>> +	if (err)
>> +		err = -EIO;
> 
> Just return err. ice_write_one_nvm_block() seems to return it always
> in case of an error.
> 
> pw-bot: cr
> 
> 
>> +
>> +exit_release_res:
>> +	ice_release_nvm(hw);
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + * ice_devlink_tx_sched_layers_get - Get tx_scheduling_layers parameter
>> + * @devlink: pointer to the devlink instance
>> + * @id: the parameter ID to set
>> + * @ctx: context to store the parameter value
>> + *
>> + * Returns zero on success and negative value on failure.
>> + */
>> +static int ice_devlink_tx_sched_layers_get(struct devlink *devlink, u32 id,
>> +					   struct devlink_param_gset_ctx *ctx)
>> +{
>> +	struct ice_pf *pf = devlink_priv(devlink);
>> +	int err;
>> +
>> +	err = ice_get_tx_topo_user_sel(pf, &ctx->val.vu8);
>> +	if (err)
>> +		return -EIO;
> 
> Why you return -EIO and not just "err". ice_get_tx_topo_user_sel() seems
> to return proper -EXX values.
> 
> 
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ice_devlink_tx_sched_layers_set - Set tx_scheduling_layers parameter
>> + * @devlink: pointer to the devlink instance
>> + * @id: the parameter ID to set
>> + * @ctx: context to get the parameter value
>> + * @extack: netlink extended ACK structure
>> + *
>> + * Returns zero on success and negative value on failure.
>> + */
>> +static int ice_devlink_tx_sched_layers_set(struct devlink *devlink, u32 id,
>> +					   struct devlink_param_gset_ctx *ctx,
>> +					   struct netlink_ext_ack *extack)
>> +{
>> +	struct ice_pf *pf = devlink_priv(devlink);
>> +	int err;
>> +
>> +	err = ice_update_tx_topo_user_sel(pf, ctx->val.vu8);
>> +	if (err)
>> +		return -EIO;
> 
> Why you return -EIO and not just "err". ice_update_tx_topo_user_sel() seems
> to return proper -EXX values.
> 
> 
>> +
>> +	NL_SET_ERR_MSG_MOD(extack,
>> +			   "Tx scheduling layers have been changed on this device. You must do the PCI slot powercycle for the change to take effect.");
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * ice_devlink_tx_sched_layers_validate - Validate passed tx_scheduling_layers
>> + *                                       parameter value
>> + * @devlink: unused pointer to devlink instance
>> + * @id: the parameter ID to validate
>> + * @val: value to validate
>> + * @extack: netlink extended ACK structure
>> + *
>> + * Supported values are:
>> + * - 5 - five layers Tx Scheduler Topology Tree
>> + * - 9 - nine layers Tx Scheduler Topology Tree
>> + *
>> + * Returns zero when passed parameter value is supported. Negative value on
>> + * error.
>> + */
>> +static int ice_devlink_tx_sched_layers_validate(struct devlink *devlink, u32 id,
>> +						union devlink_param_value val,
>> +						struct netlink_ext_ack *extack)
>> +{
>> +	struct ice_pf *pf = devlink_priv(devlink);
>> +	struct ice_hw *hw = &pf->hw;
>> +
>> +	if (!hw->func_caps.common_cap.tx_sched_topo_comp_mode_en) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Requested feature is not supported by the FW on this device.");
>> +		return -EOPNOTSUPP;
> 
> Why can't you only return this param in case hw->func_caps.common_cap.tx_sched_topo_comp_mode_en
> is true? Then you don't need this check.
> 
> 

Hmm... This comment is not really clear for me, I do not see the 
opportunity to change that now. I want to stay with both checks, to 
verify if capability is set and if user passed the correct number of layers

>> +	}
>> +
>> +	if (val.vu8 != ICE_SCHED_5_LAYERS && val.vu8 != ICE_SCHED_9_LAYERS) {
>> +		NL_SET_ERR_MSG_MOD(extack,
>> +				   "Wrong number of tx scheduler layers provided.");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> /**
>>   * ice_tear_down_devlink_rate_tree - removes devlink-rate exported tree
>>   * @pf: pf struct
>> @@ -1478,6 +1640,11 @@ static int ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
>> 	return 0;
>> }
>>
>> +enum ice_param_id {
>> +	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>> +	ICE_DEVLINK_PARAM_ID_TX_BALANCE,
>> +};
>> +
>> static const struct devlink_param ice_devlink_params[] = {
>> 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>> 			      ice_devlink_enable_roce_get,
>> @@ -1487,7 +1654,13 @@ static const struct devlink_param ice_devlink_params[] = {
>> 			      ice_devlink_enable_iw_get,
>> 			      ice_devlink_enable_iw_set,
>> 			      ice_devlink_enable_iw_validate),
>> -
>> +	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_BALANCE,
>> +			     "tx_scheduling_layers",
>> +			     DEVLINK_PARAM_TYPE_U8,
>> +			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>> +			     ice_devlink_tx_sched_layers_get,
>> +			     ice_devlink_tx_sched_layers_set,
>> +			     ice_devlink_tx_sched_layers_validate),
>> };
>>
>> static void ice_devlink_free(void *devlink_ptr)
>> diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
>> index 319a2d6fe26c..f81db6c107c8 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
>> @@ -286,10 +286,9 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
>>   *
>>   * Returns: zero on success, or a negative error code on failure.
>>   */
>> -static int
>> -ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
>> -			u16 block_size, u8 *block, bool last_cmd,
>> -			u8 *reset_level, struct netlink_ext_ack *extack)
>> +int ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
>> +			    u16 block_size, u8 *block, bool last_cmd,
>> +			    u8 *reset_level, struct netlink_ext_ack *extack)
>> {
>> 	u16 completion_module, completion_retval;
>> 	struct device *dev = ice_pf_to_dev(pf);
>> diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.h b/drivers/net/ethernet/intel/ice/ice_fw_update.h
>> index 750574885716..04b200462757 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_fw_update.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_fw_update.h
>> @@ -9,5 +9,8 @@ int ice_devlink_flash_update(struct devlink *devlink,
>> 			     struct netlink_ext_ack *extack);
>> int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
>> 			    struct netlink_ext_ack *extack);
>> +int ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
>> +			    u16 block_size, u8 *block, bool last_cmd,
>> +			    u8 *reset_level, struct netlink_ext_ack *extack);
>>
>> #endif
>> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
>> index d4e05d2cb30c..84eab92dc03c 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_nvm.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
>> @@ -18,10 +18,9 @@
>>   *
>>   * Read the NVM using the admin queue commands (0x0701)
>>   */
>> -static int
>> -ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset, u16 length,
>> -		void *data, bool last_command, bool read_shadow_ram,
>> -		struct ice_sq_cd *cd)
>> +int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
>> +		    u16 length, void *data, bool last_command,
>> +		    bool read_shadow_ram, struct ice_sq_cd *cd)
>> {
>> 	struct ice_aq_desc desc;
>> 	struct ice_aqc_nvm *cmd;
>> diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
>> index 774c2317967d..63cdc6bdac58 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_nvm.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
>> @@ -14,6 +14,9 @@ struct ice_orom_civd_info {
>>
>> int ice_acquire_nvm(struct ice_hw *hw, enum ice_aq_res_access_type access);
>> void ice_release_nvm(struct ice_hw *hw);
>> +int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
>> +		    u16 length, void *data, bool last_command,
>> +		    bool read_shadow_ram, struct ice_sq_cd *cd);
>> int
>> ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
>> 		  bool read_shadow_ram);
>> -- 
>> 2.38.1
>>

