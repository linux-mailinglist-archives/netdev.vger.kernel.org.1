Return-Path: <netdev+bounces-216099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CEB3208F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3054D3B69AC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B152874F2;
	Fri, 22 Aug 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bFGa20Wf"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5360C279DD8
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880041; cv=none; b=dR63ZAw694zPRWuIG5PJww+pzcGwBVIqkYu9UEXJKiDcwgyUShwNrbIoEj2fCo/05Rl0sbgwhbQw2wdEMlr/AkBcA7GrjBztO/rLb3f2jTrFxHzYmvgfHwSFoWfGeDGfKmwvmxcnWJT1CTE5MMl7h44glezCTGzH6MKGWT4b0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880041; c=relaxed/simple;
	bh=bLmUpZ+ZY1CaI4yXsUQZMAQ6DKkJ6xfcA78SgDLAJGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc/74CUZp8KQoyPc5P82CZn0DE3ylxMvlolBqmmpRvc3jGkaaz3fPVKwYZEA9csqN/7wefvFT/5OXHEBd/ErbEMuCX/JQqquEpkZBXLtWGRACZekWlbFcmcSY0KqIPukN2oXdILX/wCnONCJOFi6DQkL6uSDuOEpI4xihLOtyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bFGa20Wf; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27e8fb9f-0e9c-4a0b-b961-64ff9d2f5228@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755880033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76stymdmYGxmCdV+zWc/JNXPWOmvJL9ShI/3xunZrbI=;
	b=bFGa20Wf1ILzNwjk48Iy7jLaeJ07I53X9gl6W/KN8/FmrExc1kDdlmLIRqCCadGn9dXi6b
	Xs2PYBwhru965WlLKiU1BcTbMpfNDp5dz16tjQBKhZ1gNihy3G/nUi0Ye7awFBzFQ5LMIc
	W9KREGbWMWvvffZFSyoJVJeymfAc4Lw=
Date: Fri, 22 Aug 2025 17:27:10 +0100
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/08/2025 08:28, Kurt Kanzenbach wrote:
> The current implementation uses schedule_work() which is executed by the
> system work queue to retrieve Tx timestamps. This increases latency and can
> lead to timeouts in case of heavy system load.
> 
> Therefore, switch to the PTP aux worker which can be prioritized and pinned
> according to use case. Tested on Intel i210.
> 
>    * igb_ptp_tx_work
> - * @work: pointer to work struct
> + * @ptp: pointer to ptp clock information
>    *
>    * This work function polls the TSYNCTXCTL valid bit to determine when a
>    * timestamp has been taken for the current stored skb.
>    **/
> -static void igb_ptp_tx_work(struct work_struct *work)
> +static long igb_ptp_tx_work(struct ptp_clock_info *ptp)
>   {
> -	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
> -						   ptp_tx_work);
> +	struct igb_adapter *adapter = container_of(ptp, struct igb_adapter,
> +						   ptp_caps);
>   	struct e1000_hw *hw = &adapter->hw;
>   	u32 tsynctxctl;
>   
>   	if (!adapter->ptp_tx_skb)
> -		return;
> +		return -1;
>   
>   	if (time_is_before_jiffies(adapter->ptp_tx_start +
>   				   IGB_PTP_TX_TIMEOUT)) {
> @@ -824,15 +824,17 @@ static void igb_ptp_tx_work(struct work_struct *work)
>   		 */
>   		rd32(E1000_TXSTMPH);
>   		dev_warn(&adapter->pdev->dev, "clearing Tx timestamp hang\n");
> -		return;
> +		return -1;
>   	}
>   
>   	tsynctxctl = rd32(E1000_TSYNCTXCTL);
> -	if (tsynctxctl & E1000_TSYNCTXCTL_VALID)
> +	if (tsynctxctl & E1000_TSYNCTXCTL_VALID) {
>   		igb_ptp_tx_hwtstamp(adapter);
> -	else
> -		/* reschedule to check later */
> -		schedule_work(&adapter->ptp_tx_work);
> +		return -1;
> +	}
> +
> +	/* reschedule to check later */
> +	return 1;

do_aux_work is expected to return delay in jiffies to re-schedule the
work. it would be cleaner to use msec_to_jiffies macros to tell how much
time the driver has to wait before the next try of retrieving the
timestamp. AFAIU, the timestamp may come ASAP in this case, so it's
actually reasonable to request immediate re-schedule of the worker by
returning 0.

>   }

