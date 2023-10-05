Return-Path: <netdev+bounces-38309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D037BA496
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 290191C20837
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4634187;
	Thu,  5 Oct 2023 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7IGkLgs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5730CEA
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:07:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01D50BB8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696522050; x=1728058050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=krI0wh8czV5TBRLpoOUfpraRZdi+4q/zmta/XZeFAjo=;
  b=V7IGkLgsCvum/X/3KxPkL7RQSgVfCc3Q77nKg6Xm+xbgXPCAiAAB9kTR
   vNDvrKmudC4H4jbT1wHzWxOKuh5L6ZecQn/lNJ1yD7QCsLYMjscl21it8
   L4gedMmqD6iDaG9xB3tx5fSDiCpwtlY0lwoc6sxtafquU6buYr6mmkcaS
   a1yeTWiV1ZknScFo5R772S0wI/qPSE6J32ev0HyZhjH4eMieUE8YeP1Va
   wJrLk0HeH2caZ2RM9+BRgrfyvXWTySMcKVDNPLLyLh3FhlMk1kX7JKblo
   6wZDoD+4KInjgv0vv/LG7WC3OYT1dXqnUqeUM9SJGGI+fXzGevPMspr50
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380822896"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380822896"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="925648083"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="925648083"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 09:07:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 09:07:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 09:07:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 09:07:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 09:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBsQhGsQ6CRQLJmDj73Z+HE5xXB+rf9dyCRaw3J54kxqVs4VPC+XqwpVjI4Z/UE0ix2TE+Wwin6Hpg7yfjS7syceFK4f7xnkZ3XVVblcbLaF25K5YLPlYOwBgiH/73qIPOGzB/LsEcIV48ymhrBVnohX9uLLsEYWXv5uu03a6q+OA4uTp4p+/TysIjxmPl+H0E1HDtYwzTCCE2xOd+x09C/IK8ytxYMOtV+pGbduYZqZTVRmQgX7A3oNtypDqOMDtsuvuBW6+JoJwP81UnasD95ME6CwiMidQr4lf88wcSpng7maa0y3ddx3IgkfYXie7hGtTEmzSbev4jFGhZ/syg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYglPqXWB2Qq5Qt7/Hz+BZga4YbB9fTB+hXU7z7J7VE=;
 b=G2cX7/lKxsJvlekMue5sU3ZeJrSVHhjydLmvJKm8cVSV22hoxi/um3BJzawliha/F2/nhfd+xPXahU8f3Eeksxp32UG8sktGMufo3JPhQAYRSqu8Yj7mvcO3aIdqOj5p9rNFFtzE96ViK1CjYJfdTfqHG8LTwJjKTsyxGAVMgTXvCeIjzajYSVYGrC6R0Ddvw21G3N1+5X+YZuORBtKvD4vnUiELon7FfsrktSQw7B+y9x44v/6f1TnjzSkTktyMtuuSVki4EYsOzF67bjSXirG4dpDb3VCzh3DMwH4R6PP9eu9P6qlvK8k6zqG4cQt7cQD7IppE5nxKL30RX//1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CH3PR11MB7204.namprd11.prod.outlook.com (2603:10b6:610:146::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Thu, 5 Oct
 2023 16:07:11 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 16:07:10 +0000
