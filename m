Return-Path: <netdev+bounces-214026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11CFB27E06
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4907BAF8A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5928F2FDC38;
	Fri, 15 Aug 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIVkcnj6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791627145E;
	Fri, 15 Aug 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252770; cv=none; b=kUYelec8IN6qqaPpE9ITLfs8NNJRc2PSTpFTKgjgWAIfjN8jw7qM6CzodTjS3QmumByDNJap82G9TntWV9eBaNyNJkebtj/tUgIXqshmcvMjDkRc1f0wP12e3cS+A8wC40BvDL111E93XLe0TpuEaI77PfvDpPzd47aI0A/+HhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252770; c=relaxed/simple;
	bh=4f3ZuoLyHT2uR+rtTLtBmdjYGINiSXO3+bLabQ5/Ncc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=q8rGs6X1zNKJm1mJ3D+c52pd3BM0Xcmvz2dfpu583J78SFH65ttfY2SEgJxniZ4amvJLYU/f/AMmr7wzWlgCBEhQIhPSXYN3Tesof2iO0GAyI3lO2iS1X/B8+Av3hXD7VGGfgQymbyZcLbuC55mLGKhcHqVKgzSja1Zm0F4XtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIVkcnj6; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53b17534eeeso669544e0c.3;
        Fri, 15 Aug 2025 03:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755252767; x=1755857567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk1sEBG1JgByzGsu2daM0A6zR4Dic6u88H00GEH8dVI=;
        b=kIVkcnj6qPDUHVCYMrNICuph+RzWJvP7/E/DmY99luxbWaQYNaSVDg/c8gthBvAA/l
         hdxj2DxIvjcVyl0EVjUK/yc4MoCAk9DlvyUbhY91ZBfYq5WhSXnMFV1EbPJw1uGAsUjA
         Rf6G9UKd+NQdUAOOVHeM+LHHrLQcczhaV0pDeqmMSztdmsWaEqqS3dNxhKtQq7ZRp/Uu
         4TGQ6ZvHiG7QkIgKgD7AUQCMfHp6k8fNtXHwQxsZI10VnVyexp5oCNIj4adqULSA6lNk
         l1rI4Zi1VKCUjSx10NH4yyXuzPvdkx5Vj/mWgHBHbtjHvXTX3/vRe/NylCrz99/n+jeb
         6tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252767; x=1755857567;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qk1sEBG1JgByzGsu2daM0A6zR4Dic6u88H00GEH8dVI=;
        b=DoyEXxLJsRM/6z25f8izWWAfINmpheLUHc4yn8zmsgMJiLsfU0ZGIVn8Rp+vf1LbTj
         58uedkPiEqZh3cH2tAMvTM7ExyPrauMN9UudoJXnO85GBYiumchH+NV0X653PK7gzrHE
         ymP8pJmQpDJ/tI6IGjyipLdoR9k0eF4LSK7vEU2gn/WWMaWDG6tbMNvhHoIDcLeop8hY
         PDbk6JzqnOEPrFjjmcb7m/mSBPHaPEJ9RpEVLleSpdRlOI6MnJYbdcXtIsTF7mdVRIJi
         htddqz1CSQIfBCpCCvNiPoWT8ea+Al1ojtYPpimIDlUTMEtLiMJkbNWYOtCMhi1Vapxn
         8gRg==
X-Forwarded-Encrypted: i=1; AJvYcCUebkM931RTvXK/jyfvXfljlOmHkYX3/1GBmLeFB1Z/s5yPTH06haryRTMTIXm2bxZVeJSYu/Bl@vger.kernel.org, AJvYcCXk8KwI22LbxeLxhwfwimP8vqLiYtxfv3f9zOVPxVmBGX1YWvYFIMgzb9W2QmecyWjzSftl/tuePUQRh1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5l42te3Fwe8xZt19tAi2U5G1fTxzrtpLp+z1GSQiejri6Xic
	qKsL6HSVTrH4hRa892LytoOWl3QVe9Dwn3fuVcJrsR0Sn6/X8fhXKflW
X-Gm-Gg: ASbGncuDeXZ3LpyfckRGyu2GzwaxGlKAcKoWNYhrWnDSMjK9bKtqpRjFMdLPzplEvUO
	/Uxikpsf3+Y4+YabxxhgjKXePCxqAKZ9Zj0QEsEhVBpInJ28qiB/ZpcxdI5/+j9DrV4Re/K7Cx2
	kmg6/FnVNGyWHwn09PmJGNxOR0tnGmpawpO1KspnWMzfmT4Rd4vvCDjDvbAZ/T9J3PcfSmG6OTA
	FgnlvUajnzTfuaEN1mHHntEy39b0aN+8oqtDJF9soeqPVUUvnCshf6t2OfSPPRjinHKxXJIFPxX
	vcCeVBPc1CLNeJWT9ntzqeMH4nOrMN68qlEfNXOFyZFrn8k+gZUQTMzVUgbcssk62UAxWksroFF
	y/sy7ODBe3oeIDYmCd2IUpEfVY4ss1iMexvHqS1TGRXirnaLXng9CwsVHot6wregZKdUvj1HLwN
	CADiGU
