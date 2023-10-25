Return-Path: <netdev+bounces-44074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19FB7D5FF0
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C281C20DB9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0A1C39;
	Wed, 25 Oct 2023 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzxmGA3C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A691FD1
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:25:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA5B10DE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698200735; x=1729736735;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j7eZvJ0G/kxsaGXTDQ8bGHdZ6honYOdop/fHKivv7Ww=;
  b=kzxmGA3CCIBmMHv/sunSp6FiVZff4dz6svQcWv8boxhPWr4DNZXv+Vzm
   AjUPqTZOLwSUUXzpjvIzL+jl+iehnHOSMYbUX0Q9NgkvzfSo/Cj+fA36E
   hgH31LjO/aJtF1NelHUIRGOSxAu5TekuCzmvcwBZfQLWXlMsq7b3FoAjb
   J9cKkIK/66/d8n7qxklukbzCxd8vGXRQuHTL7ccx1s14pC1HeF+RKGiAl
   SQ+dGLt3gVtuQxHnForYOa+K6IV7u9PKMWh7QQkFM8Zlk6/dzmI0v+TJr
   pkxwr9aX2toQGhxgtUiMMiM5v/wYT4KrPOhITXfETZNCIWosFNPYg3BmZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="473457909"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="473457909"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 19:25:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758710289"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="758710289"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 19:25:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:25:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 19:25:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 19:25:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mu3VqBE5YVjlDvpZmbSjHATFwln35foHlHOiMoCNaFnf+zXiVHx51l6RKtZr2c3fu31v+3G9tTwNiTrE6oTzeTX1M4og0fjaw5A1wdI9kd1Awy7BkU1ViQ0qwKVVGERRSYgyCo1ejmemgEwUEEoQ7UkOEPxhT/5nSZtx6WGQnAD8TjWR2EtpQMBNRTSD7rjEWeUJoPdev9MaBjkIRoXmkxUtK9cIwvMnr116T9ip9LX5NxRlr26nh9rPEMV4sm8HJhM8H9WM6AHQ46McToUMHQyJ0o8fyCGTxz6u6qkci9ZfRJJd5eukG4gK0JxOg/0P8LCHPK7tMK6MqpxxI6asFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1FSqCHrj2MumbJoKSkHU8DDRpA50vwW8tTYkN+/HUg=;
 b=nx76wysXGG+GvDUcIEgbbO6ieQH8IgDJvTuYjjJcMCXur6SHXp7X23wWWoa/EvCDrBrggoqmMd2JaWf0m7+/XIEJVVT85eYJWX9c/eVh0S6izEiyg8MyN9KcbbI6GMonKXGDk5h0ZADNPq5VOqWnS5B8GHtSS2umZDxZfvbfHJRFgi9T/71SFJT/7uvOGuyOxi3YK4sE4zIK2CunXaaGXDs/Y5SSy2HU1Tn5TkbqJi9LdfRxuRIhKKAIH4KJBBXeAQgRMT2I8MfkoK2b3S4VR9LBwU4qKamH0ufWLxjhFOBLsqnq+gX7KwerGMs+66u2u3IJKhcmw/SKcSRdN5FfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 02:25:31 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:25:31 +0000
