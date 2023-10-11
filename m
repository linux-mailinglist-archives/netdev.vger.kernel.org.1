Return-Path: <netdev+bounces-40190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798117C6145
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4931C209B0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4CE2B769;
	Wed, 11 Oct 2023 23:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+Hrf+ml"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987642375C
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:54:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4FCB7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697068449; x=1728604449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wvq8QnrI4xOiRXBHKbAb5WfuuDv185ZApqDwK80irX8=;
  b=h+Hrf+ml3vOOJd1z1xW2Z/O/T3EC/W0rOeJ5oQAYqnWsj2l6cMFe0pBO
   jbiyAvN32yMMa7OJ446YLOBfKOehDg7piChjMaJBDpL8DY7+UC8tBj3DM
   0NYKtDTi5PSZCBKjANUTIKX4lmkvd/UjZlNtGIMOImqv/jUBIPaiKKJ8v
   JGgN/58HTdAprKwio4kSzG96zEaqT+XwqQz2tBcGwIV6HCStmR2QBllMy
   DEj3EJwVCK5yYCAu8aliJVNRUJhQ0Hwy2y6zddYjD+EXUh0R3nw/RgEzo
   Lp+wzswNC4brs9voUv5+W8l8vkaFst6k/IF7mIJCF9+fcnbgEtIOcKBMt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369864844"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="369864844"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="703932444"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="703932444"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 16:54:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 16:54:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 16:54:08 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 16:54:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHx7RW4sqXI7dJQmqk+KYYkb/f4JMh0pgXkL0grJYq2iXMcoMPA4EUoQ54qokxhjrErqA/OycnZq6XdEChe/aFv0Peo5KUqb2dnV/s6esj/OUOZn8Ts4NaerggY2xWhATvpj5lETC7bdcsD01PczLglgSZvk2doN/nCHjuXa366bAE2zuF5bepnff+/10L8Cg3c/gHbE8rNN/s/8h1qKgwd0Qd5badS3z/bH++djV7Bxdvyo4k03OPFaJJtSDn3A3aX0wjqaUSIvzNu4hDdhGMRY9h2Jn/SVD5bJr1UgL4d+pCP8i6ylYeYo91O10o299/ydH6yclVeTBEFMcRa8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fleTGVqWBi2dH7WIrEJzFy5j2lG5iS+SSRRnDG2kqek=;
 b=ds60aTlDL8AYj2EmIFjacnUuzS+aNR0YuHLGos2rdij4Y90nHmQzDKc9p1F9YqjNGMrdlyHixHFNzjC68nveTnqh/uGWEVs32F+/1mHCxInBwdwsablfPTZWufG+LHEg3esPbtubKTkhbbhI8AGEAM6D9+z/VS/TopWaTx6lL8xk4PtGSzmlhK2vHOMYv+ieghai6EgJujbZE0+NxAxCuB9oiMsUFvs7cow7XOl4gx81PNNa0s38mIFSIphjYFYEwOF2e2sGHb45EkrZvE66TBaMzGWTODpZSDFV/YeNQWwu5DDC4pa8pZGghcyp5EXtbRVeJ7n2jzLRUfMe+HoWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DS7PR11MB7886.namprd11.prod.outlook.com (2603:10b6:8:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 23:54:05 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 23:54:05 +0000
Message-ID: <fe26f9b6-ff3d-441d-887d-9f65d44f06d0@intel.com>
Date: Wed, 11 Oct 2023 16:54:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 04/10] netdev-genl: Add netlink framework
 functions for queue
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
 <169658369951.3683.3529038539593903265.stgit@anambiarhost.jf.intel.com>
 <20231010192555.3126ca42@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231010192555.3126ca42@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::27) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DS7PR11MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df3257a-0c91-4eac-efb2-08dbcab55947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9GJ7y6iG+B840qmGgq2anH1LtaZKBF7rGcG+w89HDFv0Rk5w4fhsJRzN1Df7cZ+YQy61RhRSzkwnrc6J/NjjBu6DEhrukme6vlXRIbcJDNFm0zXOncK20UkV1uF4ecgqcWRkviCsIV+nzZSBEIq2eeqWhtYSX8a83lK/r63HxFcN46wFNb3rCnbC7i/ENd2emMgUr6Wz1CTXuux+NxQMSqBOif9TDhXpt/y7kdiVh+VSgCZgs0x1oHSwE6FY7YRzlp7KstokisD8dhI1TuFw1qBNzQ+zRcXeLTdkO4Y2WDVA6rZTRkvb+DcaL5bJlFgFTYsFwkpYGSNA/+TjtNRRsBbybtX6pwxyI/A4pSYRkG3IEeySgSzM2LX/Gdkh6QVP5lBhg82GLybHkwr9jEZO1vDsh2nULxz7kGFdqqLotqwunoG2x1WZjKl/r24Ds+ZHLkUXOfzrqQr7OQYWG10uNmvtrqHMGRe2Cm+Doa1tTEqLCPOfT7Dwz86eOdlI6TJL1w+6ISTrvGTWysF+Kmc6cOgkYi+Po7lmHlJ6f1GPvIaO9vA4RwciANfj63eLe4ACHKq1cvKc3Mc/sIDxcv9Y6PJP6Y7wDQ6sIqUYhn7GIuJ6L+nroYEI1VPCCHWQ+Mc1WPFdQixcIewGXMROqR+YA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(53546011)(6506007)(38100700002)(107886003)(2616005)(6512007)(41300700001)(26005)(82960400001)(66556008)(36756003)(31696002)(6916009)(86362001)(66476007)(66946007)(316002)(5660300002)(4326008)(2906002)(8936002)(8676002)(83380400001)(31686004)(478600001)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNMQnpGODNka3ludndEUEsrOUR4K3phemxrR3p3bHAyUTBUM0hLU1BneWE1?=
 =?utf-8?B?c014SWdQQU1qQXpjSy9BV3plZGdzVzJyYjIxRHdKcHE5YytpQi9LTFFEVmRn?=
 =?utf-8?B?YVNjWWVod21vMG5yTm1jZVk4aFlBa05UeWtLZVMwbkpUeEhtcVRraVJLckhW?=
 =?utf-8?B?R091MUdud3R5K21RK09TNmM4RktNRzV3Z3JJM29IczdmNUZORXpFUnA5WWhs?=
 =?utf-8?B?WWNGOVpPcmc2UXhxbVBPN0dXVk43UUdQUngxcVFORCs3RklMN09YV0hrTHM3?=
 =?utf-8?B?T08wajB6VEJBY1BLNUVhMjdhTFltaktqTFpDaDAxbDRYcVpkTkFKYVVEVmpN?=
 =?utf-8?B?SytHOEp4SEdHL3FnOFU4TjVnYWpQRzdGZFBuejNEN1VTZzdKaWtjOE9JZUNI?=
 =?utf-8?B?aE05cmQ4dHphcks4ajI1T0FoakVsclVYY3BUcXdJaUc4UlNxYURST3dKNVQw?=
 =?utf-8?B?em5LUWVQVXJTTUFGWnArSzVzY2k4Nk1wUDVRbFpnN2txMGxET3dSZmhkTWZo?=
 =?utf-8?B?RkRwcFhHZ3ZLenJ4WDNmNDNLb2lMK2xqSFJyMzBJQlBnaEkxLzZaWFd2YmZw?=
 =?utf-8?B?MnJOTUJtZ3ZHQzUyekVqNTVGbDlwTUI0bFBqR1UrVGsvNGRuUk4zQTJpWnNv?=
 =?utf-8?B?UzFqVkJFazROeEVrVXVnNWFRSHNQcWN2RmlvdmdBUmhhZU4yWXlBbDhxd21I?=
 =?utf-8?B?Z05GTFcrTGU0a0lBZktGUnNvS0VvalduU1piQ1l1ajhvVjlXdGxGOW16WDdk?=
 =?utf-8?B?UklwQjdMdFhoUThTcSt0aEl1WTBZZ1loSGs2TzF4aWIxN2hFQTRMMzJYYXVM?=
 =?utf-8?B?YlpGM25oVHpEcUF5cEUwdUNDN0l2VWtmbXJvaWFQd2dHM2x0cCtqMnEySURT?=
 =?utf-8?B?azV3bFdHU05IcmhubFVpL3pVUEcyTDIzOVFiUldwMUU1Z05ETjBKcDNuZ1ZS?=
 =?utf-8?B?K0J2d0RuU3dJb1J5VnhWL0lvNDBBbU9RVFlXTCt6dTFLNFQreDM0ZUhpcEdj?=
 =?utf-8?B?Q1k0TWdLa1hVL3gwRVg3VEptcEdOYlRHUGEyNU83NFR5NEkreEZFdHRsNzdH?=
 =?utf-8?B?d2hlR09DNWk1Y05kNzN1MEV5SGNUKys1bzdNR0ZFYlVoWXl1K3piK0FKVTBJ?=
 =?utf-8?B?eEd1cFhHWjVPMVBIdTNFSUJqWjhDeFFrczRkaWF6YzZwcXJQbkxIUlJlNmdq?=
 =?utf-8?B?cU1FcC9YZzR3ak52YkhGTTkyd2k3bW1GMXR3SU55eFREK1FPc2NiOFFYaEdV?=
 =?utf-8?B?OUZIOEh2eTdCcjV5WUsyK3NCbHIyZWFKaUpxOTFFWG1kNS9kdmUwSmFZWGpr?=
 =?utf-8?B?UFNmNFBzc1lmd3NxdDFjcm5ybCtZWjRGRzRhMGp0ajZvTlNDZlJjVldXaTNh?=
 =?utf-8?B?eUsyY2xLbFlkZkRlMDRzY0tRSWZOTXBQMFFvNUp4elJjYVUvUnBTWUJJdE5y?=
 =?utf-8?B?T2lGT3EzbG93QUczbXNsa0J6ckhHWXErenVCOFJTZm95ckF4RHBSQVYwR0FL?=
 =?utf-8?B?MHIrRnBFQzhzMjZleFFPSFFsN3liRmdMd2VtMmRoeC96S1RPOGRQZXlVZlV3?=
 =?utf-8?B?RXpEUFF5RmVXam51aE4rWnRPaDQ3QWk2eDk0MmNwNEtnZWVyaWwySzVNTmM0?=
 =?utf-8?B?aFdFdHQyUnNYa1JPYi9DbVQwMXdGWFFiMWVkRFJxdDUxaStEOWttY20vbmFi?=
 =?utf-8?B?VUdUVmFhOHB6Z3o0ek45ejhTTUJBbUdaK3JHWW9NaGpYWHR4eVVMWFk0NjJn?=
 =?utf-8?B?L0RUYnFZNW96RTFWRTZjalFrcFcveWdpRjBGT2xVZUdhTjJiLzNMRGxQVUZH?=
 =?utf-8?B?U2RCOFFuVStQWHR0eGdFSjlScVBNMEJtZC80TG5GNFBDNHN1RWhGNkpnKy9O?=
 =?utf-8?B?cEhsQlVaMUhXbGpCOUV3dWduVXlTNlF0cDdBdWV0NHgwSG5IWFEzUE04UEVS?=
 =?utf-8?B?T0tNbjZQSktnd1pNZ1NnMUdvbFpHczhPSXNkb1JFZlloNUtIMEgrTGFLNFFJ?=
 =?utf-8?B?K0ZDMjFHaTA3dFdCclNPZkl6Nm5aOXJwZlREczRoN3JEV1ZRbTI1TU1iTFdq?=
 =?utf-8?B?aHFJOVNRMGt5QjNLdFBPNDZ2REdhS0JGSUo2YnE2NU1iSm5aNnJEQmFSSm9U?=
 =?utf-8?B?OXdnVjN2RnVHYW1WNTNuM1lVSFU5eGxnK3hjS2tpdjNqRUQxUU5iUkdhb1Vn?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df3257a-0c91-4eac-efb2-08dbcab55947
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:54:04.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJznmwzduyvO/p+00Agh9NIMsgPqUdio6QVzfZ9hM5i2hG7c9lAonG+h3JNKcUn/k1O/V22k3sMTDEK7c05FK89K3BuqpR7xFwb3JRbosy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/10/2023 7:25 PM, Jakub Kicinski wrote:
> On Fri, 06 Oct 2023 02:14:59 -0700 Amritha Nambiar wrote:
>> +static int
>> +netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>> +			 u32 q_idx, u32 q_type, const struct genl_info *info)
>> +{
>> +	struct netdev_rx_queue *rxq;
>> +	struct netdev_queue *txq;
>> +	void *hdr;
>> +
>> +	hdr = genlmsg_iput(rsp, info);
>> +	if (!hdr)
>> +		return -EMSGSIZE;
>> +
>> +	if (nla_put_u32(rsp, NETDEV_A_QUEUE_QUEUE_ID, q_idx))
>> +		goto nla_put_failure;
>> +
>> +	if (nla_put_u32(rsp, NETDEV_A_QUEUE_QUEUE_TYPE, q_type))
>> +		goto nla_put_failure;
>> +
>> +	if (nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
>> +		goto nla_put_failure;
> 
> You can combine these ifs in a single one using ||
> 
Okay, will fix in v5.

>> +	switch (q_type) {
>> +	case NETDEV_QUEUE_TYPE_RX:
>> +		rxq = __netif_get_rx_queue(netdev, q_idx);
>> +		if (rxq->napi && nla_put_u32(rsp, NETDEV_A_QUEUE_NAPI_ID,
> 
>> +static int netdev_nl_queue_validate(struct net_device *netdev, u32 q_id,
>> +				    u32 q_type)
>> +{
>> +	switch (q_type) {
>> +	case NETDEV_QUEUE_TYPE_RX:
>> +		if (q_id >= netdev->real_num_rx_queues)
>> +			return -EINVAL;
>> +		return 0;
>> +	case NETDEV_QUEUE_TYPE_TX:
>> +		if (q_id >= netdev->real_num_tx_queues)
>> +			return -EINVAL;
>> +		return 0;
>> +	default:
>> +		return -EOPNOTSUPP;
> 
> Doesn't the netlink policy prevent this already?

For this, should I be using "checks: max:" as an attribute property for 
the 'queue-id' attribute in the yaml. If so, not sure how I can give a 
custom value (not hard-coded) for max.
Or should I include a pre-doit hook.

> 
>> +	}
>> +}
> 
>>   int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	u32 q_id, q_type, ifindex;
>> +	struct net_device *netdev;
>> +	struct sk_buff *rsp;
>> +	int err;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_QUEUE_ID))
>> +		return -EINVAL;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_QUEUE_TYPE))
>> +		return -EINVAL;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
>> +		return -EINVAL;
> 
> You can combine these checks in a single if using ||

Will fix in v5.

> 
>> +	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_QUEUE_ID]);
>> +
>> +	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_QUEUE_TYPE]);
>> +
>> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> 
> No need for the empty lines between these.

