Return-Path: <netdev+bounces-215212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9181B2DAA6
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEC65A51D1
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B92DEA7B;
	Wed, 20 Aug 2025 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGIX5nXG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A120E6E2;
	Wed, 20 Aug 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688520; cv=none; b=asFrRsMUr7sbRWiW8tAX98VlLKBtTM0HLxXtH3oGfyUqM4WafuXlfD/0sq+bFecwccXl54c4csgcdE2i/YcywB+h8TFNVo2ywgpds+57bzYRdalMOB3cJypvQ7fakrcMFHCyG9coZ/Mm0FsqBO3vWqVMk5uvRMIo7jlfIofMTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688520; c=relaxed/simple;
	bh=+W5AE45oSDe7SU8yU9qVj7OKm404/o+aE91+1djleGU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EESc0hNZR06qUGwTKdKXmVUr+7r6NcPJDWIYGWG2zmWyG59WyqnUtC5hFJrDXM6HHdkKxGfBPBRH966++1zryJRH04blxXn1+P3PML77l9tYqJxT+WN+R0h1hQ3LYd2vM5Go+XZob+KySmXkpP7td2gvhimTatF0EDy8QFxAWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGIX5nXG; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e8705415ceso742640285a.1;
        Wed, 20 Aug 2025 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755688515; x=1756293315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oWQdWZSc5tmQO8bkIABhUr/IMXvm9MhxYA+bjA7Fvc=;
        b=nGIX5nXG9R4FDfDfXBXbRhs8/446bAycHiaQ8PHluE8f72XL+SiKJoLDtmhwaZ3bv8
         UPHuvmkFDDTd00Uo4aRuOSIHgIh5w25TdHQYbUjhnlQywNyKPYjdwLpyEhbRFI28shog
         xXeEdLXcOVQK4v66cILYCNgByo8khOQLIx9/pQ5j5luZfgvJDcL6KWVUp6EB+ZBvFpnC
         UA9hW7lFyZl9vThTzmkdcvHo5mS+OkzboLOtmRpdALBE2+e7l6DaHSvDvZn0A/t5Mm1+
         dQxHLgEOobC8qcsRuoMLTqCK9WJZ5wYhvKX6s23KvI7i1o1dtRAU3Aeb/+kau4nkEofU
         1psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688515; x=1756293315;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2oWQdWZSc5tmQO8bkIABhUr/IMXvm9MhxYA+bjA7Fvc=;
        b=fO6/XWo1rgxZV6XHT3O6Wq/tHFbVcuQEahn7GzkT4pHs+XMuLr5D7P0MHDeP1PYOtk
         rl2RESEVvS+/gppvl2Njjj5mdoFMaSIVF8HCK3sg1joxZ3uDxhaVSfZpUezJtPW7DWBS
         3VgmvVSWREOmhwEpoapbIrUyvj9MD6zMBO7HWmA06877tIJNt2ZkDJm7P+XItP7fHthH
         t2VbihbLT73oOf/d/2l0nP1G5LL/bsO6iGblRneE43c0H5SeJUL/QbWXzVHm+9OMeIUr
         8wiNgo54fxMhl72os9aAOMYZDAdTKW7rU6Vys+ItbSAQzBTokmFiyuIlG6tYJPEfbho8
         5m3g==
X-Forwarded-Encrypted: i=1; AJvYcCX41HSMXPwWAGtUkovNl1X4mKsowcH1ueGUcPz9072egrXGmHUFqjvuKwkXi+bx+raFsdUkIJrAMq9T95U=@vger.kernel.org, AJvYcCXoCPeL4CLGauPmTNLH6pp4mMKgOx0ijxBBpmPenxEXFINKe0/Ot0blnRo8c7AAJ7ow3FZr8Cvv@vger.kernel.org
X-Gm-Message-State: AOJu0YyJcGiubdsAF9iEscuky5qb4LmVhQo/6Xvvtv1RRyk863F+iZnj
	7H+uqKMyghzk/jp0rMP8rYKnrm9/OY1DeyxsMJwlA1jo0WwTtfG9Ac0Y
