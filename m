Return-Path: <netdev+bounces-44073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856EF7D5FDC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 04:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42ABB21097
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF41C14;
	Wed, 25 Oct 2023 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkMXkTBY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857691C0F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 02:20:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA7C10E9
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698200418; x=1729736418;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8yhNLDzvTaYx6PLIQr6W0DfdMp0tS0cw/kcgLuf8QcY=;
  b=YkMXkTBYhIh/OlYp7cycAbvuPEfpWPUlrNzxNZuFCN0v6Dzl9xuAHf+l
   QFjUQgSboeZ9o3Z6e1K0Z7OnUJhQkZfTFTNxyeisey4CSadKIftNX8MHD
   ZiAGxHfw7daRUzbQBZa5Wr1246v8n97TUFvoiwUuyjrwyqBebPRUOZUzd
   3SviPc0GEcxp2AvxJmrYQE3LQye3EhPAf/yFXGDrNR3HG1lXif+tBUzVs
   KusU4Mt9gcPapKFstbVNvx6q247LQII501rjiBqBrTbnYy3bxpSd7NqXz
   zvHxDO0kznm1yirYW0al2q7OZSupgF5W8ykrtIM7knPZ3FRYbwgfeOL87
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="377589558"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="377589558"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 19:20:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="758709553"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="758709553"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 19:20:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:20:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 19:20:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 19:20:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 19:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNThR/cKZfgl0zKNEVUHMLqY8BYEaoMJnmJ95GQl6CiOH0VkT1/a35rJa4gQf6OzVIAIPzTj0vz/rBULocRFBftr3bhzcI3rFOzMiPK5hFa8+p8vQeiVaX8V/4pyTyNcYqlG0oSEzBear5iiyJ+lIatw4zijarz3U4kf3aRCG6nzgr5pGZwStNO50oEwaXBweMTT9TthBo3GBisBrVViIBJbg8k41M1jvqWxPELQHz/6Ht75araR1z64uBV2wVqUG8Baciuh9nXg3LqdbjrO75hhsIbJxdmbH0Bf7/dOpmaF3esoaYk2kVzY0yD/CHy/rp4Y3dZrrWRZWdmNogDwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPbH+KIPgQ2wy4tcY4FTnfpM1Rj+97LJK6Tmqizj6yE=;
 b=KXndy6i+kuz7OK4ZF6z0oRocwuaPSOAxJlu5wOVk+mSVemc1oUwVY69EwNxxrXBQdIrpSkUFo5xrm0/PWSVD+JBxr12pPhqEW0t0CLv6SaF8jdlnSVgJry0Xf2A6143NaB/2WNYO+1Ua1kpur+YRdTD0DX0ureY+kg+gZ6iNAh8eN31+YfwAHR3GV/neCKU4RwbhewBovPv+wEZInXgpb4BhcKLulSRtfLRI27WGRyBHEFsddfKIvChTzaGy6Ly18H29hE9wHquBCw1u/X0Zabaxqrvip1oZfcC58dnCI0W1jdV2/BhM0Ut1HY8ub4kzZspCXFfXDSATtJ1iIpqQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 02:20:09 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:20:08 +0000
