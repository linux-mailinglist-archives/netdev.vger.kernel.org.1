Return-Path: <netdev+bounces-214494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0510B29DEA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CA05E63B8
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E100730EF61;
	Mon, 18 Aug 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViuaguTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31BF30DED6;
	Mon, 18 Aug 2025 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509350; cv=none; b=EhnRBLbtTXgdBUUZpP9uZPF73tOH9L2VUIT/QHijVLyTTNnwpfKdJBjqx3RPB5SBeL385gBnnob6pNDRhtXjbYe2L7t1QiLkeOavb8dgUcSbqwZX8aMM4KsvWbpfqYfeW3XcI0A5d2duhI2CIsR/mxaAjgS5/FJFCWFQuBhQfCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509350; c=relaxed/simple;
	bh=/1mj/gl8qXlZckJkiI3O0ol5G1mFeQX1eDFll7fc/tA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=evw2NoMe5Du2P98d1nhB3FRxQGzGjgY2Cjh7YKhbt79arXFQEq9YpVOfIxDc3hpW9woiDSnNa1sQXOzw0ub6t8hvg9+jpEbicdsZalzrMl4Eq3cBjZF4nE6KsJlInuSm+jqVX8lAExSogt+l9ULEeOnOrVy4sSGqgx0g6nqpgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViuaguTJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e87068760bso479836785a.3;
        Mon, 18 Aug 2025 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509348; x=1756114148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seaHbWvJFrWGoMtI8mST65eg55ApuDSTJZsw8niTodE=;
        b=ViuaguTJEZzMRk6nAgROGw769rTzeMq0rzniW3ADyqLBrVaaLp4GPKm5zaLeUIWtJ8
         MaS2Gr7/ER1bl1PHJOFyUTLJpBkQwSoEQo4usG7fMzxi4zhj85o7xRCghzrdCdfTNmy2
         wdHHJgXV95NfWww9FZCZt2hkbVXZLXkKnhfjqu9TDITpwxkb1WpFWyGt4KEpIffH9hlE
         bQ+ix4tTJyzZZank/6sZk8fYoTyGcyWG7zxTDcKblgCAK2nkjgEOYA3iZm4gywnz0KnY
         Ef4Oen4nfVmWLdj//kvi+HBsY8oTUrN3nGoH1gkKc8FXjdU8HdkobF1UOJjwsOHcGLKN
         /qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509348; x=1756114148;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=seaHbWvJFrWGoMtI8mST65eg55ApuDSTJZsw8niTodE=;
        b=OYVz1myDmiMjkrPWTBy3QEliCFhcut7YFmOpRDLovqE6FkV4CCTvX1/IlBmC1Y7jh9
         87dhtCDpEuF5DreAxp5b0W7QyyminQ5pobH91ph/DmoDuTZbI9YzWwSoQDhNR82NojSv
         LrzerLWFzUdwpphSh9nWJhIMFRnGyI2EHs0yqu0hUUDyV948wmx+UGoI+4LFKLnaXYu9
         hqFbhi+EcAUxdbVu7YOozO3eXkaCkelHttIWetcn8b01QBHd66Uh5iGzp3hHoj8WmXKQ
         TbUpwt04ziljexCDasOqhQpuS7kXZl33rzOrWgRPqMKkTc53ImcotHAKc4U9E6dEvrDI
         uz6A==
X-Forwarded-Encrypted: i=1; AJvYcCUCqOZFYk4TU1NB9jStmyxMzHF53eRNGtr3Xfc3G7oJNiAM5Jb0Pli6NDpoanxr3jFQyR1wZ2/GcK4JEb4=@vger.kernel.org, AJvYcCW2WoP84kiWBc96prR6o7eFd70iMB41ktSo39E++dIama9tXey3CciQ/SS1maTvCm1dJiL2FH1r@vger.kernel.org
X-Gm-Message-State: AOJu0YzCv5XrvuTQvzx7phBXPaPTuzEgpAZvBFIuUbbsJYLdjc8cf5lT
	bgYALmUDyE/JVSwk9I7jbmDDNbVq8mFuktu9QW65oENVmz6+VBtyzkWzdLY9mglM
X-Gm-Gg: ASbGncsCYkdNrJib27mPZgFuDqmPTzvZUUWXFndIJK54LcLZ6BT/QVZxPy8WM9w0Fn1
	NLvVF9UodhkrRBHXqhh8mSo0taNxmi4yltWDDzwDDgMme1WATO0lF5CNMC0S+xERHQA5kF9g6H+
	NDvygM1CukLew1d+ITH+fU61ZNXdy9ZjjObrp2oUMkY6k8H8OjtwklWTRS505XiQImYnlKWPG+Q
	iVKW+328gvXMagJlRiMrlrbecEFlsnfMTgjmNAAcVVeJY4asHzitgbB3Xeu8ys/a1hRnseJ1UNt
	jxfFkvgj2ix4VcGan78ciIebjvuv/7SW9ne3HWhe8DxQKLQhmDentc8PhuXGGe2Qf0QJPPpelok
	thqdPhys6xSCUB/yTFejIxnXZvr6RZoJk8/OSEeC01ZzD0FlmVywpzmXYZhf7Qn+u3Rid3fO271
	4f8QQX
X-Google-Smtp-Source: AGHT+IFpkHaTIiuxYFoQ/IYth6ox3NqZk5IJD+GFdiR08+9X9+aaQcf3C/tNSWdl7MohDC7zkDsmgA==
X-Received: by 2002:a05:620a:31a2:b0:7d4:49fa:3c59 with SMTP id af79cd13be357-7e87df92553mr1362019985a.15.1755509347564;
        Mon, 18 Aug 2025 02:29:07 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e070b0csm553875185a.35.2025.08.18.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:29:07 -0700 (PDT)
