Return-Path: <netdev+bounces-216486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE809B3407E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD63318960C3
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED6B23E359;
	Mon, 25 Aug 2025 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C95Blw4B"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A319CD1D
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756127948; cv=none; b=rTELepeA0H7SMgZ/Mgy4icx9ikg/2nSOu2RkcrtWciiQ/bX22zWKQfPgZe61YThuKFffgfUnd6nWF5U3kWXcx8GjxjYhTnbS9f3oHaseM/D8C1PaORm00hFQlS+gfVFDdq7puHZHSHoM3qqyTrbzXu8bEPEXhTytok0Hmbk2U90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756127948; c=relaxed/simple;
	bh=5wK/VflYLPf6erWjG1m9vnRX96wc9AR9RiyjX0/zPzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dp9TEut9mFfYyb98CYn07IdB8Vh18aezd94dzlSesDbeTQ2WA8ElFkxZXWzAkmHSpPJ9ovxL8EuO912crWGZPUHKsrcuPHnsKbSZ3+0NFrqykC9vjL41b84rPZ+dVlHrAwdzAV06jrOnfSvZVtGLyjkgGPw007nwxasqRQHYhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C95Blw4B; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1b3f5020-fa2e-496c-83aa-1e1606bc5ea7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756127943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvJJFTv2OrJI9Hc15K9BCwIafSJ45UQvTt/UjQZBBjo=;
	b=C95Blw4BW9wdfdwaSAl6pRp1IqafU2os0ksJgFT+SpQLe/Fg2hJ2jIk/J9lQD4HCXCavcF
	QD801xy+m+vShK00Qla8i9vc0jZJeldFPXtvALSg8qSaI6DHYn6MzaS/YzA3+6D4Z4I8SS
	JrPsn2KkAofyypgIa2vVMKaRP7QqJ4E=
Date: Mon, 25 Aug 2025 14:18:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Miroslav Lichvar <mlichvar@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <27e8fb9f-0e9c-4a0b-b961-64ff9d2f5228@linux.dev>
 <87ikie7a88.fsf@jax.kurt.home>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <87ikie7a88.fsf@jax.kurt.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/08/2025 08:44, Kurt Kanzenbach wrote:
> On Fri Aug 22 2025, Vadim Fedorenko wrote:
>> On 22/08/2025 08:28, Kurt Kanzenbach wrote:
>>> The current implementation uses schedule_work() which is executed by the
>>> system work queue to retrieve Tx timestamps. This increases latency and can
>>> lead to timeouts in case of heavy system load.
>>>
>>> Therefore, switch to the PTP aux worker which can be prioritized and pinned
>>> according to use case. Tested on Intel i210.
>>>
>>>     * igb_ptp_tx_work
>>> - * @work: pointer to work struct
>>> + * @ptp: pointer to ptp clock information
>>>     *
>>>     * This work function polls the TSYNCTXCTL valid bit to determine when a
>>>     * timestamp has been taken for the current stored skb.
>>>     **/
>>> -static void igb_ptp_tx_work(struct work_struct *work)
>>> +static long igb_ptp_tx_work(struct ptp_clock_info *ptp)
>>>    {
>>> -	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
>>> -						   ptp_tx_work);
>>> +	struct igb_adapter *adapter = container_of(ptp, struct igb_adapter,
>>> +						   ptp_caps);
>>>    	struct e1000_hw *hw = &adapter->hw;
>>>    	u32 tsynctxctl;
>>>    
>>>    	if (!adapter->ptp_tx_skb)
>>> -		return;
>>> +		return -1;
>>>    
>>>    	if (time_is_before_jiffies(adapter->ptp_tx_start +
>>>    				   IGB_PTP_TX_TIMEOUT)) {
>>> @@ -824,15 +824,17 @@ static void igb_ptp_tx_work(struct work_struct *work)
>>>    		 */
>>>    		rd32(E1000_TXSTMPH);
>>>    		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
>>> -		return;
>>> +		return -1;
>>>    	}
>>>    
>>>    	tsynctxctl = rd32(E1000_TSYNCTXCTL);
>>> -	if (tsynctxctl & E1000_TSYNCTXCTL_VALID)
>>> +	if (tsynctxctl & E1000_TSYNCTXCTL_VALID) {
>>>    		igb_ptp_tx_hwtstamp(adapter);
>>> -	else
>>> -		/* reschedule to check later */
>>> -		schedule_work(&adapter->ptp_tx_work);
>>> +		return -1;
>>> +	}
>>> +
>>> +	/* reschedule to check later */
>>> +	return 1;
>>
>> do_aux_work is expected to return delay in jiffies to re-schedule the
>> work. it would be cleaner to use msec_to_jiffies macros to tell how much
>> time the driver has to wait before the next try of retrieving the
>> timestamp. AFAIU, the timestamp may come ASAP in this case, so it's
>> actually reasonable to request immediate re-schedule of the worker by
>> returning 0.
> 
> I don't think so. The 'return 1' is only executed for 82576. For all
> other NICs the TS is already available. For 82576 the packet is queued
> to Tx ring and the worker is scheduled immediately. For example, in case
> of other Tx traffic there's a chance that the TS is not available
> yet. So we comeback one jiffy later, which is 10ms at worst. That looked
> reasonable to me.

Ok, LGTM
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