Message-ID: <6fa3830c-d3fe-4ad9-8bd4-6342906b2537@intel.com>
Date: Tue, 24 Oct 2023 19:20:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v6 05/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sridhar.samudrala@intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
 <169811122484.59034.10508076727191737109.stgit@anambiarhost.jf.intel.com>
 <20231024154731.32056d00@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231024154731.32056d00@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM8PR11MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b72f2e-00fb-41f5-877c-08dbd500e8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kt7aYIYO4KswOQEQvFXf8mHci//Wn428Es/HEwsgsBfTZNnHlNPZlcYfHkSrUp5fZJwURQuTWkQMbNlyspgKAVL9FDHAX6cUyrq0IVa39TEaZQWCx9xt8ip5xJdfrkIUcUFHrS8oQHkGyrVz9raGOWflioHuqNu3bY7dzV2PzImsO6XwxNBUvC1IBDpK38DekEgI9df6hxA/rk2Xqk14hm/ra3veZ/n2TXMczBH5JC9349gUiW7f9jidLc2fcCFoV0WcnOnpCYU7dy6jqBn01QXAxQbZ4zvIERfZLsEWvZeHqDylsMpDzGMu4FJGaWtDGu/wyjky8koNHeN16ME02EyPXdLlDTUk/xy9TU1+5jPeCyICRVbt/GqUEwqOONYoHf82DnDXHgwpEO9y4iYIieSc8V8MMGUfVh5d4eF0mbEM3NqTF0D381RfyWmal5RFJj1bvMILJjm3CgFZH20UpJSKeLJJlcevT/iFEIqjeZKBS/YSBtscw2Ssf4NFeAb5HBtN7jz9HYROILYaTw4tLDNdFMD+dlllk+SKRv775vTTkvMNA4xBjmPaMehoSPHUmY1VPfvtoFf4Y+tUtPr1YbFg2wL70XNdfS2r0E+fNUyLdRmOUeO0BVlaQ4+FPBV+DXUdzKxqqvm0Flzy2WxFWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(5660300002)(86362001)(41300700001)(66556008)(66476007)(478600001)(316002)(6916009)(6506007)(31696002)(6486002)(6512007)(66946007)(36756003)(8936002)(4326008)(4744005)(2906002)(2616005)(53546011)(38100700002)(107886003)(8676002)(26005)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODg2bHJQTjhqWEN5VmhNc1JLbHd1VXBnSnA1aG5yWm1PMiswdTk4YkI4aEE4?=
 =?utf-8?B?UHUxWlZXU2R2aS92RFgzYjRPSFphTmhYRXZnSkZWSW8rckNPbkIvZWRpaXJY?=
 =?utf-8?B?SHQwZ0MxVVQvQUdIWkgzNU02YkdtNmUzSGJRYlg4UUtTdElTbU5aWXRpMnlV?=
 =?utf-8?B?R2pKVUw0cUtVbEJQTmpDRXA1MGdqbnd6R0JZcEREb05qTmhUR1laaFpVdGEy?=
 =?utf-8?B?Wm12bDBubzI5bVREWGcwaHIzM0poVWFTNUxXZEZ0TnRKUUptU0tUQ1BCd1My?=
 =?utf-8?B?eGdGcmEwYUR2K1BhSWdHWGNMZ0hRbDhYaVB6d2JOSWV5enJ4cUpmWG9iRkFC?=
 =?utf-8?B?RUU3Sk1JU3ErNzJJSzlRUDRkazVRQjA0VmIvK2ZaSGhMZ253ZVQ1bzNWR0hx?=
 =?utf-8?B?TGlueWpqZndwV0xNWGh0WFk5TmozdGViaWdMOVl2aTIzbGUwY3lpeXpxZ2xM?=
 =?utf-8?B?SGc3VGFhRmxIYWlFM3dCZWwxRXBid0VRU1VkWDJKd3RzdDVSbjM0bFk3RWto?=
 =?utf-8?B?WUNFKy9GTjRJZUNPTmlIT1VJZm9mRGhZRVh1SUVuTytSMUt6Vm1MdHBhVUhO?=
 =?utf-8?B?b1Zuby9Zeng1bTBUbkhrMHJnWVptRFI0WWtXazRJQjQ5T0NEYzBGeHo5WVBT?=
 =?utf-8?B?WHRsQlJiVEs3QkdpdWJ4dE8wdUVQVGt4YVYrcUZKOEt0QkNDdTIwb1Jjem1J?=
 =?utf-8?B?OUZxZGRVWnU1WWd5bHh0d0NQcGp5dEFRcHJwN2JLR2UvSW5ZVzJmcmtZTkEr?=
 =?utf-8?B?MVpsTWQyTHN3Z3loemVvdHN5WDB3bkw1cjlnM3d2WjltNXhWaU12cG0xc210?=
 =?utf-8?B?aUF2RFphWStncHd5RXJad05pUHpvcktyS0cweDl1emtHQXBvd216dGJUVGNp?=
 =?utf-8?B?aENLT28vR1R6YlNYcTZWRzNlZm1sUFI4VzZkOEZvK1lFckl6cXZqWFVlV3pZ?=
 =?utf-8?B?SWltamtDY0w0MGFyTUUxVE5kZmdTcnIyVEVhUmlaa1FNNXlwWUt2UFlycXZo?=
 =?utf-8?B?azF3Q3N6bG9kNVkwZWsxN1V5NndZTlR3dnJMY0llTTU2OXRIdUVOdzZsSncw?=
 =?utf-8?B?eHJlWm9kYmh0NE4wVTVhbkhlK0JJVzVtZXF4R2U1SlhXbkRHYldpY1ZadFUz?=
 =?utf-8?B?WEswdldFcUFWYm1TcXZvZFlFKzF6ZllneXg5QWtiNVdRQzVkMmI3U2FiVUZY?=
 =?utf-8?B?bnNKbG02SDhhYUhnMzQ3SUI4ZGVXa0xkRENTY0lVMUZjMHQwSWd3aU4vZ1pI?=
 =?utf-8?B?ZHlDVjVyaEdZME11elVLdHZqT2k5QXVXRHZxZWxvQWZXWWJxQjhiSXJleXo5?=
 =?utf-8?B?OEE5b2xPbFV4amJyaDFEb1FNSGpWc3pqc0dhQkkwaEZjSnlJSGhTQkdlRkkr?=
 =?utf-8?B?blVGS1JWbFIyUjBtbGJCS1JiS3ZWajZ6ZHp1SmJ5Q2hnaFMxbVVrNlljSGEv?=
 =?utf-8?B?UnV0OVRnVWM3dGUrS3VuZDM1Ymhnb3N3ZnpRc2hleE82MkpEbStOS3YzelND?=
 =?utf-8?B?STBIU2tXcWo3RHB0OS8xOXdsejZObXpyeTZIbTg2Z3FyMysvMlBxRCtIaTRm?=
 =?utf-8?B?QzY4MW5YMm9zQ214aERDVFBneWk5Z01pM3piVkoxTmVxb0dVU1kraTBVRzY1?=
 =?utf-8?B?MnllT29aRW9SbUpQdjZsVmtEMGhWWTNWQmdxZm5WZVcvWi8yazd3YlhRb2N5?=
 =?utf-8?B?enA4L0hvRzA3S1NFUGt0Y0FMcWZjTFE3QlNLelRHOWJ3amFuVWJNaVZCdFRy?=
 =?utf-8?B?Ymg1emRQZUYrN0loNzhnOEFpRWJ5eGFoRGRmelJwKzU2Q2RpU2txcWVTdWtV?=
 =?utf-8?B?ZS9Vbnk5MjFXUXJhUzhNU0pwQ25wR3Q2aExqRDZEUEhYem8wQkdJZzF2MlZW?=
 =?utf-8?B?YmwrdVUrQ21GUWw0d0hrVVN1Rys2MjAvcm9lUHV1bDRJNk82dGJCSFVadlNy?=
 =?utf-8?B?bnN6cUkxWjc4VkRZTnZPaC9XNXJ5eERLWFVIek5SWFZhZ25JRWhhS1BKTE16?=
 =?utf-8?B?ZTV1K0huTkFSNEVpUW00YXVpN1gvQ3B3QWE4dGxKZm1aazE0V3dNMWVyQkFN?=
 =?utf-8?B?c3Z6d3V1NUEvb2p6OUZvRFF1Yk9FTkdEZWRxQzBNU0FxRW9IenljeVQvb2c1?=
 =?utf-8?B?TGJueGZiN2o1K2NQTi91eml0TjIwMWdQaytaWjF6emhrU1dWc1JoUzAwMFJQ?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b72f2e-00fb-41f5-877c-08dbd500e8e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:20:08.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvqnBgOh8cmX6wSn6vwm7njerb+FjbQaUPm5D1CZVpP9PF9cOqBboo3i//b4e+SaTI7Ui4i2/vaOEPKW/WlPveEWuk8fmXyPdMBPeGu9yY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-OriginatorOrg: intel.com

On 10/24/2023 3:47 PM, Jakub Kicinski wrote:
> On Mon, 23 Oct 2023 18:33:44 -0700 Amritha Nambiar wrote:
>> +    name: napi
>> +    attributes:
>> +      -
>> +        name: ifindex
>> +        doc: netdev ifindex
> 
> ifindex of the netdevice to which NAPI instance belongs.
> 

Will fix all this in v7.


>> +        type: u32
>> +        checks:
>> +          min: 1
>> +      -
>> +        name: napi-id
>> +        doc: napi id
> 
> ID of the NAPI instance.
> 
>> +        type: u32
>>     -
>>       name: queue
>>       attributes:
>> @@ -168,6 +181,23 @@ operations:
>>             attributes:
>>               - ifindex
>>           reply: *queue-get-op
>> +    -
>> +      name: napi-get
>> +      doc: napi information such as napi-id
> 
> Get information about NAPI instances configured on the system.

