Return-Path: <netdev+bounces-23358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09276BB50
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1FB1C20EE6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB723581;
	Tue,  1 Aug 2023 17:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76521D59
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:34:32 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED121E53
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690911270; x=1722447270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xJvO2kDijNqLKyNTVVdftTv1uHJtqwbqEV9JSkKVkaI=;
  b=Ib4vTrVDU3VR0EVqyLqxhIN3DBuclDBYOwpI7KAgejJw9d1YJUF4rYsD
   60mlhuOCI/8t+Pe0bhm1VsHzLat6ePp0FxbeLfXrROTTonUdCFveTvOh2
   1NP3/T3NUIVl6pmxcCNJTet8VdfqhZ8wahBIeQ/TtkWkJZxFnPPWEEcP/
   Mt+qtfyXvZcDLbk9klA5xYddKFbGgQfsP7jfc15gEnkgG5871us6zmr2S
   Ukrj8eUGQ+AO8Lv5yoLxxFq6UsTg93wvEKmiyNMXFkPPWBL4YiMa6EDdF
   RiGPFnPn42rJOLB+rdYKfbKZAhKlbHuh06IlVcZpIONhoPBd2q0lzuh+R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="348970280"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="348970280"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975389009"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="975389009"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2023 10:34:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:34:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:34:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 10:34:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 10:34:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeUzGmO3lQP7Xipo4OCgxQOHnnR84JrbuxsnpftzmzdxDOqbxXSQ+HV1EgsVpMQPnw4slbKxOhZ91IPKbs80X9l+1tz0IRwixVtnNH19HPnWwoI2oj7p3ag+ESUbkeIQ4qWK+iQj6at4fJceMDr1lb1La3QY/3yEVpGx5GtBHKHRNShhJl+jCSN20EX58BO9cX5lmJ2PZFzO/UURR77I0MXyNX3PsViVDsReIEai/nyeRyCGEdScLA/WlnlZXVK4YSjI/hrW/GuYzvOT2gwB0LnZn+Trha8ZFRQVTzu077X20wt5CPWI2SChonLdhscDIeFj5OEupcNuoXxNV6I28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A++2UNk8u/vl/LEC3EpDZqZv5bEyz5wcCOSbHO/KtUo=;
 b=BnQykNFAs2N7dDOQhj9zUxmqBoRjcGk6lJAavr16hbNmIUR9sJd9+sA3GiN6bNX5E0iSPcQSucTj1gw/zhMB89G4ovfb2LlqSI52c2c7drNepmldW4hSbxdHi3YefGcSboQGk7JLG56EEW3GA6wwr9IjBFjyx9dSkeFcFtmZEn8rA8GZ4BKBEGc0bhMSeUkyccRpZllFqZd0YMS3Abqq3OUqejeGw0Bpj+KkmC6TQC+XOSJwkHtCCqg+f9qB3ARJBftExolu0/4xiT0U9ePk11xTCwR+8gD1cPQmSi2sZgY5zo9Ge64jQl+l//tzqbYoDdrJ1A3COeK75GCiFwCvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 17:34:26 +0000
