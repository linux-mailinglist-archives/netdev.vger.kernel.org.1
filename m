Return-Path: <netdev+bounces-106553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48342916CD1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005FF28722D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74145978;
	Tue, 25 Jun 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/4kg/mI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F823AD
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328605; cv=none; b=A4YoZ/uwHJgN+Pbwc8on+uc6RK4WpPVD4+EIc7XqzHjrddCYOz+/gouLcQJp7u1j1D8Sf/DcvAs5T/6q4OUROz9XVkEQMiHxD7eQN9AjS4VtjwqgWrQL3jSjJTMPdhCHQNz+gWoxzp4+dHB8YQkBJcXVmof2l9UOfFnmoDCAZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328605; c=relaxed/simple;
	bh=jaRwI4LG0087Dlt9uKGeztFSXD7BSiLKVBKrHuND4UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYq9w9aa3/fga6o8d/AuSJT+nfQcOKa1/RBPF/EgrjY8z4OtT6NvFRvIQ0lZH3fBuHYMe8geXGc2xVMr1cKqktAu7fK4wRLhFjsvZ1At0Gc/4992lFPev8GA4318Vdckr8SiPO0De3MHyvQ/z7MEndYP8boyRUcRzEBEyolH87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/4kg/mI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719328603; x=1750864603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jaRwI4LG0087Dlt9uKGeztFSXD7BSiLKVBKrHuND4UY=;
  b=T/4kg/mINx/N73y2xEV8T3rDS9mbnYoxlYMhoC57UxWfyCXqxKc61u5z
   DMsYO9jzLmx9SRx5K+rCkPOOrdrfSc9oEM7d8PO08FVnTlG3lxFtEIfmd
   HFUqoAHegXK0671owiBKl/okYW27yzkndQU1LLiGqiCEc+lzSL0Vq3xm4
   1CokuCziHLxAYoG5k9MfNuLsQqd0Bc8SXfhZnNdSPr+XEowLdr+2b9nv6
   xx5oXHbHi2NnxCaFSgpwl/lqIX5V19b3HoONDk5KN8TvqFwPjno4oNZFu
   Lsbk1dD6G9WimdRpOkwJJRB4tTyqWCjs6XoxTug2n6Enor6iTldb5EnC2
   Q==;
X-CSE-ConnectionGUID: x23DZKVsTli7oae2U3svPA==
X-CSE-MsgGUID: BZ6lRphGSgaThl5m46QypA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20163914"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20163914"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 08:16:42 -0700
X-CSE-ConnectionGUID: kQx71BvPTMyKrVLa/AmIOA==
X-CSE-MsgGUID: tc3dOZPqSlqJHiwu4cWUPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48667690"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.1.209]) ([10.246.1.209])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 08:16:40 -0700
Message-ID: <887278b5-55f3-47a9-9d10-8db68e8dd8f6@linux.intel.com>
Date: Tue, 25 Jun 2024 17:16:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 7/7] ice: Add tracepoint for
 adding and removing switch rules
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
 michal.swiatkowski@linux.intel.com
References: <20240624144530.690545-1-marcin.szycik@linux.intel.com>
 <20240624144530.690545-8-marcin.szycik@linux.intel.com>
 <e7769bd7-e4fa-412a-8ad1-c0e5b8655a52@molgen.mpg.de>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <e7769bd7-e4fa-412a-8ad1-c0e5b8655a52@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 25.06.2024 10:31, Paul Menzel wrote:
> Dear Marcin,
> 
> 
> Thank you for your patch.
> 
> Am 24.06.24 um 16:45 schrieb Marcin Szycik:
>> Track the number of rules and recipes added to switch. Add a tracepoint to
>> ice_aq_sw_rules(), which shows both rule and recipe count. This information
>> can be helpful when designing a set of rules to program to the hardware, as
>> it shows where the practical limit is. Actual limits are known (64 recipes,
>> 32k rules), but it's hard to translate these values to how many rules the
>> *user* can actually create, because of extra metadata being implicitly
>> added, and recipe/rule chaining. Chaining combines several recipes/rules to
>> create a larger recipe/rule, so one large rule added by the user might
>> actually consume multiple rules from hardware perspective.
>>
>> Rule counter is simply incremented/decremented in ice_aq_sw_rules(), since
>> all rules are added or removed via it.
>>
>> Counting recipes is harder, as recipes can't be removed (only overwritten).
>> Recipes added via ice_aq_add_recipe() could end up being unused, when
>> there is an error in later stages of rule creation. Instead, track the
>> allocation and freeing of recipes, which should reflect the actual usage of
>> recipes (if something fails after recipe(s) were created, caller should
>> free them). Also, a number of recipes are loaded from NVM by default -
>> initialize the recipe counter with the number of these recipes on switch
>> initialization.
> 
> Can you please add an example how to use the tracepoint?

Sure, will add to next version.

Example configuration:
  cd /sys/kernel/tracing
  echo function > current_tracer
  echo ice_aq_sw_rules > set_ftrace_filter
  echo ice_aq_sw_rules > set_event
  echo 1 > tracing_on
  cat trace

