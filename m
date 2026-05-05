Return-Path: <netdev+bounces-284414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDHCNWLx+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:32:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 902B84CE8F0
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13C07306C20F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2593477992;
	Tue,  5 May 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EOznjxZj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA57388371
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987659; cv=none; b=ojIpQgHmAH28mFG+fv6qe2OqbQbPS3KwOcGcjQVlN6St7J6bNzYkiciPa2Qq1V2biu5CXk+vVpv77+VS/fwFidJ3dvINoZH+TbZbW7MfPiBVIpXW4BoQW91VrKdfQAShnE0gA99Pl/HgsbCOGvLSFp1hLiYPjGj6geUCi1KngrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987659; c=relaxed/simple;
	bh=YPthGmBagOjav013lu+wSW9xMVwN5Gu+hGSDUNENwvE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRaGEIdeoxK1NLHW9i2cANl6BwqAZNnRUr4tBQRxspAvRnJPI6PTVZ2NP9F7u6VUJJ9NuCdR4C7VqMKUzXkNq+vuE/Rg+edouCKbLr1/NRnsW4ZzF0aLy8fPz7WgwE4t/XFjTrvf3qYBdjC/EMehF8qNZ6R8zg/sLX3aDVCuzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EOznjxZj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-444826c16ffso5073564f8f.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777987656; x=1778592456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lraFz6oBhP7MmXTOPo6oBPAEVJFopwF4+HMSlIJwUjg=;
        b=EOznjxZjTkWhcFqAP+iKuD8RXYBKGEVi3PG5UCauKz+BYjcyytRhCnD+MSR6Zf3cDd
         Bfoz1AHDgwUiyKara4RCTNZMOoE03SkkIFS6ZeTzEAFwzkc3cjdXaxW3YQf+VYoiqv6K
         CURS9IdI9qbCyDpxFn74UM31m60vTGrYwTke+eUSuasjpTuhoiut4JEexFcMAVMG3r3L
         oAxPhxbc1qvPfx7Fo9D3XZ1CX4CDIiEEmVFYd5Q91boaLtsBTaU9b32SwtP+U6bJRATn
         ljIYdmBKJEcZ5yKA2+EYwOTorhcN0s6HH8uVHKDtJ7Y8jjzNva5vG4oHecnuM2N3RinO
         M7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987656; x=1778592456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lraFz6oBhP7MmXTOPo6oBPAEVJFopwF4+HMSlIJwUjg=;
        b=B4mUxFs5B/npYgqqPbDy1bJDYBpQYEvuXSFF45hIc2bpyrqPz5XTWwLMguOEKI61yF
         T/pYQE/YgLFxsATMPRTeDJANp3/Ot5IHai6DFWQLtr8O3M+fkkOLwlwjuaNONWAZXnxD
         iM1DmSzQJ++hfbtGcjYBXGYCrpEn5Mc4dk6Hs7/NqLs54wa30pShy14bwlMyzaVTQxBj
         9xn1ibAI/lKSGyR7vassTi5FWGMssstq7Nuk/YJzI2Y367bNK6cTOytpUcCZZqkRIrr4
         CxbUGVBtDz0vzhKQQT10c7ICtKXjpEPRWp61DzKc68eycv7S0ZhPI1Pozf1vH8Qo+DW5
         vq0Q==
X-Gm-Message-State: AOJu0YyHO2RxxyXnni1tM4jCeoEcjLx5Coly72A697hlWnbgRW0RQll5
	vdwhV0DrMJ8X+DpNV8SByxLl2Px+krUSQu/q8V2SyI42KEiMRo9Fpzn/aGUCzRgvGzE=