Will fix.

> 
>> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> +	if (!rsp)
>> +		return -ENOMEM;
>> +
>> +	rtnl_lock();
>> +
>> +	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
>> +	if (netdev)
>> +		err  = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> 
> double space after =

Will fix.

> 
>> +	else
>> +		err = -ENODEV;
>> +
>> +	rtnl_unlock();
>> +
>> +	if (err)
>> +		goto err_free_msg;
>> +
>> +	return genlmsg_reply(rsp, info);
>> +
>> +err_free_msg:
>> +	nlmsg_free(rsp);
>> +	return err;
>> +}
>> +
>> +static int
>> +netdev_nl_queue_dump_one(struct net_device *netdev, struct sk_buff *rsp,
>> +			 const struct genl_info *info, unsigned int *start_rx,
>> +			 unsigned int *start_tx)
>> +{
> 
> Hm. Not sure why you don't operate directly on ctx here.
> Why pass the indexes by pointer individually?
> 

Makes sense. Will fix in v5.

>> +	int err = 0;
>> +	int i;
>> +
>> +	for (i = *start_rx; i < netdev->real_num_rx_queues;) {
>> +		err = netdev_nl_queue_fill_one(rsp, netdev, i,
>> +					       NETDEV_QUEUE_TYPE_RX, info);
>> +		if (err)
>> +			goto out_err;
> 
> return, no need to goto if all it does is returns

Will fix.

> 
>> +		*start_rx = i++;
>> +	}
>> +	for (i = *start_tx; i < netdev->real_num_tx_queues;) {
>> +		err = netdev_nl_queue_fill_one(rsp, netdev, i,
>> +					       NETDEV_QUEUE_TYPE_TX, info);
>> +		if (err)
>> +			goto out_err;
>> +		*start_tx = i++;
>> +	}
>> +out_err:
>> +	return err;
>>   }
>>   
>>   int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
>> +	const struct genl_info *info = genl_info_dump(cb);
>> +	struct net *net = sock_net(skb->sk);
>> +	unsigned int rxq_idx = ctx->rxq_idx;
>> +	unsigned int txq_idx = ctx->txq_idx;
>> +	struct net_device *netdev;
>> +	u32 ifindex = 0;
>> +	int err = 0;
>> +
>> +	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
>> +		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
>> +
>> +	rtnl_lock();
>> +	if (ifindex) {
>> +		netdev = __dev_get_by_index(net, ifindex);
>> +		if (netdev)
>> +			err = netdev_nl_queue_dump_one(netdev, skb, info,
>> +						       &rxq_idx, &txq_idx);
>> +		else
>> +			err = -ENODEV;
>> +	} else {
>> +		for_each_netdev_dump(net, netdev, ctx->ifindex) {
>> +			err = netdev_nl_queue_dump_one(netdev, skb, info,
>> +						       &rxq_idx, &txq_idx);
>> +
> 
> unnecessary new line

Will fix.

> 
>> +			if (err < 0)
>> +				break;
>> +			if (!err) {
> 
> it only returns 0 or negative errno, doesn't it?
> 
Will fix in v5.

>> +				rxq_idx = 0;
>> +				txq_idx = 0;
>> +			}
>> +		}
>> +	}
>> +	rtnl_unlock();
>> +
>> +	if (err != -EMSGSIZE)
>> +		return err;
>> +
>> +	ctx->rxq_idx = rxq_idx;
>> +	ctx->txq_idx = txq_idx;
>> +	return skb->len;
>>   }
>>   
>>   static int netdev_genl_netdevice_event(struct notifier_block *nb,
>>
> 
> 

