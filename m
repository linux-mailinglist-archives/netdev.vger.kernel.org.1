Return-Path: <netdev+bounces-24122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD176EDB1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067061C2157D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3B421D51;
	Thu,  3 Aug 2023 15:11:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80720F9E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:11:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995E2359A
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691075484; x=1722611484;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=geRz+WCA5+K2MPLiiSkmYknrl3waAqOqUJzE8u9rS2w=;
  b=hctgLCIOgPj2iiXhoyvIdwngcZDLz3IYNevDKAZrpeTJcURQSd31wCJS
   g/+PsM8popQ25gN87iVLge5/k1u1cv2Zv4G84TN0rz8N/arfcVnkHtFfF
   hItMlNnkwUh6n8HaWnMZuMqimvUNEOg8iIMGuQ4yVRCLk6z/CH2LEgm8o
   TnQz00lNugU+5gnx2DtcO4keq2xlu6YOqX0KvdsRnyX2jtxa0xufGtPKq
   5R9lvynfYlKxl+jyKP5ue9J1QxzS3AEpIZevDbTA3nrYRKRI3JpPCvPhs
   At0JCEg+TiqRKHkmHGUK1UoTH8jgGbwvr2rstczm+F1Cx7vvWfTz0ErCg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433750403"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="433750403"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="819698403"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="819698403"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.249.159.204]) ([10.249.159.204])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 08:11:18 -0700
Message-ID: <457944e2-c8bc-74a7-ec5b-4502c4ec2664@linux.intel.com>
Date: Thu, 3 Aug 2023 17:11:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH iwl-net] ice: Block switchdev mode when ADQ is acvite and
 vice versa
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20230801115235.67343-1-marcin.szycik@linux.intel.com>
 <20230803131126.GD53714@unreal> <ZMuq9ph8HY6uAiGk@nanopsycho>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <ZMuq9ph8HY6uAiGk@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 03.08.2023 15:26, Jiri Pirko wrote:
> Thu, Aug 03, 2023 at 03:11:26PM CEST, leon@kernel.org wrote:
>> On Tue, Aug 01, 2023 at 01:52:35PM +0200, Marcin Szycik wrote:
>>> ADQ and switchdev are not supported simultaneously. Enabling both at the
>>> same time can result in nullptr dereference.
>>>
>>> To prevent this, check if ADQ is active when changing devlink mode to
>>> switchdev mode, and check if switchdev is active when enabling ADQ.
>>>
>>> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>> ---
>>>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 +++++
>>>  drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
>>>  2 files changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>>> index ad0a007b7398..2ea5aaceee11 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>>> @@ -538,6 +538,11 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
>>>  		break;
>>>  	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>>>  	{
>>> +		if (ice_is_adq_active(pf)) {
>>> +			dev_err(ice_pf_to_dev(pf), "switchdev cannot be configured - ADQ is active. Delete ADQ configs using TC and try again\n");
> 
> Does this provide sufficient hint to the user? I mean, what's ADQ and
> how it is related to TC objects? Please be more precise.

Application Device Queues, a conflicting feature unrelated to switchdev.
If it's enabled, there's a good chance the user knows what it is because
they configured it.

Could you suggest a better error message?

> 
> 
>>
>> It needs to be reported through netlink extack.
>>
>>> +			return -EOPNOTSUPP;
>>> +		}
>>> +
>>>  		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
>>>  			 pf->hw.pf_id);
>>>  		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
>>
>> Thanks
>>
> 

Regards,
Marcin