X-Gm-Gg: ASbGncus6oK398dMppum95sd8SSdtszii5GGRpD6lFu33qQygDTKPF/vP9wtzlsoSL2
	78B9NoLQ+VkchpczkYnVwX0T5Dc/c9XOmTbd+/v5frJAlaCkIz5Tq5W9rk59Ybq3e6Bnw2sQrgk
	EiJDITNyLoMdVnVz/iqk0p3WXe08f3ngzZALif+fJu1aakDClb1gp+WCopFod7dqSMs361H9MN4
	53UloDWWE1NZwOn/iBcVlrV3lul1kCJQAlsXp8JbedqIe/JR5jzdRmm6py/wfuXy8sUyORJf4Hy
	rMMczuM74xsKTcooyeKnmVO4taMdCOZK4PnsFOGbAkdI7KcHV2pMrRHtvJV/tu8bjzZVtTWGXm5
	964lMmWdTa6Z8ajIoHDhx0dM+tWdwsKO9U5bgTZ+kRZbXzqqPgqJUaF7Hxv7F3h2detNN6A==
X-Google-Smtp-Source: AGHT+IHf54vC6mPUVtNOrMXot9s6L1dtsKEH6w7hlIAIekcOcAfTdeYb2sANLTKt6wdnh3wKvVclfw==
X-Received: by 2002:a05:620a:2556:b0:7e6:992c:645c with SMTP id af79cd13be357-7e9fca9a614mr299513585a.22.1755688514815;
        Wed, 20 Aug 2025 04:15:14 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e195e49sm939068185a.43.2025.08.20.04.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:15:14 -0700 (PDT)
Date: Wed, 20 Aug 2025 07:15:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xin Zhao <jackzxcui1989@163.com>, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 ferenc@fejes.dev
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Xin Zhao <jackzxcui1989@163.com>
Message-ID: <willemdebruijn.kernel.15a62b0950330@gmail.com>
In-Reply-To: <20250820092925.2115372-1-jackzxcui1989@163.com>
References: <20250820092925.2115372-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v6] net: af_packet: Use hrtimer to do the retire
 operation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Xin Zhao wrote:
