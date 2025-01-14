Return-Path: <netdev+bounces-158040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FF5A10308
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACDC3A3EFC
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513722DC4D;
	Tue, 14 Jan 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ptkOLmhM"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6B22DC29
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847075; cv=none; b=Fmrhf6ywPEtKmMRJLzBMcaZpIXMwx/5tGCrBbIdLddlP/zpPNDAtWOOSKp4rEUjcRCmOs7b/uFMT/gK6+N8h0frzLrYF1b7PH40WdcUh0gbbc8AAbmX8nARWPQf5dO+Spd1S4wLyBMU0WiD8i5uoS1gh8hm4URtFHJfm61p4lEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847075; c=relaxed/simple;
	bh=L21xS+ZuFgwnggUJ4/oB/094mVFJ5kAEZnb5zeEdrfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeN4hdks2kprcpcSaC/GZdLkf8F8noNnr9DDi/gdRxxFU6oU7+KAXBdNTp73l4IktykEVHCV6E9eSpb0jZv0xuhScQJai5/8KwJ/uvq5COVisviRJAbMNVi44j5bB7IpJ2+fLeNeaxYicgYv8cAxsKr4CNqaNAT1jsLggWVmXn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ptkOLmhM; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bdd1ab43-93a0-487f-b8f3-f069fda05cd7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736847071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drNCR+ODbeytz/Wz0Qr+R8KdwL0AcJTz6kxi0kcb/lc=;
	b=ptkOLmhM2NSvWQrYfT5nMuXa9obkz9EEG16a4zfHETPOz1Wk2+ssDDLG0mXfd7NdpH9Lnw
	B6HzLCyqFv+l2rR9wUO3phARHnlHVdtcdGNPjxCRqJ8VMh0B8Uyt0fE7HJzmZeVzxHacWP
	+iT0+W62/oOuq0Ym7/KXYojWrGjVQ/E=
Date: Tue, 14 Jan 2025 09:31:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/4] net: wangxun: Implement do_aux_work of
 ptp_clock_info
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
References: <20250114084425.2203428-1-jiawenwu@trustnetic.com>
 <20250114084425.2203428-4-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250114084425.2203428-4-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/01/2025 08:44, Jiawen Wu wrote:
> Implement watchdog task to detect SYSTIME overflow and error cases of
> Rx/Tx timestamp.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>   drivers/net/ethernet/wangxun/libwx/wx_ptp.c   | 114 ++++++++++++++++++
>   drivers/net/ethernet/wangxun/libwx/wx_type.h  |   2 +
>   drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |   1 +
>   .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |   1 +
>   4 files changed, 118 insertions(+)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> index 97d39e8f02da..2e3d9cfc8aba 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ptp.c
> @@ -251,6 +251,116 @@ static void wx_ptp_tx_hwtstamp_work(struct work_struct *work)
>   	}
>   }
>   
> +/**
> + * wx_ptp_overflow_check - watchdog task to detect SYSTIME overflow
> + * @wx: pointer to wx struct
> + *
> + * this watchdog task periodically reads the timecounter
> + * in order to prevent missing when the system time registers wrap
> + * around. This needs to be run approximately twice a minute for the fastest
> + * overflowing hardware. We run it for all hardware since it shouldn't have a
> + * large impact.
> + */
> +static void wx_ptp_overflow_check(struct wx *wx)
> +{
> +	bool timeout = time_is_before_jiffies(wx->last_overflow_check +
> +					      WX_OVERFLOW_PERIOD);
> +	unsigned long flags;
> +
> +	if (timeout) {
> +		/* Update the timecounter */
> +		write_seqlock_irqsave(&wx->hw_tc_lock, flags);
> +		timecounter_read(&wx->hw_tc);
> +		write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
> +
> +		wx->last_overflow_check = jiffies;
> +	}
> +}
> +
> +/**
> + * wx_ptp_rx_hang - detect error case when Rx timestamp registers latched
> + * @wx: pointer to wx struct
> + *
> + * this watchdog task is scheduled to detect error case where hardware has
> + * dropped an Rx packet that was timestamped when the ring is full. The
> + * particular error is rare but leaves the device in a state unable to
> + * timestamp any future packets.
> + */
> +static void wx_ptp_rx_hang(struct wx *wx)
> +{
> +	struct wx_ring *rx_ring;
> +	unsigned long rx_event;
> +	u32 tsyncrxctl;
> +	int n;
> +
> +	tsyncrxctl = rd32(wx, WX_PSR_1588_CTL);
> +
> +	/* if we don't have a valid timestamp in the registers, just update the
> +	 * timeout counter and exit
> +	 */
> +	if (!(tsyncrxctl & WX_PSR_1588_CTL_VALID)) {
> +		wx->last_rx_ptp_check = jiffies;
> +		return;
> +	}
> +
> +	/* determine the most recent watchdog or rx_timestamp event */
> +	rx_event = wx->last_rx_ptp_check;
> +	for (n = 0; n < wx->num_rx_queues; n++) {
> +		rx_ring = wx->rx_ring[n];
> +		if (time_after(rx_ring->last_rx_timestamp, rx_event))
> +			rx_event = rx_ring->last_rx_timestamp;
> +	}
> +
> +	/* only need to read the high RXSTMP register to clear the lock */
> +	if (time_is_before_jiffies(rx_event + 5 * HZ)) {
> +		rd32(wx, WX_PSR_1588_STMPH);
> +		wx->last_rx_ptp_check = jiffies;
> +
> +		wx->rx_hwtstamp_cleared++;
> +		dev_warn(&wx->pdev->dev, "clearing RX Timestamp hang");
> +	}
> +}
> +
> +/**
> + * wx_ptp_tx_hang - detect error case where Tx timestamp never finishes
> + * @wx: private network wx structure
> + */
> +static void wx_ptp_tx_hang(struct wx *wx)
> +{
> +	bool timeout = time_is_before_jiffies(wx->ptp_tx_start +
> +					      WX_PTP_TX_TIMEOUT);
> +
> +	if (!wx->ptp_tx_skb)
> +		return;
> +
> +	if (!test_bit(WX_STATE_PTP_TX_IN_PROGRESS, wx->state))
> +		return;
> +
> +	/* If we haven't received a timestamp within the timeout, it is
> +	 * reasonable to assume that it will never occur, so we can unlock the
> +	 * timestamp bit when this occurs.
> +	 */
> +	if (timeout) {
> +		cancel_work_sync(&wx->ptp_tx_work);
> +		wx_ptp_clear_tx_timestamp(wx);
> +		wx->tx_hwtstamp_timeouts++;
> +		dev_warn(&wx->pdev->dev, "clearing Tx timestamp hang\n");
> +	}
> +}
> +
> +static long wx_ptp_do_aux_work(struct ptp_clock_info *ptp)
> +{
> +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> +
> +	wx_ptp_overflow_check(wx);
> +	if (unlikely(test_bit(WX_FLAG_RX_HWTSTAMP_IN_REGISTER,
> +			      wx->flags)))
> +		wx_ptp_rx_hang(wx);
> +	wx_ptp_tx_hang(wx);
> +
> +	return HZ;
> +}
> +
>   /**
>    * wx_ptp_create_clock
>    * @wx: the private board structure
> @@ -283,6 +393,7 @@ static long wx_ptp_create_clock(struct wx *wx)
>   	wx->ptp_caps.adjtime = wx_ptp_adjtime;
>   	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
>   	wx->ptp_caps.settime64 = wx_ptp_settime64;
> +	wx->ptp_caps.do_aux_work = wx_ptp_do_aux_work;
>   	if (wx->mac.type == wx_mac_em)
>   		wx->ptp_caps.max_adj = 500000000;
>   	else
> @@ -566,6 +677,9 @@ void wx_ptp_reset(struct wx *wx)
>   	timecounter_init(&wx->hw_tc, &wx->hw_cc,
>   			 ktime_to_ns(ktime_get_real()));
>   	write_sequnlock_irqrestore(&wx->hw_tc_lock, flags);
> +
> +	wx->last_overflow_check = jiffies;
> +	ptp_schedule_worker(wx->ptp_clock, HZ);
>   }
>   EXPORT_SYMBOL(wx_ptp_reset);
>   
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> index 9199317f7175..c2e58de3559a 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
> @@ -1175,6 +1175,8 @@ struct wx {
>   	u32 tx_hwtstamp_skipped;
>   	u32 tx_hwtstamp_errors;
>   	u32 rx_hwtstamp_cleared;
> +	unsigned long last_overflow_check;
> +	unsigned long last_rx_ptp_check;
>   	unsigned long ptp_tx_start;
>   	seqlock_t hw_tc_lock; /* seqlock for ptp */
>   	struct cyclecounter hw_cc;
> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> index c7944e62838a..ea1d7e9a91f3 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
> @@ -111,6 +111,7 @@ static void ngbe_mac_link_up(struct phylink_config *config,
>   	wr32(wx, WX_MAC_WDG_TIMEOUT, reg);
>   
>   	wx->speed = speed;
> +	wx->last_rx_ptp_check = jiffies;
>   	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
>   		wx_ptp_reset_cyclecounter(wx);
>   }
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index 60e5f3288ad8..7e17d727c2ba 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -222,6 +222,7 @@ static void txgbe_mac_link_up(struct phylink_config *config,
>   	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
>   
>   	wx->speed = speed;
> +	wx->last_rx_ptp_check = jiffies;
>   	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
>   		wx_ptp_reset_cyclecounter(wx);
>   }


