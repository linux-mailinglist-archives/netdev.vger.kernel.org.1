Return-Path: <netdev+bounces-213997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6978B27A67
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479773AE2A2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6B027C84E;
	Fri, 15 Aug 2025 07:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22F42056
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244548; cv=none; b=p7zp8t7n83N70j+cGV5gv7uGbd8kn0ZbLu4IyI1it/cW5EXRXWdAEP7s60xwi+OQtzq7+hpAjrlycex2Xq9ZtZI8eYjXMqGbGgtOgnjphCSXISxPqsJNb7AhJFY8WNTdZxY4r8pvI62pRzb7rG8KDxj+uRiOPkruyoAjy/axjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244548; c=relaxed/simple;
	bh=lQngVI5DZaF7XF1CEYapGCCtTDBoImAEh47uU0RStEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kyf/LWITrxCCbHOxVeolqOsltlor+49vAxaTsQ5XOofRT1szzy0SSloflazK1Hq2GexiMndsUVWSkvMCUc+e64ECAce72XfRaw6f+twu2NN1GZRt/JlHxQ8l3if8h/6nkZ+AIShq9E/vBeN0SmL3/LJFoOrFFG52fI0oe0Wpd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.1.9] (dynamic-077-183-003-144.77.183.pool.telefonica.de [77.183.3.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C6BC961E647AC;
	Fri, 15 Aug 2025 09:55:00 +0200 (CEST)
Message-ID: <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>
Date: Fri, 15 Aug 2025 09:55:00 +0200
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
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kurt,


Thank you for your patch.

Am 15.08.25 um 08:50 schrieb Kurt Kanzenbach:
> Retrieve Tx timestamp directly from interrupt handler.
> 
> The current implementation uses schedule_work() which is executed by the
> system work queue to retrieve Tx timestamps. This increases latency and can
> lead to timeouts in case of heavy system load.
> 
> Therefore, fetch the timestamp directly from the interrupt handler.
> 
> The work queue code stays for the Intel 82576. Tested on Intel i210.

Excuse my ignorance, I do not understand the first sentence in the last 
line. Is it because the driver support different models? Why not change 
it for Intel 82576 too?

Do you have a reproducer for the issue, so others can test.

> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>   drivers/net/ethernet/intel/igb/igb.h      |  1 +
>   drivers/net/ethernet/intel/igb/igb_main.c |  2 +-
>   drivers/net/ethernet/intel/igb/igb_ptp.c  | 22 ++++++++++++++++++++++
>   3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index c3f4f7cd264e9b2ff70f03b580f95b15b528028c..102ca32e8979fa3203fc2ea36eac456f1943cfca 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -776,6 +776,7 @@ int igb_ptp_hwtstamp_get(struct net_device *netdev,
>   int igb_ptp_hwtstamp_set(struct net_device *netdev,
>   			 struct kernel_hwtstamp_config *config,
>   			 struct netlink_ext_ack *extack);
> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter);
>   void igb_set_flag_queue_pairs(struct igb_adapter *, const u32);
>   unsigned int igb_get_max_rss_queues(struct igb_adapter *);
>   #ifdef CONFIG_IGB_HWMON
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index a9a7a94ae61e93aa737b0103e00580e73601d62b..8ab6e52cb839bbb698007a74462798faaaab0071 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -7080,7 +7080,7 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
>   
>   	if (tsicr & E1000_TSICR_TXTS) {
>   		/* retrieve hardware timestamp */
> -		schedule_work(&adapter->ptp_tx_work);
> +		igb_ptp_tx_tstamp_event(adapter);
>   	}
>   
>   	if (tsicr & TSINTR_TT0)
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index a7876882aeaf2b2a7fb9ec6ff5c83d8a1b06008a..20ecafecc60557353f8cc5ab505030246687c8e4 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -796,6 +796,28 @@ static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
>   	return 0;
>   }
>   
> +/**
> + * igb_ptp_tx_tstamp_event
> + * @adapter: pointer to igb adapter
> + *
> + * This function checks the TSYNCTXCTL valid bit and stores the Tx hardware
> + * timestamp at the current skb.
> + **/
> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter)
> +{
> +	struct e1000_hw *hw = &adapter->hw;
> +	u32 tsynctxctl;
> +
> +	if (!adapter->ptp_tx_skb)
> +		return;
> +
> +	tsynctxctl = rd32(E1000_TSYNCTXCTL);
> +	if (WARN_ON_ONCE(!(tsynctxctl & E1000_TSYNCTXCTL_VALID)))
> +		return;
> +
> +	igb_ptp_tx_hwtstamp(adapter);
> +}
> +
>   /**
>    * igb_ptp_tx_work
>    * @work: pointer to work struct

The diff looks fine.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