X-Gm-Gg: AeBDiev0DZ3hclIyl58ZukJNdWZMVbSy5iwAtu315f2dMByYfVXWn95CYActTEhrMKu
	VVrd8IGjAnyiSeG35jkUaHTub9Kjz1r0mEQ45XUhtcyAObKxyf08e9rDYLzKfxlPssUsSr1vgaz
	G8ksF2Sq3qStxKWNuoGnCZ+rcMOFoz/G9P/1zc6Dwom7BjJXl4xWkzV7p/fULILHewX8WCKPn8A
	gERuLgSOOTgK8R+wgRtAxe2Z1JqhSfpJS1P4bsgb0P2ErVYat7D6uXjnw2yZAyIckaXv+DvWzNm
	EW6Trk5StfwkgwulopNJq4YAwsyCLqvqedyRBjLOpKo2QSOCfp9DMfQx1FtuoPhrGXwAvavwtjh
	7pK7YQxu+rchXH8WK7ksmloHkjPQofxnPKxYymj7X5DeUH4D78y7A0m+f1rUnuo43UuRENxS4e2
	bqVHciMOcmeSIy1/9PZDDYGFjhG4K433ByszvRQkyhoooc1RXs+/GlPkCSSapAdAbAhstfkm3R+
	beN9CQryNCfZwkcpg==
X-Received: by 2002:a05:6000:18a5:b0:449:c5e2:a8b7 with SMTP id ffacd0b85a97d-450060571bemr5745163f8f.30.1777987656056;
        Tue, 05 May 2026 06:27:36 -0700 (PDT)
