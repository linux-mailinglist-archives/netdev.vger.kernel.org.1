Return-Path: <netdev+bounces-26205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96D77729A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8CB1C203A5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA05E1ADF6;
	Thu, 10 Aug 2023 08:15:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7A3366
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:15:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E832BE56
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691655299; x=1723191299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MaOc/yfsCVRJpizwgFzxXxXg/cQyeh+2GudzA5cyzi8=;
  b=ASGxFpzdZUCb6ip7XxDTpwdMOH307BPTOaug4Vb/z5oZYejFykDA5oPH
   VX80tNey1+Krr8RCgeHBnHwnRIebvshWYszs3YMPJVdeHoSgziNhHBwAA
   JAkANZoyUKnz+h2rU2CsrhfCmhhISUBH/qf/RlB/IprjA2q7WCMFsUR9X
   FXT7qX6eh9Lt3OF2fObUBvA7wD3x6AGqqPMJQJ8rW1d18uSlQNHLO58Qd
   B5FxyVqbdcIfy6oTefxFABvW0I0x/yqCs9wOCeN5YgXLsKU6DPv7WFIse
   v+ISN4uFd7J1t6rzO8/HviVMXeGEMBiNyhmjnfkgAm/iRkzUNc3K7+Ebi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368791795"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="368791795"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 01:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="978703104"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="978703104"
Received: from auscilow-mobl.ger.corp.intel.com (HELO [10.249.145.242]) ([10.249.145.242])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 01:14:57 -0700
Message-ID: <7ca422d4-412d-8e26-c25b-eb897898e2fe@linux.intel.com>
Date: Thu, 10 Aug 2023 10:14:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH iwl-net v2] ice: Block switchdev mode when ADQ is active
 and vice versa
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, "Ertman, David M"
 <david.m.ertman@intel.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, jiri@resnulli.us,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20230804142654.9729-1-marcin.szycik@linux.intel.com>
 <4e8adb44-1f75-6c46-d7e9-a8ea5f3921fd@intel.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <4e8adb44-1f75-6c46-d7e9-a8ea5f3921fd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 08.08.2023 19:55, Tony Nguyen wrote:
> On 8/4/2023 7:26 AM, Marcin Szycik wrote:
>> ADQ and switchdev are not supported simultaneously. Enabling both at the
>> same time can result in nullptr dereference.
>>
>> To prevent this, check if ADQ is active when changing devlink mode to
>> switchdev mode, and check if switchdev is active when enabling ADQ.
>>
>> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
> 
> ...
> 
>> @@ -8834,6 +8834,12 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
>>               }
>>           }
>>   +        if (ice_is_eswitch_mode_switchdev(pf)) {
>> +            netdev_err(netdev, "TC MQPRIO offload not supported, switchdev is enabled\n");
>> +            err = -EOPNOTSUPP;
>> +            goto adev_unlock;
> 
> Does this need to be checked under adev locks?

It doesn't. I'll move it above.

> 
>> +        }
>> +
>>           /* setup traffic classifier for receive side */
>>           mutex_lock(&pf->tc_mutex);
>>           err = ice_setup_tc_mqprio_qdisc(netdev, type_data);

Thank you for reviewing!
Marcin