Received: from SA2PR11MB4921.namprd11.prod.outlook.com
 ([fe80::2c53:803a:f26:b3b0]) by SA2PR11MB4921.namprd11.prod.outlook.com
 ([fe80::2c53:803a:f26:b3b0%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:34:25 +0000
Message-ID: <a6615bf1-42c8-ed13-c9db-29b718d7fb6a@intel.com>
Date: Tue, 1 Aug 2023 10:34:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] pds_core: Fix documentation for
 pds_client_register
Content-Language: en-US
To: Brett Creeley <brett.creeley@amd.com>, <kuba@kernel.org>,
	<davem@davemloft.net>, <netdev@vger.kernel.org>
CC: <alex.williamson@redhat.com>, <shannon.nelson@amd.com>
References: <20230801165833.1622-1-brett.creeley@amd.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230801165833.1622-1-brett.creeley@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:303:b9::18) To SA2PR11MB4921.namprd11.prod.outlook.com
 (2603:10b6:806:115::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR11MB4921:EE_|CY8PR11MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: c5373692-53b7-4554-7722-08db92b58ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUpqKShG/H1L3Fis/UKieeQOQx8YkQA4GHiPJ8yztY1lC/FM3YljFFFq1FRgKhT5FP8d8n4uSPbYzjh480XCpnurnn2DOMTprIc6y+kRH14CJRG6hGfPY4kFjNN3GhWRkRcr88gX/OwijAyrrgo0lJOljWdGWCGVjHeZEmU+ycSAwp5zPRNQhmYfsf0Lh8h8TybIh2xHTg2y0yCgBZwuzxdAyOKz3GSqHGk6JV3YMmn1PL0Oz4Q38ik1UEAwK+7ttiyLqFkKit2PK3ZLYP9GznYgLKwqJnCy0DIfnfWPq4gmrCVomwP4vjv0QsAK0p4xrZLRqZSwthb/40dBOU6KNczoMh+DHun21gon0VQ4cb8bYUVgrDAE7IlbjW+9G952poP+BLkLwBr3R4ZlC+OEJmGwHvYguyNhxoxJ3CoWctMLhR1x/ufHABVOP5vn0PTDMv0lPBgy4M8ScLf+1yPt/twlAZy3Yh+rQfbSOIkp2pzUChSjuL9DR18YSt9Ftcv1TSQSAHhRMcNhS26qMN1IP5hKZmF8cbY05BQCANIWlKsWMWUm/lpOPEt57d4fc6VAVvCLBeiQGnSgd9pyhDdLy65bfknZhtphj770zZY4Z1AqKvZhnT4+TdQ5YByRHLTJ51MKfXBtVJdj1EXFkPum0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4921.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(2906002)(4326008)(4744005)(2616005)(186003)(316002)(44832011)(38100700002)(31696002)(31686004)(41300700001)(478600001)(86362001)(6512007)(82960400001)(5660300002)(66476007)(66946007)(66556008)(53546011)(6506007)(26005)(8676002)(8936002)(36756003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTFNZXM4ekFlZXN4d3Fud3hhTVNwYmdYMkFDdHVHVnBHeXF2bnpEcnZMeEc2?=
 =?utf-8?B?Wmx2amJGM08zU3l6K1J2MHV0L2lIV3lKWHVaT1BORk5aOGptdDhrVWxpTWY1?=
 =?utf-8?B?RVBWcnNaWWpJdXdCM2FXMVdpSHBqL0xKNFlkSFZKbzlCQ0dmVnFIT1lPT0FF?=
 =?utf-8?B?YldFRXlaOEJSTEVMNnRjTFFlSTV5djh1MjBDdWZDRDR2dFlHalRGeWpSWkYy?=
 =?utf-8?B?OThxMHlrV1VjK0tuQUJBLzFMeTZKVVdpczZhOUd0U2Y5MCsxQlNuS2hxQmVO?=
 =?utf-8?B?V3JZMlkydGVKV1VqTWRJOE10WmFFWUlvVTlyZGh6U3hOR0Y0VkNrK3FqQ1c2?=
 =?utf-8?B?dEl0MklQQWNhVUVNZjBpcFUwK0tsWDk5NUNVaEdzRlFERmQzTk5oMWtFL0Jn?=
 =?utf-8?B?YU5XSnVVSUUyTTBKdm00OXJ4bW5NUkJkclpyWjkySEtvVFZTUEhGRkZqRlZI?=
 =?utf-8?B?VS9CYkppenAvRlBmQXBpYWQrcFFEMU83UWxuMVk0ZlUwWnVxTVNKckxaR1Np?=
 =?utf-8?B?RTlnR2VOTjhUZGpVY2wreTVBZ0h1cGNJUmlWWjhIMjl5WmtkRWJ4bVhLKzRI?=
 =?utf-8?B?QlYvSUdmK2EyZW1CTGI4VGtxSCtPMkh0blIxNXlaWk9tOTlBYUp2dFNnYm1C?=
 =?utf-8?B?dmZkM3hWTWE2b2VieEFBOEdxMVFHVEl4ME53QllMbU9xY2F1c1ZXWWppNDQv?=
 =?utf-8?B?ZTF4MjN0MWZZdDkxZXB1RDVEZEZmRmRwbmNZbUJMRHlYdFZzUUU2K3YvT2M4?=
 =?utf-8?B?RHYvQ3F2ZjdDREtFa1lwZGtXSkZWTlA1bTNuVkJqSlRXNFRWbzEvM1ZRQVpZ?=
 =?utf-8?B?S1pFN3VtdmozMUcrdjFLby9RSThzOGJzakNWSkNxUDV1cWdVR1RUc1BxWnJI?=
 =?utf-8?B?Zzl5R3dhN0ZROXZQdThCVjEzaEY3MWk2ZnZlQmc2bnpOc2Zya0tiUmppUnBr?=
 =?utf-8?B?SmphcE1Fam5kZm5CdnVJY2pkR2xqTHQ3MjBiWXZqRHVDRmliOXZEcjkyYUpQ?=
 =?utf-8?B?WG9UM0Foc0IxM0orMUF6aGRTTnl5SE8vcENRK2xoekxXYXBFaVVjL1lsT1Nv?=
 =?utf-8?B?Q3A0VWFBWmxNdXA2MFphNzBhSVRobWcwZTdkOWJBRHdLYVJkMCtrQTVEOHZJ?=
 =?utf-8?B?eHBtUGFrcXdIODk5RmJSdm81UkF1S0ZPYkJMZndiYmUwMDBFdE5mOVVQWEVL?=
 =?utf-8?B?V0dhVkNKMDlXYllmQlg2RGV2SzhNV3FjOXBvQXdSV0cvV1RHSTV4RFZMTkE0?=
 =?utf-8?B?R2gvVlcrMlplMUROaHF1Vlh2ZVdMWDJzMnY3TTlmcWgzSnRTbzNMcFY5ekRC?=
 =?utf-8?B?ZE1BckZqQ3RBT05XS3l6Y2NZckg1cmU1RWZBMEZjcFZWNTIrbWtGVHpSME5y?=
 =?utf-8?B?enBlZEhoZDhRSWsyQUhic0VFVHRpeEtvL0VwanJUQXRtT1N5M3k4YVpYMUpq?=
 =?utf-8?B?S3RUbmYyMU93VXhFNUY4R3VxbndjTHMrbkxxZUJPYWp3MG5WQTdaME1HZVJx?=
 =?utf-8?B?Rk5JOXQvb2RyUGEwWTVRcWErMzh5cmpWTE53MUY0Y1BQOEVpTnZxNG8ydXlH?=
 =?utf-8?B?R2Iza2xCSEt0YXliNmhMQ3p3MVBOazJYZTFOQTNjL1NZejFtbS91Ykg2VE1C?=
 =?utf-8?B?QkdNQ2oyNkFBT2Rqa210c2ZZNmFmcmpPNGltVEJaZmk0YnhjZW9wMGc5bk5E?=
 =?utf-8?B?ZWE1NWJlUmxVZ0ZUeVJES2ZHaHh1VnUwMDNSWGRpRDcySnNKc09NQzRKblo1?=
 =?utf-8?B?VHlFTEVKd3Zpd0IvR0w1bWtCYTM4eGFjNDBqaHkxK0o1SWthOVltbGVMTHFt?=
 =?utf-8?B?d1ovL0grWXdNdkkxZ3dwcUlNa0MvKy9lZ3QrS0lmR2p5c2syVXlpcjJ2cGxN?=
 =?utf-8?B?bW4wb25nR1JMd0szc25mY0FkNWNKQlFSZ2hvZndlbEovQktFWjlETWtreEFS?=
 =?utf-8?B?OTZLN0dWUE5mWTdUdEFCSW5wN0s3UWcyTTV0QXdnTVRGRExYczlQak12MFd3?=
 =?utf-8?B?OHFaejQ3eUV4MHh3anFFVnJzYURsK0xCbENHNHVwc04rWkNGOGM0cWowckgr?=
 =?utf-8?B?ZXI1RnRjUHE0VE4zVDhCa29hS1h5WlZzQnoyOGpnQkM0bHQzczlxWnJvakJV?=
 =?utf-8?B?OHBqZm5jS29BdWswOVBsWTdQTEhWQ013WWNSVlNubTdPQ2p1MzBVN2JkRkp4?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5373692-53b7-4554-7722-08db92b58ccd
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4921.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:34:25.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rIPm8ns1K3QAB1t0jq0X4xTwItAy8TlrTzyWsJLND7jMAL9nsvvl5M2sTZHQky5PcSSB7tuEu0kUYfICrMhG41Nui242P0CTcHQYHS1cE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/2023 9:58 AM, Brett Creeley wrote:
> The documentation above pds_client_register states that it returns 0 on
> success and negative on error. However, it actually returns a positive
> client ID on success and negative on error. Fix the documentation to
> state exactly that.
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