Message-ID: <8f2575f8-1da5-2e4d-940f-2cc8045700a1@intel.com>
Date: Thu, 5 Oct 2023 09:07:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver
 Updates 2023-10-03 (i40e, iavf)
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
References: <20231003223610.2004976-1-anthony.l.nguyen@intel.com>
 <20231004172833.12033543@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20231004172833.12033543@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:303:b9::33) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CH3PR11MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6979e8-452b-4366-0ee9-08dbc5bd219e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bdi8oiyEyf9L5OdGave2NQNOu4Xusa7HhzOllLWON4UQkir+cxu8T9CCACd5fWv/okl7UOOxQkZSwbpQWkR0GQZgUySC4XVRsJkzveleyrV8XF4UctwX+7lPnmnfvDIQjPtcSd7QnEYxOVIM/B9bJN/uwhhSXO+2+jbiAWo2DZES593WKi+nIgND0ro9447ddMN/sStvn4TVuTnwi8EKW76uHHjy/HhLPLRvtnUTVyKX26BIMywz163uA/I4WwGjtLLq/q8IPWit9bPuVW/bKgjGw0tFSvmp4dYIjoa5y41y3nkUNkeHCf02NDclOH3BcTCjlfOKoCmqf/lVZBZEx/gVZQ/PF+Lo3YJx/b5kk44aq/lonK8bhr0qbGsYG/VWYKE3YaLl2s1pLT4ejLi15Z4fOGkmPlwuG1uB6IqKiapFP9/xmikhSDyMF33qSYPc/7DOLBxR1IbSfIS2SDtvKtAD3m3ki4cXj+uthR39/rvfSOqrrO8qRSswRUOy1mfPPWfoOZe2Z1aXAmguD9MRD5XwFGSfDHAwT4RPrfFK3DeWD1aBMrBR+QtcABCA+ikQts1OusNFDqmfkj4IAb+o93XnL/5q412Rz7IaNQrlNdto8lkD5lREfjOC2s7EhPiia2tpFZqhOx2SB/n3qYv/iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6916009)(316002)(8936002)(8676002)(4744005)(66556008)(66946007)(66476007)(41300700001)(2906002)(83380400001)(31686004)(5660300002)(4326008)(15650500001)(478600001)(6666004)(53546011)(6512007)(36756003)(26005)(2616005)(6506007)(6486002)(86362001)(38100700002)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW55c2dLRHVKakV2Y0VoTzVPSmltd0ZZZmlpRkNoVUorZExYbWNaU1BqZExq?=
 =?utf-8?B?TzRoWGE3RXNVRjZHYnZvcGtHcnpaRDZpRlJFS2Nnc1Y0Z0tRRzl2ZHVibnd6?=
 =?utf-8?B?Z1ltYlZSL2FPczVDK2hkR0hSRWc1VTN6Y3pPekRWV21UYm1NQU8rRkRJQzIw?=
 =?utf-8?B?ei9Dd0YrTUNuTXY0N1MyWUU1ck9pdktVd0Z6d0VoOGFMa21DU2dXVENRL2VZ?=
 =?utf-8?B?cDdMUVZjcTB2eHVLNldFRE00K2h0cDJianBMQnBxNmdsTXVrWlkzYzFZRk93?=
 =?utf-8?B?eFBPaWR6blVweXUwbmpmMTNveUROK2FHa3dEU2xSN1MxZHBjSmxMRERZSDE2?=
 =?utf-8?B?TGFhV3d0Z251ZVpLZlYyR0xKRFRTVjdhb3A5VnV4TU14VjFiRUVJMDdkYmpp?=
 =?utf-8?B?OXEyb3hoYUpaMlhHSVVTSjRyOHVrU3NTbW9uZHlwUmZwOFJIbWRsT3FFbDJY?=
 =?utf-8?B?MDk5TDlob0JyZ2lZK1JtUEdJeGxiYXhmODEyUUNxbW42OFpEdUJIUkhhZk1L?=
 =?utf-8?B?Nmlud3RsZXhhazNTSC91Z3lVNjRld2dNQU4wRjVQaE9qRFNXdkN3Vmx6azlQ?=
 =?utf-8?B?NkRzbzdiMDlja2U2NjkyQ3ZKNzBqWW9mc0J5Y3BCTk02VXY4VFBreGlCWU5Q?=
 =?utf-8?B?MXZOektaTW5TRGFKQVQrMisyT2F4aGhKVDZzSlA5N2J4cmJRN2EyWVFKZEhQ?=
 =?utf-8?B?OFNEOVRkS1hPMjhiaHNTZERFd0lING5WRmdhTDByVzR2YmxXSXlaN3RKSS9C?=
 =?utf-8?B?YVRmMHVSbG1JMTFMVHhTQnFjaURkZytEaDdPUlBSK3hiMzVlem5UbXVtVUZN?=
 =?utf-8?B?QjdjVFBlZUtEcWtYcnRBVUt2NEdSbytRbzdVZkxJcEdEQUtuUTJVR1ZuTy91?=
 =?utf-8?B?VWNqK0xRbCtzNnZlMnRDbmZqeElGZWlQQytGT0dMSjgrM0JTNC93UXRLVmZB?=
 =?utf-8?B?aXY3TGUzTXNMNFhEdUNsUVozT2lmdTFvdzkvVWJmYmlKc2ROdTRvMHZLOGNh?=
 =?utf-8?B?RFVWb2dCT01yVG45VUYyUUlPQnBoMlB2ZUJQMm51Z2ZiYjBBVktpY0ZJQjFG?=
 =?utf-8?B?YUNyNm9ZUk1JbGRJU1VNbUU4WVFaWlBHUzJ2Nm9RUFFZZE84cUFLTk5Yb2Zt?=
 =?utf-8?B?ellkMFNoa0toU0Y0UE1kT1N0MU9qWWREVWdrVlN2TXJabHZGQzl4QTJ2VmVn?=
 =?utf-8?B?NUg3ZWcwWlpHV3FsbTRIdTljUmJ1UTA4WnUxaUtUbTdoK2xIUWVCRDNYR2Vn?=
 =?utf-8?B?TExVV1NKckxUdFhsUWxLT0U1UFpwNkxCeWJLOGtNZjYySDFSSHlIU1dmQ3Z3?=
 =?utf-8?B?SHRvM0wrOXRZTXhsQ1ZSSG5adGp2K2htWktrQnJYcjFGVE1pd3U3RmNnbUhi?=
 =?utf-8?B?eHdzZmVubno4WHcrRFlXdHNWeEJ2ZzdxdEpLVExpdlNrZHlGeit3TW81cWpV?=
 =?utf-8?B?M1ZKWVhmQXdMZXlCV2tmM1BxaXJLMXpuNlJPK3VXcFdDWkRib3R0WURUVVJj?=
 =?utf-8?B?a2pDelRZRnFKUGNmVHl2ZjNIUkdydVlSem16L3QyWXB3ekxzN0xCczhoS0ZR?=
 =?utf-8?B?OWZnMWszVXhyMDZWRFhPZVkvZll4UEl6OW1PdTE1ZWI5M3hhNzJYYWUxWlZr?=
 =?utf-8?B?YkxneENSZWJhb2JWUitwTHV0WUxpa2lpSmJxSCtJSERGcGxyWnVkUFlMY0Nl?=
 =?utf-8?B?cTV3Z2o2bnd0TENuRHM5anZmQ2tpcDk0V012WnFVUVc4Z2NhSEYxMG1ock0v?=
 =?utf-8?B?Vi9seStsMmtRZHJFUlJsZnBlenBDS3lBeGxGWXJ6QmtlcHUweU02THNTZER1?=
 =?utf-8?B?ZVhvWk0yRDNlNHdsdTIreTdiN2R4OWhicTU5bFJxVDhHaU96OW9xUCtBUzhN?=
 =?utf-8?B?ejNJN0hGT1VhRTRaV1daZ3N3U2hUSEhjdW1tQnVCb2hReW5heFY5c2tlOWkx?=
 =?utf-8?B?L0JveCt0Zk9qaHhPM0lHRnpsQ2RzQzFadXZJMjVLMFdSZnozV1JrTGsvSFRu?=
 =?utf-8?B?dzgxMXBmRWNKSzJOSXlBNnhjOWhxMHFHd2ZGcllLWjRNNWN6ZVZZbTk3TzE1?=
 =?utf-8?B?U1FFeXJyUXhIbTdOUVZsRHhyZXppZzNsclRTaTFHdVhiNmtkZjVYODhQdFB1?=
 =?utf-8?B?a1NsR3lUOFdQUEh0TzV5ZWsrdmtScG5ZcG1jbDlCTC92M09SQUtseE1YNWsy?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6979e8-452b-4366-0ee9-08dbc5bd219e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 16:07:10.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PALAC/Dm2FWyrUwrS4PH0Hy0YQQynHt+b/4waQaGYBVKcpI9m/nWuANVVCaV/j4CuzCFDAr4zVk/5QuQOoCitRigPKqEnVQKKl3KWsManYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7204
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/4/2023 5:28 PM, Jakub Kicinski wrote:
> On Tue,  3 Oct 2023 15:36:08 -0700 Tony Nguyen wrote:
>> This series contains updates to i40e and iavf drivers.
>>
>> Yajun Deng aligns reporting of buffer exhaustion statistics to follow
>> documentation for i40e.
>>
>> Jake removes undesired 'inline' from functions in iavf.
>> ---
>> v2:
>> - Drop, previous patch 3, as a better solution [1] is upcoming [2]
> 
> Ah, here it is. Maybe it'd be safer not to change the title of
> the cover letter for v2? Sooner or later it may trip some jet
> lagged netdev maintainer if patchwork doesn't recognize v2
> and auto-supersede v1 ;)

Ack. Will keep the titles (date) on cover letter consistent through 
revisions.

Thanks,
Tony

