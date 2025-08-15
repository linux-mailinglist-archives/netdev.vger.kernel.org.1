Return-Path: <netdev+bounces-214057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47DB28035
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE63D1D021D1
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2828724D;
	Fri, 15 Aug 2025 12:55:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180501D63D3
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262502; cv=none; b=irgt9du+O2v9wiuhX//ZceytLYFk8Nhk0fSP226k2jx+qZ1Ri0wLAQC/wPhE1ugZ9yw8K3jUew6yOzeOHA12DM2w9d2TbIiMwcNvak6k7YoknY0yh3gxj7GMOh82AEGrZch56L/XD9jSvdmpqVsPdLepOgfbmGhBOEGmuYkij/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262502; c=relaxed/simple;
	bh=63DTvF7kHbVHDEnE3rBMilyEeKWauj4fEV7M+x9VzUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWB1m68tncua2dhmIhnTX8sUJdHnQmmgWmF7HTPIVSvFXhdslnfJvHzQos6qVKiTu/wUddj0dVpxvY+VxO5GjwU5xBD/WjLizvzpZ/sAOs5aavLF6jM4zAh0JHzVusFt6g3QzjjWR14IA53RkvX2RvXdHsOp1327fRSDV7Va9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.184] (ip5f5af516.dynamic.kabel-deutschland.de [95.90.245.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C7E0E61E6484C;
	Fri, 15 Aug 2025 14:54:16 +0200 (CEST)
Message-ID: <ad66d19c-be7b-4df3-8e4c-d57a08782df4@molgen.mpg.de>
Date: Fri, 15 Aug 2025 14:54:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>
 <87y0rlm22a.fsf@jax.kurt.home>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <87y0rlm22a.fsf@jax.kurt.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kurt, dear Sebastian,


Thank you for your replies.


Am 15.08.25 um 10:17 schrieb Kurt Kanzenbach:

> On Fri Aug 15 2025, Paul Menzel wrote:

>> Am 15.08.25 um 08:50 schrieb Kurt Kanzenbach:
>>> Retrieve Tx timestamp directly from interrupt handler.
>>>
>>> The current implementation uses schedule_work() which is executed by the
>>> system work queue to retrieve Tx timestamps. This increases latency and can
>>> lead to timeouts in case of heavy system load.
>>>
>>> Therefore, fetch the timestamp directly from the interrupt handler.
>>>
>>> The work queue code stays for the Intel 82576. Tested on Intel i210.
>>
>> Excuse my ignorance, I do not understand the first sentence in the last
>> line. Is it because the driver support different models? Why not change
>> it for Intel 82576 too?
> 
> Yes, the driver supports lots of different NIC(s). AFAICS Intel 82576 is
> the only one which does not use time sync interrupts. Probably it does
> not have this feature. Therefore, the 82576 needs to schedule a work
> queue item.

Should you resend, it’d be great if you mentioned that. (Sebastian 
confirmed it.)

>> Do you have a reproducer for the issue, so others can test.
> 
> Yeah, I do have a reproducer:
> 
>   - Run ptp4l with 40ms tx timeout (--tx_timestamp_timeout)
>   - Run periodic RT tasks (e.g. with SCHED_FIFO 1) with run time of
>     50-100ms per CPU core
> 
> This leads to sporadic error messages from ptp4l such as "increasing
> tx_timestamp_timeout or increasing kworker priority may correct this
> issue, but a driver bug likely causes it"
> 
> However, increasing the kworker priority is not an option, simply
> because this kworker is doing non-related PTP work items as well.
> 
> As the time sync interrupt already signals that the Tx timestamp is
> available, there's no need to schedule a work item in this case. I might
> have missed something though. But my testing looked good. The warn_on
> never triggered.

Great. Maybe add that too, as, at least for me, realtime stuff is 
something I do not do, so pointers would help me.

>>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>>> ---
>>>    drivers/net/ethernet/intel/igb/igb.h      |  1 +
>>>    drivers/net/ethernet/intel/igb/igb_main.c |  2 +-
>>>    drivers/net/ethernet/intel/igb/igb_ptp.c  | 22 ++++++++++++++++++++++
>>>    3 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
>>> index c3f4f7cd264e9b2ff70f03b580f95b15b528028c..102ca32e8979fa3203fc2ea36eac456f1943cfca 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb.h
>>> +++ b/drivers/net/ethernet/intel/igb/igb.h
>>> @@ -776,6 +776,7 @@ int igb_ptp_hwtstamp_get(struct net_device *netdev,
>>>    int igb_ptp_hwtstamp_set(struct net_device *netdev,
>>>    			 struct kernel_hwtstamp_config *config,
>>>    			 struct netlink_ext_ack *extack);
>>> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter);
>>>    void igb_set_flag_queue_pairs(struct igb_adapter *, const u32);
>>>    unsigned int igb_get_max_rss_queues(struct igb_adapter *);
>>>    #ifdef CONFIG_IGB_HWMON
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>> index a9a7a94ae61e93aa737b0103e00580e73601d62b..8ab6e52cb839bbb698007a74462798faaaab0071 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>> @@ -7080,7 +7080,7 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
>>>    
>>>    	if (tsicr & E1000_TSICR_TXTS) {
>>>    		/* retrieve hardware timestamp */
>>> -		schedule_work(&adapter->ptp_tx_work);
>>> +		igb_ptp_tx_tstamp_event(adapter);
>>>    	}
>>>    
>>>    	if (tsicr & TSINTR_TT0)
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
>>> index a7876882aeaf2b2a7fb9ec6ff5c83d8a1b06008a..20ecafecc60557353f8cc5ab505030246687c8e4 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>>> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>>> @@ -796,6 +796,28 @@ static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
>>>    	return 0;
>>>    }
>>>    
>>> +/**
>>> + * igb_ptp_tx_tstamp_event
>>> + * @adapter: pointer to igb adapter
>>> + *
>>> + * This function checks the TSYNCTXCTL valid bit and stores the Tx hardware
>>> + * timestamp at the current skb.
>>> + **/
>>> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter)
>>> +{
>>> +	struct e1000_hw *hw = &adapter->hw;
>>> +	u32 tsynctxctl;
>>> +
>>> +	if (!adapter->ptp_tx_skb)
>>> +		return;
>>> +
>>> +	tsynctxctl = rd32(E1000_TSYNCTXCTL);
>>> +	if (WARN_ON_ONCE(!(tsynctxctl & E1000_TSYNCTXCTL_VALID)))
>>> +		return;
>>> +
>>> +	igb_ptp_tx_hwtstamp(adapter);
>>> +}
>>> +
>>>    /**
>>>     * igb_ptp_tx_work
>>>     * @work: pointer to work struct
>>
>> The diff looks fine.
>>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