Date: Mon, 18 Aug 2025 05:29:06 -0400
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
Message-ID: <willemdebruijn.kernel.1ebfd7c0240d1@gmail.com>
In-Reply-To: <20250818052441.172802-1-jackzxcui1989@163.com>
References: <20250818052441.172802-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v4] net: af_packet: Use hrtimer to do the retire
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
> Changes in v4:
> - Add 'bool start' to distinguish whether the call to _prb_refresh_rx_retire_blk_timer
>   is for prb_open_block. When it is for prb_open_block, execute hrtimer_start to
>   (re)start the hrtimer; otherwise, use hrtimer_set_expires to update the expiration
>   time of the hrtimer
>   as suggested by Willem de Bruijn;
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
>  net/packet/af_packet.c | 52 ++++++++++++++++++++++++++++--------------
>  net/packet/diag.c      |  2 +-
>  net/packet/internal.h  |  5 ++--
>  3 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a7017d7f0..5a1e80185 100644
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
> @@ -688,11 +686,27 @@ static void init_prb_bdqc(struct packet_sock *po,
>  
>  /*  Do NOT update the last_blk_num first.
>   *  Assumes sk_buff_head lock is held.
> + *  We only need to (re)start an hrtimer in prb_open_block.
> + *  Otherwise, we just need to update the expiration time of the hrtimer.

"We" don't do anything in the middle of a computation. Anyway, branch is
self explanatory enough, can drop comment.

>   */
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> +		bool start)

Indentation, align with first argument on previous line

>  {
> -	mod_timer(&pkc->retire_blk_timer,
> -			jiffies + pkc->tov_in_jiffies);
> +	if (start)
> +		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> +			      HRTIMER_MODE_REL_SOFT);

It's okay to call this from inside a timer callback itself and return
HRTIMER_RESTART? I don't know off the top of my head.

> +	else
> +		/* We cannot use hrtimer_forward_now here because the function
> +		 * _prb_refresh_rx_retire_blk_timer can be called not only when
> +		 * the retire timer expires, but also when the kernel logic for
> +		 * receiving network packets detects that a network packet has
> +		 * filled up a block and calls prb_open_block to use the next
> +		 * block. This can lead to a WARN_ON being triggered in
> +		 * hrtimer_forward_now when it checks if the timer has already
> +		 * been enqueued.
> +		 */

As discussed, this will be changed in v5.

> +		hrtimer_set_expires(&pkc->retire_blk_timer,
> +				    ktime_add(ktime_get(), pkc->interval_ktime));
>  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
>  }
>  
> @@ -719,8 +733,9 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>   * prb_calc_retire_blk_tmo() calculates the tmo.
>   *
>   */
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
>  {
> +	enum hrtimer_restart ret = HRTIMER_RESTART;
>  	struct packet_sock *po =
>  		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
>  	struct tpacket_kbdq_core *pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> @@ -732,8 +747,10 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
>  	frozen = prb_queue_frozen(pkc);
>  	pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
>  
> -	if (unlikely(pkc->delete_blk_timer))
> +	if (unlikely(pkc->delete_blk_timer)) {
> +		ret = HRTIMER_NORESTART;
>  		goto out;
> +	}
>  
>  	/* We only need to plug the race when the block is partially filled.
>  	 * tpacket_rcv:
> @@ -786,10 +803,11 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
>  	}
>  
>  refresh_timer:
> -	_prb_refresh_rx_retire_blk_timer(pkc);
> +	_prb_refresh_rx_retire_blk_timer(pkc, false);
>  
>  out:
>  	spin_unlock(&po->sk.sk_receive_queue.lock);
> +	return ret;
>  }
>  
>  static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
> @@ -921,7 +939,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pkc1,
>  	pkc1->pkblk_end = pkc1->pkblk_start + pkc1->kblk_size;
>  
>  	prb_thaw_queue(pkc1);
> -	_prb_refresh_rx_retire_blk_timer(pkc1);
> +	_prb_refresh_rx_retire_blk_timer(pkc1, true);
>  
>  	smp_wmb();
>  }
> diff --git a/net/packet/diag.c b/net/packet/diag.c
> index 6ce1dcc28..c8f43e0c1 100644
> --- a/net/packet/diag.c
> +++ b/net/packet/diag.c
> @@ -83,7 +83,7 @@ static int pdiag_put_ring(struct packet_ring_buffer *ring, int ver, int nl_type,
>  	pdr.pdr_frame_nr = ring->frame_max + 1;
>  
>  	if (ver > TPACKET_V2) {
> -		pdr.pdr_retire_tmo = ring->prb_bdqc.retire_blk_tov;
> +		pdr.pdr_retire_tmo = ktime_to_ms(ring->prb_bdqc.interval_ktime);
>  		pdr.pdr_sizeof_priv = ring->prb_bdqc.blk_sizeof_priv;
>  		pdr.pdr_features = ring->prb_bdqc.feature_req_word;
>  	} else {
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index 1e743d031..19d4f0b73 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -45,12 +45,11 @@ struct tpacket_kbdq_core {
>  	/* Default is set to 8ms */
>  #define DEFAULT_PRB_RETIRE_TOV	(8)
>  
> -	unsigned short  retire_blk_tov;
> +	ktime_t		interval_ktime;
>  	unsigned short  version;
> -	unsigned long	tov_in_jiffies;
>  
>  	/* timer to retire an outstanding block */
> -	struct timer_list retire_blk_timer;
> +	struct hrtimer  retire_blk_timer;
>  };
>  
>  struct pgv {
> -- 
> 2.34.1
> 



