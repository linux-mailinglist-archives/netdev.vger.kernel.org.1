Return-Path: <netdev+bounces-157707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD5A0B4AC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECEF3A37F9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E80022AE74;
	Mon, 13 Jan 2025 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="izDRfAlY"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97EB1BE871
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764707; cv=none; b=joPH9mRkrebMMS0ZEGxPcmDcGfuJ9oDleDHWG6YAsTMVRVhaaAXKbSklNc6CVuz4wiN9KYEHzNSCmfo8l85Ji+UuSsnFrmMo3bvytyaEu1ra1pvlmYdve/uneKF7yDWqZOv/WrkDV1QE+tgMvrgV0p49JjcbCqIxH7+HuHcwipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764707; c=relaxed/simple;
	bh=A3TnApFQ5E+ZnWjnnxtps4CUwf2XXzqg9olH2102y5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbDJ9oQ+hYHdk9oLF4RV+9Nk7V+Xpv8/E/CGdXT0/MAfxdz6IbbFWXX4Vo1qvyMEQ+m0JsQ2cx6j7wDmVTqS8xN0aoQbrdrnWffJ0c/xxk/cpooNmRl1uXQKsNBCqR4EghYi1CYsT0S2AoqnY8oeBkCnvPrmgQae8Ju6h+Ijk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=izDRfAlY; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d41bdce0-7ae8-47cf-a713-7305c7b7a8b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736764701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soN/F0YZByjKjBBmycXWunFBcc0RAQ5as/dAfb2Eu+0=;
	b=izDRfAlYcIlzM/SVg9Uo+4BqJ/J1T0oNnFGpcDxXt3eVwL0uh6L0axSh2l6h73TZUEueLJ
	Zaxx3fhSh7ypCNb2r/oS3U4Xkr7KNNStiHC8U9ObsFVv/ei7Z271FtMl+ZbfkIcLv0x2OA
	yMP8HlO/iQVhhCSboHWNDwKlYVgjgRg=
Date: Mon, 13 Jan 2025 10:38:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/4] net: wangxun: Add support for PTP clock
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
 <20250110031716.2120642-2-jiawenwu@trustnetic.com>
 <c0228210-4991-48ad-8e2d-69b176c1d79d@linux.dev>
 <057c01db658b$1e6f45f0$5b4dd1d0$@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <057c01db658b$1e6f45f0$5b4dd1d0$@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/01/2025 07:16, Jiawen Wu wrote:
>>> @@ -1501,12 +1535,19 @@ static netdev_tx_t wx_xmit_frame_ring(struct sk_buff *skb,
>>>    	if (test_bit(WX_FLAG_FDIR_CAPABLE, wx->flags) && tx_ring->atr_sample_rate)
>>>    		wx->atr(tx_ring, first, ptype);
>>>
>>> -	wx_tx_map(tx_ring, first, hdr_len);
>>> +	if (wx_tx_map(tx_ring, first, hdr_len))
>>> +		goto cleanup_tx_tstamp;
>>>
>>>    	return NETDEV_TX_OK;
>>>    out_drop:
>>>    	dev_kfree_skb_any(first->skb);
>>>    	first->skb = NULL;
>>> +cleanup_tx_tstamp:
>>> +	if (unlikely(tx_flags & WX_TX_FLAGS_TSTAMP)) {
>>> +		dev_kfree_skb_any(wx->ptp_tx_skb);
>>> +		wx->ptp_tx_skb = NULL;
>>> +		clear_bit_unlock(WX_STATE_PTP_TX_IN_PROGRESS, wx->state);
>>> +	}
>>
>> This is error path of dma mapping, means TX timestamp will be missing
>> because the packet was not sent. But the error/missing counter is not
>> bumped. I think it needs to be indicated.
> 
> I'll count it as 'err' in ethtool_ts_stats.
> 
>>> +static int wx_ptp_set_timestamp_mode(struct wx *wx,
>>> +				     struct kernel_hwtstamp_config *config)
>>> +{
>>> +	u32 tsync_tx_ctl = WX_TSC_1588_CTL_ENABLED;
>>> +	u32 tsync_rx_ctl = WX_PSR_1588_CTL_ENABLED;
>>> +	DECLARE_BITMAP(flags, WX_PF_FLAGS_NBITS);
>>> +	u32 tsync_rx_mtrl = PTP_EV_PORT << 16;
>>> +	bool is_l2 = false;
>>> +	u32 regval;
>>> +
>>> +	memcpy(flags, wx->flags, sizeof(wx->flags));
>>> +
>>> +	switch (config->tx_type) {
>>> +	case HWTSTAMP_TX_OFF:
>>> +		tsync_tx_ctl = 0;
>>> +		break;
>>> +	case HWTSTAMP_TX_ON:
>>> +		break;
>>> +	default:
>>> +		return -ERANGE;
>>> +	}
>>> +
>>> +	switch (config->rx_filter) {
>>> +	case HWTSTAMP_FILTER_NONE:
>>> +		tsync_rx_ctl = 0;
>>> +		tsync_rx_mtrl = 0;
>>> +		clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
>>> +		clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
>>> +		break;
>>> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>>> +		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
>>> +		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_SYNC;
>>> +		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
>>> +		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
>>> +		break;
>>> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>>> +		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_L4_V1;
>>> +		tsync_rx_mtrl |= WX_PSR_1588_MSG_V1_DELAY_REQ;
>>> +		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
>>> +		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
>>> +		break;
>>> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
>>> +	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
>>> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>>> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
>>> +	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
>>> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>>> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>>> +	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>>> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>>> +		tsync_rx_ctl |= WX_PSR_1588_CTL_TYPE_EVENT_V2;
>>> +		is_l2 = true;
>>> +		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>>> +		set_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, flags);
>>> +		set_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, flags);
>>> +		break;
>>> +	default:
>>> +		/* register RXMTRL must be set in order to do V1 packets,
>>> +		 * therefore it is not possible to time stamp both V1 Sync and
>>> +		 * Delay_Req messages unless hardware supports timestamping all
>>> +		 * packets => return error
>>> +		 */
>>> +		clear_bit(WX_FLAG_RX_HWTSTAMP_ENABLED, wx->flags);
>>> +		clear_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER, wx->flags);
>>> +		config->rx_filter = HWTSTAMP_FILTER_NONE;
>>> +		return -ERANGE;
>>
>> looks like this code is a bit tricky and leads to out-of-sync
>> configuration. Imagine the situation when HWTSTAMP_FILTER_PTP_V2_EVENT
>> was configured first, the hardware was properly set up and timestamps
>> are coming. wx->flags will have bits WX_FLAG_RX_HWTSTAMP_ENABLED and
>> WX_FLAG_RX_HWTSTAMP_IN_REGISTER set. Then the user asks to enable
>> HWTSTAMP_FILTER_ALL, which is not supported. wx->flags will have bits
>> mentioned above cleared, but the hardware will still continue to
>> timestamp some packets.
> 
> You are right. I'll remove the bit clears in the default case.
> 
>>> +void wx_ptp_reset(struct wx *wx)
>>> +{
>>> +	unsigned long flags;
>>> +
>>> +	/* reset the hardware timestamping mode */
>>> +	wx_ptp_set_timestamp_mode(wx, &wx->tstamp_config);
>>> +	wx_ptp_reset_cyclecounter(wx);
>>> +
>>> +	wr32ptp(wx, WX_TSC_1588_SYSTIML, 0);
>>> +	wr32ptp(wx, WX_TSC_1588_SYSTIMH, 0);
>>> +	WX_WRITE_FLUSH(wx);
>>
>> writes to WX_TSC_1588_SYSTIML/WX_TSC_1588_SYSTIMH are not protected by
>> tmreg_lock, while reads are protected in wx_ptp_read() and in
>> wx_ptp_gettimex64()
> 
> No need to protect it. See below.
> 
>>> @@ -1133,6 +1168,21 @@ struct wx {
>>>    	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
>>>    	void (*configure_fdir)(struct wx *wx);
>>>    	void (*do_reset)(struct net_device *netdev);
>>> +
>>> +	u32 base_incval;
>>> +	u32 tx_hwtstamp_pkts;
>>> +	u32 tx_hwtstamp_timeouts;
>>> +	u32 tx_hwtstamp_skipped;
>>> +	u32 rx_hwtstamp_cleared;
>>> +	unsigned long ptp_tx_start;
>>> +	spinlock_t tmreg_lock; /* spinlock for ptp */
>>
>> Could you please explain what this lock protects exactly? According to
>> the name, it should serialize access to tm(?) registers, but there is
>> a mix of locked and unlocked accesses in the code ...
>> If this lock protects cyclecounter/timecounter then it might be better
>> to use another name, like hw_cc_lock. And in this case it's even better
>> to use seqlock_t with reader/writer accessors according to the code path.
> 
> It is for struct timecounter. The registers are read only to update the cycle
> counter. I think  it's better to  name it hw_tc_lock.

Ok, that's what I actually expected. Could you please use seqlock_t
instead of plain spinlock - there is a clear split of readers and
writers for cycle counter.