Message-ID: <9b244d3a-70d2-4799-af0f-3191e802a7a8@intel.com>
Date: Tue, 24 Oct 2023 19:25:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 09/10] netdev-genl: spec: Add PID in netdev
 netlink YAML spec
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
 <169811124667.59034.10304395300563829113.stgit@anambiarhost.jf.intel.com>
 <20231024155026.3deb3ed7@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231024155026.3deb3ed7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM8PR11MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8415f877-4cee-4c6c-511c-08dbd501a914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EA70A+OG+ZjW/ThVTgTOJoRo+pIhqOgZxf/lkXvrT+quG22YwQcUSBF+GRfA1c2Y3BvnK6bbBwEO10f38HgKuXQb8n3WkafmTOFd7u50zSEzK1SRI2fAHAbxuoATBI0vju6/9Yyc/sIFrfE6BlrYXt0Erf34xV+TT6CDhp7bDBv6RKynEAVzhZlXPfYpeuPBmDT9QXKHCARP6kOPmVu5bbaLxlohVp13a7CU2IPUIJQxB2bKniwGiF/2HFZtCpHTaVpcrM0Rspd08ndTBMG/PsPuNjGrbKn4SwV6kX19ICwrKsQQfVrN9X9g9IKOrOMlIzZ3y1VZFyHrii+MMWuC2KPSo4vuzGGuD/cdyZW3IeJw7JXCyoEk5gaHy9iMeeJds1QDhzIKUCNEpHPjLKHk0WgQCDi5VZBzLM7RrcXzkJl/3FeZEHAanu5CYOxDwwlzoUH7oW3LX4X1JyCiQo4h77ZSt+OFk9eGNGbubFq5YB9dPSuCLtxD5eXCi1Svxww4FmyHT9kVbeJgK/Phu61MT4boyRk643wWR11v2gNI2cVnoEay3mbzFf/VBN8vbVF5KLfpEktHCVbu4NBDpcqVM/x+JgymbWaWioVYM7izLxRVLBy4v8GV1v8Rg7nn+C2NfqxKX+MxBX9mXtvM9+NQSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(83380400001)(5660300002)(6666004)(86362001)(41300700001)(66556008)(66476007)(478600001)(316002)(6916009)(6506007)(31696002)(6486002)(6512007)(66946007)(36756003)(8936002)(4326008)(4744005)(2906002)(2616005)(53546011)(38100700002)(107886003)(8676002)(26005)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEVXb2lRQXNzODg2UjhBVXpRV203Q3NUc0lYd3JZbEJhQVBaV0x6TTRtNGRu?=
 =?utf-8?B?bHh1YlpaT2gxMEdXZ2FUUFZOVlloc2NGR2RML1NDMGp6OVBSaDQvRjZFTUhP?=
 =?utf-8?B?RUlMZnlxTE9QSzRrSU40TExmblF0anMvb0JjS2x0bWR3cCtqeVEzVTI5enJE?=
 =?utf-8?B?cmpTZDNNMlB4NTVMQWh3cFMwdGF2SmlhdlM5Z2dCT0pTQ29nUE5NZGZLdVkw?=
 =?utf-8?B?MVVvQ0oydHdRM1NYaExPK2RDTWRrV09DMmMrVTFlOUEvdlcxMGI1bEV6cm1X?=
 =?utf-8?B?Yy8reGtmUnBhMnZzbkVHYkowSmozaHowUmtGWjBNNDZFelh1V1FSaVhueERC?=
 =?utf-8?B?aWh5VVpUZVR0bG43aGtGdkpzWXpQeVZKeWNUcm83QUNSRjdOUkE0cng3b0Za?=
 =?utf-8?B?bkFjR3JQVDJEd3dvSHpONklzK1FpY2c4TEI4VVh1T09nNWNzTm1XNGtwblN4?=
 =?utf-8?B?ZlBYd1J0RDhNQkZQMm90U1RVSzRGa2tjSWFYS1NNYzZkTjNpOE1wOVN6RXNT?=
 =?utf-8?B?Q0hNZms2dzdjTFpmSFlkSi9hMDQ2ZkNqL3U2UUM1Sm0wbWlWd2w1ZGZ6MHk4?=
 =?utf-8?B?V09LV0hVVUZIdXdtSzFzVEJPZmRWYXNLV3pwQkRLbkhiOVZaSnRBcVYzNWIv?=
 =?utf-8?B?NkNCM0RnNUl2N0JyK3k2OG5Ka3NJR2tUMEw2L3hvcXlwc2pEMGVyaldGYlVp?=
 =?utf-8?B?bS9rcGlLY1J0TDJJa3crbGErbTFNaU0rellhdC9sY3lTLzdKUHBNMXN2RUpK?=
 =?utf-8?B?QUZRY2JNZHJhU25aS0Juc3AzR0hnR2NJSGN0VFRrTlV5OElTRTB3aE5TaC9M?=
 =?utf-8?B?SzYxNkxQN0MzNlA2SWJQR0JwY0tUUlgxeTIvZjhnRDRIWUdXUXRJVmU0SmNC?=
 =?utf-8?B?eG1qNjJjSjJMK3oySzJrRGJNeVA0Tk5oalRMTW8vY1JRMXU0cXIxVDRlUFow?=
 =?utf-8?B?TTYxdUEwclZwZk5nSzdpL3RENlVvbjhON1dlRGJBdEF3SWpMVy80Mnh4QXY2?=
 =?utf-8?B?OHAzdFNjWEorcWJYNGlaZEIrMVZOcm42d3RrMURPbSt3MGdVRGtJbzh5b2Iz?=
 =?utf-8?B?Z2RMU1RiR2JQRzM1aFZlSk9rUnV0VTlTN2VLM2ZWTTN0WUxDSlJ0YktjaGZi?=
 =?utf-8?B?bUZKRzAwaVVTbGoxcHFEb0ZuanBlR0U2Wjl2aFljNGU0UHc0TytEZFduQlpo?=
 =?utf-8?B?aTlEeG9FWG56bVM1Z3p5Ry8xNmxGQ0lJcGZQek1DbW1RWk82K1FyVENwRm1U?=
 =?utf-8?B?dHBUUFl1R2JPN3hubUxwQlQ4VE5WUXFVb2xQVHhFTUNmTGtoenVVVDVlWnVr?=
 =?utf-8?B?RWlCSHpmeS94b3FNTm5KNDR1VWZWckJzajZVZ2VjYjZnQ0gyWCtIdDNGQ29u?=
 =?utf-8?B?QXpNM05FcU9nbGQ5SHErQjB0dXNVcXhCcm9Eam01Z0NGd0oydVVyRXVEeklC?=
 =?utf-8?B?YVQyK01pTndoVXRRYk5QdzlyaTFkY1F1VU9iY3dCKzBTcnc5NXRSY08zSDBh?=
 =?utf-8?B?ZEF1aUIzdWlNZUVzMzh2eXBYVVhtaHdhZ3NIZVFDUzRIcU15bUNiNG5zVDVU?=
 =?utf-8?B?Q2p2eGhVZVhaUlBiM091SmNNN3EvdkFJZkxBM01tM1VpV1hCVnFJMHRKbUtj?=
 =?utf-8?B?b3dVdjJaTnRQajN5SGF0RU1xdUNRYVo2UDFHeU13WE5oTy83VEpqM2p0OWw5?=
 =?utf-8?B?WlVKN1F6Y2hpaWhsd2ltNnlLNjJjNDgzMXlQd0gvUnQ0MVFKZXkwRjlNOXBa?=
 =?utf-8?B?T09wQzg4WDJtaHhYcG1FeUs0NXhoOVhrZnVFVEJ6amg0UzIwbEVqcjQ4R29z?=
 =?utf-8?B?TmIxSEtyc091RHFGZkkxc3BDVDZmTkZmTG5OWHZvSm4vcS9rbndBcGRzKzZI?=
 =?utf-8?B?SlhKQmlFUDkxTm1oM1ZWQ2RibmJxWXM3Vk0zVXUrWHdIcE91bVl4ZlNFWUlq?=
 =?utf-8?B?dW5YbThIb2ZUcnhjSDBMNk9BWVdIT1Z2cUk4eDhvUzNUT1JJZHNpeUVsMkJr?=
 =?utf-8?B?WUsvMjJScmNBZDBoUExYN3JZNGxiWGtDdWh3YjZFWWV3RnQyNHRRbTdjcmZE?=
 =?utf-8?B?endpSWxjL2ZINXBjWjRTVTFKZHVQWHBLRDlJc2l0bW02NGtQZXRNd3JZbTUy?=
 =?utf-8?B?VE9Hd2xEd1ZQVlZDdERnRktMa2VWYlRZNDBjY282dEl3WE5veUcreXlzdTNX?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8415f877-4cee-4c6c-511c-08dbd501a914
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:25:31.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b4hGfVyDCxyxcXWaVG8aj+8H+3Q40PAIE1pHfg1X98zqob+8LXfPeGUTHo1WXbT0MFSD0xhd3nc9VsgjkdLOzS1pPh52dLNnBPc9tXjaZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-OriginatorOrg: intel.com

On 10/24/2023 3:50 PM, Jakub Kicinski wrote:
> On Mon, 23 Oct 2023 18:34:06 -0700 Amritha Nambiar wrote:
>> +        name: pid
>> +        doc: PID of the napi thread
> 
> PID of the NAPI thread, if NAPI is configured to operate in threaded
> mode. If NAPI is not in threaded mode (i.e. uses normal softirq context)
> the attribute will be absent.
> 
>> +        type: s32
> 
> Hm. PIDs can't be negative, right? I'm guessing POSIX defines pid_t
> as signed to store errors. We can make this u32.
> 

Yes, valid PIDs are not negative, negative default PID is mostly for 
error handling (ex: a fork/clone failure). I just used s32 because of 
the POSIX definition. Will change to u32.