Received: from localhost (host-79-47-155-212.retail.telecomitalia.it. [79.47.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960022sm4650340f8f.26.2026.05.05.06.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:27:35 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 5 May 2026 15:30:51 +0200
To: Lukasz Raczylo <lukasz@raczylo.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [RFC PATCH net-next 3/3] net: macb: add TX stall watchdog as
 defence-in-depth safety net
Message-ID: <afnxC-Lk5LELsm42@apocalypse>
References: <cover.1777064117.git.lukasz@raczylo.com>
 <c0469642f42ada85d91a8a685eb7c0e04cb99131.1777064117.git.lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0469642f42ada85d91a8a685eb7c0e04cb99131.1777064117.git.lukasz@raczylo.com>
X-Rspamd-Queue-Id: 902B84CE8F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284414-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:dkim,raczylo.com:email,launchpad.net:url]

Hi Lukasz,

On 23:38 Fri 24 Apr     , Lukasz Raczylo wrote:
> Patches 1/3 and 2/3 address two candidate races that could lead
> to a TCOMP completion being missed on PCIe-attached macb
> instances.  This patch adds a defence-in-depth safety net, in
> case a further race remains that we have not identified.
> 
> The watchdog is a per-queue delayed_work that runs once per
> second.  It snapshots queue->tx_tail; if the ring is non-empty
> (queue->tx_head != queue->tx_tail) and tx_tail has not advanced
> since the previous tick, it calls macb_tx_restart().
> 
> No new recovery logic is introduced.  macb_tx_restart() already
> exists in this file, is correctly locked (tx_ptr_lock, bp->lock),
> and verifies that the hardware's TBQP is behind the driver's
> head index before re-asserting TSTART.  On a healthy ring it is
> a no-op at the hardware level; the watchdog only supplies the
> missing trigger.
> 
> On a healthy queue the per-tick cost is one spin_lock_irqsave()
> / spin_unlock_irqrestore() and one branch.  The delayed_work is
> only scheduled between macb_open() and macb_close(), and is
> cancelled synchronously on close.
> 
> Context for submission: on our 24-node Raspberry Pi 5 fleet,
> before this series, an out-of-band user-space watchdog
> (monitoring tx_packets from /sys/class/net/.../statistics and
> toggling the link down/up when it froze) was required to keep
> nodes usable.  We include this kernel-side watchdog as a cleaner
> in-kernel equivalent for any residual stall that patches 1 and
> 2 do not cover.  We are willing to drop this patch if the view
> is that 1 and 2 should stand alone.
> 
> Link: https://github.com/cilium/cilium/issues/43198
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
> Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
> ---
>  drivers/net/ethernet/cadence/macb.h      |  5 ++
>  drivers/net/ethernet/cadence/macb_main.c | 59 ++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 2de56017e..9115f2b47 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -1278,6 +1278,11 @@ struct macb_queue {
>  	dma_addr_t		tx_ring_dma;
>  	struct work_struct	tx_error_task;
>  	bool			txubr_pending;
> +
> +	/* TX stall watchdog -- see macb_tx_stall_watchdog() in macb_main.c */
> +	struct delayed_work	tx_stall_watchdog_work;
> +	unsigned int		tx_stall_last_tail;
> +
>  	struct napi_struct	napi_tx;
>  
>  	dma_addr_t		rx_ring_dma;
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ea231b1c5..ea2306ef7 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -2002,6 +2002,59 @@ static int macb_tx_poll(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> +#define MACB_TX_STALL_INTERVAL_MS	1000
> +
> +/*
> + * TX stall watchdog.
> + *
> + * Defence-in-depth against lost TCOMP interrupts.  macb already has a
> + * recovery chain (tx_pending -> txubr_pending -> macb_tx_restart())
> + * that fires on TCOMP; if TCOMP itself is lost the TX ring stalls
> + * silently until something else kicks TSTART.  This watchdog runs
> + * once per second per queue, snapshots tx_tail, and calls
> + * macb_tx_restart() if the ring is non-empty and tx_tail has not
> + * advanced since the previous tick.
> + *
> + * macb_tx_restart() already checks the hardware's TBQP against the
> + * driver's head index before re-asserting TSTART, so on a healthy
> + * ring this is a no-op at the hardware level.  The watchdog only
> + * adds the missing trigger.
> + */
> +static void macb_tx_stall_watchdog(struct work_struct *work)
> +{
> +	struct macb_queue *queue = container_of(to_delayed_work(work),
> +						struct macb_queue,
> +						tx_stall_watchdog_work);
> +	struct macb *bp = queue->bp;
> +	unsigned int cur_tail, cur_head;
> +	bool stalled = false;
> +	unsigned long flags;
> +
> +	if (!netif_running(bp->dev))
> +		return;
> +
> +	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
> +	cur_tail = queue->tx_tail;
> +	cur_head = queue->tx_head;
> +	if (cur_head != cur_tail &&
> +	    cur_tail == queue->tx_stall_last_tail)
> +		stalled = true;
> +	else
> +		queue->tx_stall_last_tail = cur_tail;
> +	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
> +
> +	if (stalled) {
> +		netdev_warn_once(bp->dev,
> +				 "TX stall detected on queue %u (tail=%u head=%u); re-kicking TSTART\n",
> +				 (unsigned int)(queue - bp->queues),
> +				 cur_tail, cur_head);
> +		macb_tx_restart(queue);
> +	}
> +
> +	schedule_delayed_work(&queue->tx_stall_watchdog_work,
> +			      msecs_to_jiffies(MACB_TX_STALL_INTERVAL_MS));
> +}
> +
>  static void macb_hresp_error_task(struct work_struct *work)
>  {
>  	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
> @@ -3190,6 +3243,9 @@ static int macb_open(struct net_device *dev)
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		napi_enable(&queue->napi_rx);
>  		napi_enable(&queue->napi_tx);
> +		queue->tx_stall_last_tail = queue->tx_tail;
> +		schedule_delayed_work(&queue->tx_stall_watchdog_work,
> +				      msecs_to_jiffies(MACB_TX_STALL_INTERVAL_MS));
>  	}
>  
>  	macb_init_hw(bp);
> @@ -3240,6 +3296,7 @@ static int macb_close(struct net_device *dev)
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		napi_disable(&queue->napi_rx);
>  		napi_disable(&queue->napi_tx);
> +		cancel_delayed_work_sync(&queue->tx_stall_watchdog_work);
>  		netdev_tx_reset_queue(netdev_get_tx_queue(dev, q));
>  	}
>  
> @@ -4802,6 +4859,8 @@ static int macb_init_dflt(struct platform_device *pdev)
>  		}
>  
>  		INIT_WORK(&queue->tx_error_task, macb_tx_error_task);
> +		INIT_DELAYED_WORK(&queue->tx_stall_watchdog_work,
> +				  macb_tx_stall_watchdog);
>  		q++;
>  	}
>  
> -- 
> 2.53.0
>

I've applied all three patches to v6.19.10 changing netdev_warn_once() from this one to
netdev_warn() and it the "TX stall" warning appears several time. So it seems that there
could be another cause escaping the filtering in the first two patches.

Interestingly enough, running the same tests after substituing the entire macb driver with
the downstream version works ok.

Not sure how to interpret these results since they seem to be the opposite of yours.
More investigation is ongoing from my side.

Thanks,
Andrea

