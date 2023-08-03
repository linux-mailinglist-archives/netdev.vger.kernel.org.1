Return-Path: <netdev+bounces-24117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B35176ED65
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5BD1C21600
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D3C1F18D;
	Thu,  3 Aug 2023 14:59:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986EA1ED48
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:59:09 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659D30F3
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691074744; x=1722610744;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RC90PoHcIJ3DN0re5YrF7v8v74QXIm/r6CDhc/SzN6E=;
  b=WPgwOjFih9S93vfbnBtznucRntieog46B70vTxT3qFY/Hd+WvyhF95b7
   9AT0mZu7FNcUxhMuH1LpFeeuwbVqxdIpdbxicfNUim3s1czlnldmF/NIk
   eOO0TVzM9sH17bbTxyovJLEfY+dIfzUNZB0ckDXRoS5+vlNMr3rFp8Ye1
   ccqPi48F2sXXUG9w/G82zvubqLovxYTDV9zY0lGZc2KU4RAtXTW12XXJx
   glenh9noXrXUfzV9pwN4pT81WiDhEuFTAflRcSFhTkagpidlR7jLSzG6L
   xjf1M0FrP4DTHm/wTBhPZbwMUB5gicNuIeqtnOyIs0mHfhLRSFnItx2sq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="359951210"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="359951210"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 07:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="723235922"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="723235922"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.249.159.204]) ([10.249.159.204])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 07:59:02 -0700
Message-ID: <51af092b-cd91-e134-888c-0d0220d37d1c@linux.intel.com>
Date: Thu, 3 Aug 2023 16:58:45 +0200
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
To: Leon Romanovsky <leon@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20230801115235.67343-1-marcin.szycik@linux.intel.com>
 <20230803131126.GD53714@unreal>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20230803131126.GD53714@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 03.08.2023 15:11, Leon Romanovsky wrote:
> On Tue, Aug 01, 2023 at 01:52:35PM +0200, Marcin Szycik wrote:
>> ADQ and switchdev are not supported simultaneously. Enabling both at the
>> same time can result in nullptr dereference.
>>
>> To prevent this, check if ADQ is active when changing devlink mode to
>> switchdev mode, and check if switchdev is active when enabling ADQ.
>>
>> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 +++++
>>  drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> index ad0a007b7398..2ea5aaceee11 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
>> @@ -538,6 +538,11 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
>>  		break;
>>  	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>>  	{
>> +		if (ice_is_adq_active(pf)) {
>> +			dev_err(ice_pf_to_dev(pf), "switchdev cannot be configured - ADQ is active. Delete ADQ configs using TC and try again\n");
> 
> It needs to be reported through netlink extack.

Will do, thanks!

> 
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>  		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
>>  			 pf->hw.pf_id);
>>  		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
> 
> Thanks

