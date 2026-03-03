Return-Path: <netdev+bounces-263204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INU9O/DfpmkPYQAAu9opvQ
	(envelope-from <netdev+bounces-263204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:19:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA721F0164
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA2DA3019FCD
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6C633F5AB;
	Tue,  3 Mar 2026 13:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A71E1946DA;
	Tue,  3 Mar 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543977; cv=none; b=gDhD7EYXecLaveKAtYnRGgNnAeM8hfYHJ/AKMP/Amd7CPbsllGDUV3lCwDA0j5tMFnMznHfj5dUOKHCznd8ynSILO+LXlgy1APPfGoS9GqfPErCrGA0XgrmkqOIkwPxKv+JiABks3/icBFeqVeF7PSUIDx3gsDds4FS5uSIUF/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543977; c=relaxed/simple;
	bh=JeETUM50RezrqM2Bv0bJk4qh+t9LBTzGYmLdO7iEb2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsuYAB0OS7WTvpmr1TZUsAEWRc4X0K9aT2LMXt1s6QG2ZqU/0hoPH/cfWwC29Cg/i8jn5d+SLLuhkY17vXLdq9LB54Lf39GIRiZrZLU1oC2ZkNWCYSko5dpLzGZguM/9WAeSBeTJulyVK7FLccgpylbAESdJgD/egWnLWj0t2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 83BC74C2C37D6F;
	Tue, 03 Mar 2026 14:18:05 +0100 (CET)
Message-ID: <9805389e-9ea4-4e7a-a122-65f733ead33c@molgen.mpg.de>
Date: Tue, 3 Mar 2026 14:18:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4] igb: Retrieve Tx timestamp from BH workqueue
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECA721F0164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263204-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[mpg.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,linux.dev,lists.osuosl.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.818];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linutronix.de:email,mpg.de:email,molgen.mpg.de:mid]
X-Rspamd-Action: no action

Dear Kurt,


Thank you for the patch.

Am 03.03.26 um 12:48 schrieb Kurt Kanzenbach:
> Retrieve Tx timestamp from system BH instead of regular system workqueue.
> 
> The current implementation uses schedule_work() which is executed by the
> system work queue and kworkers to retrieve Tx timestamps. This increases
> latency and can lead to timeouts in case of heavy system load. i210 is
> often used in industrial systems, where timestamp timeouts can be fatal.
> 
> Therefore, switch to the system BH workqueues which are executed directly
> at the end of the IRQ handler.

Thank you for implementing this.

> Tested on Intel i210 and i350 with ptp4l.

It would be great, if you shared the numbers. Did Miroslav already test 
this?

Also, if you could add a comment/summary, that doing this in the IRQ 
path with your theory on why, that’d be great.

> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes in v4:
> - Use BH workqueue (tasklet) instead of doing timestamping in IRQ path (Jakub Kicinski)
> - Link to v3: https://patch.msgid.link/20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de
> 
> Changes in v3:
> - Switch back to IRQ, but for i210 only
> - Keep kworker for all other NICs like i350 (Miroslav)
> - Link to v2: https://lore.kernel.org/r/20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de
> 
> Changes in v2:
> - Switch from IRQ to PTP aux worker due to NTP performance regression (Miroslav)
> - Link to v1: https://lore.kernel.org/r/20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de
> ---
>   drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
>   drivers/net/ethernet/intel/igb/igb_ptp.c  | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ee99fd8fd513..9fd29fedb9f5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -6572,7 +6572,7 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>   			adapter->ptp_tx_skb = skb_get(skb);
>   			adapter->ptp_tx_start = jiffies;
>   			if (adapter->hw.mac.type == e1000_82576)
> -				schedule_work(&adapter->ptp_tx_work);
> +				queue_work(system_bh_wq, &adapter->ptp_tx_work);
>   		} else {
>   			adapter->tx_hwtstamp_skipped++;
>   		}
> @@ -7076,7 +7076,7 @@ static void igb_tsync_interrupt(struct igb_adapter *adapter)
>   
>   	if (tsicr & E1000_TSICR_TXTS) {
>   		/* retrieve hardware timestamp */
> -		schedule_work(&adapter->ptp_tx_work);
> +		queue_work(system_bh_wq, &adapter->ptp_tx_work);
>   	}
>   
>   	if (tsicr & TSINTR_TT0)
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index bd85d02ecadd..7b44f9090631 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -832,7 +832,7 @@ static void igb_ptp_tx_work(struct work_struct *work)
>   		igb_ptp_tx_hwtstamp(adapter);
>   	else
>   		/* reschedule to check later */
> -		schedule_work(&adapter->ptp_tx_work);
> +		queue_work(system_bh_wq, &adapter->ptp_tx_work);
>   }
>   
>   static void igb_ptp_overflow_check(struct work_struct *work)
The diff looks fine.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