Sample output:
  tc-4097    [069] ...1.   787.595536: ice_aq_sw_rules <-ice_rem_adv_rule
  tc-4097    [069] .....   787.595705: ice_aq_sw_rules: rules=9 recipes=15
  tc-4098    [057] ...1.   787.652033: ice_aq_sw_rules <-ice_add_adv_rule
  tc-4098    [057] .....   787.652201: ice_aq_sw_rules: rules=10 recipes=16

Thanks,
Marcin

>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_common.c |  3 +++
>>   drivers/net/ethernet/intel/ice/ice_switch.c | 22 +++++++++++++++++++--
>>   drivers/net/ethernet/intel/ice/ice_trace.h  | 18 +++++++++++++++++
>>   drivers/net/ethernet/intel/ice/ice_type.h   |  2 ++
>>   4 files changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>> index 6abd1b3796ab..009716a12a26 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>> @@ -934,6 +934,9 @@ static int ice_init_fltr_mgmt_struct(struct ice_hw *hw)
>>       INIT_LIST_HEAD(&sw->vsi_list_map_head);
>>       sw->prof_res_bm_init = 0;
>>   +    /* Initialize recipe count with default recipes read from NVM */
>> +    sw->recp_cnt = ICE_SW_LKUP_LAST;
>> +
>>       status = ice_init_def_sw_recp(hw);
>>       if (status) {
>>           devm_kfree(ice_hw_to_dev(hw), hw->switch_info);
>> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
>> index 27828cdfe085..3caafcdc301f 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
>> @@ -3,6 +3,7 @@
>>     #include "ice_lib.h"
>>   #include "ice_switch.h"
>> +#include "ice_trace.h"
>>     #define ICE_ETH_DA_OFFSET        0
>>   #define ICE_ETH_ETHTYPE_OFFSET        12
>> @@ -1961,6 +1962,15 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list, u16 rule_list_sz,
>>           hw->adminq.sq_last_status == ICE_AQ_RC_ENOENT)
>>           status = -ENOENT;
>>   +    if (!status) {
>> +        if (opc == ice_aqc_opc_add_sw_rules)
>> +            hw->switch_info->rule_cnt += num_rules;
>> +        else if (opc == ice_aqc_opc_remove_sw_rules)
>> +            hw->switch_info->rule_cnt -= num_rules;
>> +    }
>> +
>> +    trace_ice_aq_sw_rules(hw->switch_info);
>> +
>>       return status;
>>   }
>>   @@ -2181,8 +2191,10 @@ int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
>>       sw_buf->res_type = cpu_to_le16(res_type);
>>       status = ice_aq_alloc_free_res(hw, sw_buf, buf_len,
>>                          ice_aqc_opc_alloc_res);
>> -    if (!status)
>> +    if (!status) {
>>           *rid = le16_to_cpu(sw_buf->elem[0].e.sw_resp);
>> +        hw->switch_info->recp_cnt++;
>> +    }
>>         return status;
>>   }
>> @@ -2196,7 +2208,13 @@ int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
>>    */
>>   static int ice_free_recipe_res(struct ice_hw *hw, u16 rid)
>>   {
>> -    return ice_free_hw_res(hw, ICE_AQC_RES_TYPE_RECIPE, 1, &rid);
>> +    int status;
>> +
>> +    status = ice_free_hw_res(hw, ICE_AQC_RES_TYPE_RECIPE, 1, &rid);
>> +    if (!status)
>> +        hw->switch_info->recp_cnt--;
>> +
>> +    return status;
>>   }
>>     /**
>> diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
>> index 244cddd2a9ea..07aab6e130cd 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_trace.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_trace.h
>> @@ -330,6 +330,24 @@ DEFINE_EVENT(ice_esw_br_port_template,
>>            TP_ARGS(port)
>>   );
>>   +DECLARE_EVENT_CLASS(ice_switch_stats_template,
>> +            TP_PROTO(struct ice_switch_info *sw_info),
>> +            TP_ARGS(sw_info),
>> +            TP_STRUCT__entry(__field(u16, rule_cnt)
>> +                     __field(u8, recp_cnt)),
>> +            TP_fast_assign(__entry->rule_cnt = sw_info->rule_cnt;
>> +                   __entry->recp_cnt = sw_info->recp_cnt;),
>> +            TP_printk("rules=%u recipes=%u",
>> +                  __entry->rule_cnt,
>> +                  __entry->recp_cnt)
>> +);
>> +
>> +DEFINE_EVENT(ice_switch_stats_template,
>> +         ice_aq_sw_rules,
>> +         TP_PROTO(struct ice_switch_info *sw_info),
>> +         TP_ARGS(sw_info)
>> +);
>> +
>>   /* End tracepoints */
>>     #endif /* _ICE_TRACE_H_ */
>> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
>> index c330a436d11a..b6bc2de53b0a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_type.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
>> @@ -764,6 +764,8 @@ struct ice_switch_info {
>>       struct ice_sw_recipe *recp_list;
>>       u16 prof_res_bm_init;
>>       u16 max_used_prof_index;
>> +    u16 rule_cnt;
>> +    u8 recp_cnt;
>>         DECLARE_BITMAP(prof_res_bm[ICE_MAX_NUM_PROFILES], ICE_MAX_FV_WORDS);
>>   };
> 
> 
> Kind regards,
> 
> Paul