X-Google-Smtp-Source: AGHT+IErHYBHZ9F56y3QR6604I9chBpBCzattPNFtOHEa8KKmXYWbobXMLG8faXDVro6nSTFCY7I8A==
X-Received: by 2002:a05:6122:d0e:b0:534:6840:fe0a with SMTP id 71dfb90a1353d-53b2b8b1672mr327614e0c.8.1755252767337;
        Fri, 15 Aug 2025 03:12:47 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53b2beff2fcsm146445e0c.26.2025.08.15.03.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:12:46 -0700 (PDT)
Date: Fri, 15 Aug 2025 06:12:45 -0400
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
Message-ID: <willemdebruijn.kernel.379d02e33141a@gmail.com>
In-Reply-To: <20250815044141.1374446-1-jackzxcui1989@163.com>
References: <20250815044141.1374446-1-jackzxcui1989@163.com>
Subject: Re: [PATCH v2] net: af_packet: Use hrtimer to do the retire operation
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

Please clearly label PATCH net-next and include a changelog and link
to previous versions.

See also other recently sent patches and
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
https://docs.kernel.org/process/submitting-patches.html

> ---
>  net/packet/af_packet.c | 19 ++++++++++---------
>  net/packet/internal.h  |  3 +--
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index bc438d0d9..c4746a9cb 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -203,7 +203,7 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *,
>  static int prb_queue_frozen(struct tpacket_kbdq_core *);
>  static void prb_open_block(struct tpacket_kbdq_core *,
>  		struct tpacket_block_desc *);
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *);
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *);
>  static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *);
>  static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hdr *);
>  static void prb_clear_rxhash(struct tpacket_kbdq_core *,
> @@ -581,7 +581,7 @@ static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
>  
>  static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
> -	timer_delete_sync(&pkc->retire_blk_timer);
> +	hrtimer_cancel(&pkc->retire_blk_timer);
>  }
>  
>  static void prb_shutdown_retire_blk_timer(struct packet_sock *po,
> @@ -603,9 +603,10 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
>  	struct tpacket_kbdq_core *pkc;
>  
>  	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> -	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> -		    0);
> -	pkc->retire_blk_timer.expires = jiffies;
> +	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> +	hrtimer_start(&pkc->retire_blk_timer, ms_to_ktime(pkc->retire_blk_tov),
> +		      HRTIMER_MODE_REL_SOFT);
>  }
>  
>  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> @@ -676,7 +677,6 @@ static void init_prb_bdqc(struct packet_sock *po,
>  	else
>  		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
>  						req_u->req3.tp_block_size);
> -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);

Since the hrtimer API takes ktime, and there is no other user for
retire_blk_tov, remove that too and instead have interval_ktime.

>  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
>  	rwlock_init(&p1->blk_fill_in_prog_lock);
>  
> @@ -691,8 +691,8 @@ static void init_prb_bdqc(struct packet_sock *po,
>   */
>  static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
> -	mod_timer(&pkc->retire_blk_timer,
> -			jiffies + pkc->tov_in_jiffies);
> +	hrtimer_set_expires(&pkc->retire_blk_timer,
> +			    ktime_add(ktime_get(), ms_to_ktime(pkc->retire_blk_tov)));

More common for HRTIMER_RESTART timers is hrtimer_forward_now.

>  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
>  }
>  
> @@ -719,7 +719,7 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>   * prb_calc_retire_blk_tmo() calculates the tmo.
>   *
>   */
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
>  {
>  	struct packet_sock *po =
>  		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
> @@ -790,6 +790,7 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
>  
>  out:
>  	spin_unlock(&po->sk.sk_receive_queue.lock);
> +	return HRTIMER_RESTART;

This always restart the timer. But that is not the current behavior.
Per prb_retire_rx_blk_timer_expired:

   * 1) We refresh the timer only when we open a block.
 
Look at the five different paths that can reach label out.

In particular, if the block is retired in this timer, and no new block
is available to be opened, no timer should be armed.

>  }
>  
>  static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index 1e743d031..9812feb3d 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -47,10 +47,9 @@ struct tpacket_kbdq_core {
>  
>  	unsigned short  retire_blk_tov;
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