> In a system with high real-time requirements, the timeout mechanism of
> ordinary timers with jiffies granularity is insufficient to meet the
> demands for real-time performance. Meanwhile, the optimization of CPU
> usage with af_packet is quite significant. Use hrtimer instead of timer
> to help compensate for the shortcomings in real-time performance.
> In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
> enough, with fluctuations reaching over 8ms (on a system with HZ=250).
> This is unacceptable in some high real-time systems that require timely
> processing of network packets. By replacing it with hrtimer, if a timeout
> of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> 3 ms.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> 
> ---
> Changes in v6:
> - Use hrtimer_is_queued instead to check whether it is within the callback function.
>   So do not need to add 'bool callback' parameter to _prb_refresh_rx_retire_blk_timer
>   as suggested by Willem de Bruijn;
> - Do not need local_irq_save and local_irq_restore to protect the race of the timer
>   callback running in softirq context or the open_block from tpacket_rcv in process
>   context
>   as suggested by Willem de Bruijn;
> 
> Changes in v5:
> - Remove the unnecessary comments at the top of the _prb_refresh_rx_retire_blk_timer,
>   branch is self-explanatory enough
>   as suggested by Willem de Bruijn;
> - Indentation of _prb_refresh_rx_retire_blk_timer, align with first argument on
>   previous line
>   as suggested by Willem de Bruijn;
> - Do not call hrtimer_start within the hrtimer callback
>   as suggested by Willem de Bruijn
>   So add 'bool callback' parameter to _prb_refresh_rx_retire_blk_timer to indicate
>   whether it is within the callback function. Use hrtimer_forward_now instead of
>   hrtimer_start when it is in the callback function and is doing prb_open_block.
> - Link to v5: https://lore.kernel.org/all/20250819091447.1199980-1-jackzxcui1989@163.com/
> 
> Changes in v4:
> - Add 'bool start' to distinguish whether the call to _prb_refresh_rx_retire_blk_timer
>   is for prb_open_block. When it is for prb_open_block, execute hrtimer_start to
>   (re)start the hrtimer; otherwise, use hrtimer_forward_now to set the expiration
>   time as it is more commonly used compared to hrtimer_set_expires.
>   as suggested by Willem de Bruijn;
> - Delete the comments to explain why hrtimer_set_expires(not hrtimer_forward_now)
>   is used, as we do not use hrtimer_set_expires any more;
> - Link to v4: https://lore.kernel.org/all/20250818050233.155344-1-jackzxcui1989@163.com/
> 
> Changes in v3:
> - return HRTIMER_NORESTART when pkc->delete_blk_timer is true
>   as suggested by Willem de Bruijn;
> - Drop the retire_blk_tov field of tpacket_kbdq_core, add interval_ktime instead
>   as suggested by Willem de Bruijn;
> - Add comments to explain why hrtimer_set_expires(not hrtimer_forward_now) is used in
>   _prb_refresh_rx_retire_blk_timer
>   as suggested by Willem de Bruijn;
> - Link to v3: https://lore.kernel.org/all/20250816170130.3969354-1-jackzxcui1989@163.com/
> 
> Changes in v2:
> - Drop the tov_in_msecs field of tpacket_kbdq_core added by the patch
>   as suggested by Willem de Bruijn;
> - Link to v2: https://lore.kernel.org/all/20250815044141.1374446-1-jackzxcui1989@163.com/
> 
> Changes in v1:
> - Do not add another config for the current changes
>   as suggested by Eric Dumazet;
> - Mention the beneficial cases 'HZ=100 or HZ=250' in the changelog
>   as suggested by Eric Dumazet;
> - Add some performance details to the changelog
>   as suggested by Ferenc Fejes;
> - Delete the 'pkc->tov_in_msecs == 0' bounds check which is not necessary
>   as suggested by Willem de Bruijn;
> - Use hrtimer_set_expires instead of hrtimer_start_range_ns when retire timer needs update
>   as suggested by Willem de Bruijn. Start the hrtimer in prb_setup_retire_blk_timer;
> - Just return HRTIMER_RESTART directly as all cases return the same value
>   as suggested by Willem de Bruijn;
> - Link to v1: https://lore.kernel.org/all/20250813165201.1492779-1-jackzxcui1989@163.com/
> - Link to v0: https://lore.kernel.org/all/20250806055210.1530081-1-jackzxcui1989@163.com/
> ---
>  net/packet/af_packet.c | 40 +++++++++++++++++++++++-----------------
>  net/packet/diag.c      |  2 +-
>  net/packet/internal.h  |  5 ++---
>  3 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a7017d7f0..9b13939a6 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -203,8 +203,8 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *,
>  static int prb_queue_frozen(struct tpacket_kbdq_core *);
>  static void prb_open_block(struct tpacket_kbdq_core *,
>  		struct tpacket_block_desc *);
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *);
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *);
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *);
> +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *, bool);
>  static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hdr *);
>  static void prb_clear_rxhash(struct tpacket_kbdq_core *,
>  		struct tpacket3_hdr *);
> @@ -581,7 +581,7 @@ static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
>  
>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
> -	timer_delete_sync(&pkc->retire_blk_timer);
> +	hrtimer_cancel(&pkc->retire_blk_timer);
>  }
>  
>  static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
> @@ -603,9 +603,8 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
>  	struct tpacket_kbdq_core *pkc;
>  
>  	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> -	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> -		    0);
> -	pkc->retire_blk_timer.expires = jiffies;
> +	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
>  }
>  
>  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> @@ -672,11 +671,10 @@ static void init_prb_bdqc(struct packet_sock *po,
>  	p1->last_kactive_blk_num = 0;
>  	po->stats.stats3.tp_freeze_q_cnt = 0;
>  	if (req_u->req3.tp_retire_blk_tov)
> -		p1->retire_blk_tov = req_u->req3.tp_retire_blk_tov;
> +		p1->interval_ktime = ms_to_ktime(req_u->req3.tp_retire_blk_tov);
>  	else
> -		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
> -						req_u->req3.tp_block_size);
> -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> +		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
> +						req_u->req3.tp_block_size));
>  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
>  	rwlock_init(&p1->blk_fill_in_prog_lock);
>  
> @@ -689,10 +687,14 @@ static void init_prb_bdqc(struct packet_sock *po,
>  /*  Do NOT update the last_blk_num first.
>   *  Assumes sk_buff_head lock is held.
>   */
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> +					     bool start)
>  {
> -	mod_timer(&pkc->retire_blk_timer,
> -			jiffies + pkc->tov_in_jiffies);
> +	if (start && !hrtimer_is_queued(&pkc->retire_blk_timer))
> +		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> +			      HRTIMER_MODE_REL_SOFT);
> +	else
> +		hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);

Is the hrtimer still queued when prb_retire_rx_blk_timer_expired
fires? Based on the existence of hrtimer_forward_now, I assume so. But
have not checked yet. If so, hrtimer_is_queued alone suffices to
detect the other callstack from tpacket_rcv where hrtimer_start is
needed. No need for bool start?

>  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
>  }

