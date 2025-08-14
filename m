Return-Path: <netdev+bounces-213813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F47B26DB1
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 19:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272E4AA67BF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA73E30277B;
	Thu, 14 Aug 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxbxUXfw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDE301478;
	Thu, 14 Aug 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192589; cv=none; b=kWmkGkvmqTxfv7sT9uZNqs57IcRPVFp+rYCQvqxJhzXqzqte/KOvONDvN5exKqL87RI1jqlGtalHCTxTW0zFYf9LTiThNV1fqOqsPdCUKdzcEerX6rXGe1N6KIAs9r1pTaKjU3ZMs38onyXFQ9NnDQTMmXX/kqzR6CArw48BTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192589; c=relaxed/simple;
	bh=bbxK6Iv6rDD7zqHgfuXwAmXQNec91gHpu8qmqVcq90k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IzbVKdss4BmcY+tq1a64hwC4eIFT5Kpg4+qJh8lza0hMnV7nFSb48DWr/xX3zGNJU5cz+oOna6HK5Lz466SDJbiwtxac31uPkLvIMH/rCJZ1VNNjPDe8V7m96dcymfIUWZu/aOka40Ftxyrrj3qN5Cp00AithD/leaCZPrlq72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxbxUXfw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c5ac7bso12716611cf.3;
        Thu, 14 Aug 2025 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755192587; x=1755797387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17B0FvgE6nawtCLjLfMK2Bx+9F0ZC/fztsMqih5GWwo=;
        b=JxbxUXfwuXmjKudcw3sGWMcLAfSa5roDfDnN6qq8PwMCNfHLDFXN3t5qmVSjIefzte
         ta+JfQzhAVivhGHNzsvUE7patSqJjjmganazyTFQ9GwLD4L6t+Y0PR0WDha02QsqY7FB
         JtqTjimm03LAp8pXOtjsYXpvkaZJ6117m3XiugVsiph0vffX8Hy44lAWycmGmnMv2QrA
         fKgezkoyG9vRzG72UYyjbHEqut64IU3KyIVgT2Fy7QmOcpB6dURs8/tNzcQdRULWM14R
         G9AzBPLV2H8k56TDlXdPyqfQirFle6vsT6Gw21JQ4d5RYRmzDNF1fl1OyHn31sqy9cHV
         zghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755192587; x=1755797387;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=17B0FvgE6nawtCLjLfMK2Bx+9F0ZC/fztsMqih5GWwo=;
        b=Uxrm/kjybH1VTgwsrYlGDqOWda6q/tK5TAXivGQS7PNucFE2CfhO7XtsbigeJQ63Pq
         0sybgCMllnQfZA9hMLQL2rlvk08VTqxJcjFXu/MWi8EecK4cznbRZKIV8Tyva/17dACg
         ih2EFo/ikRx2mmAm9QIjX8wsEmbzAFtSGlSxRjp431X+gRBQs3pSbRlJ9S0Wbc5WvOfq
         dLIwk5JkdM1D2WaAOpJUfCgFrc6sOlLCicA5QP8m0mNfEp4MhQU49ch6/IGT4GFLZb5K
         fZbNPvJ2XFwx8D+tm4YMrHe1e/6oKz2MnYbeJZZuAyLq8HXnQ9NjS93lgKlmCNvv7ESg
         c0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWmNEG64SG/UTRZS7fPN19iwk75ooZVx2QQ5poaptYPcLryqT40osVQtMWJqFZ/4buApr8pp2Y9uZFO3jg=@vger.kernel.org, AJvYcCXENj6DHOpa1d334jvHdKr4ethgOJBA5CFRtbD4QBEgut1TA7zdBANJX5At9B0DjyDbpjXejqkl@vger.kernel.org
X-Gm-Message-State: AOJu0YycCd4X4Ludcw78i+pwRxbzy8xv3Swpz3VXK6IDSKLV/BvYJIdO
	HwwjKcJnDdadr8bh0ve3cwMxlAVUdBSm8g055wW2dlCP0B3XruxIi+m1
X-Gm-Gg: ASbGncsi/wSKgCQaZrfF5ahGPLQGop4WY0nUSrCSVty/H3BkM6hfXjZ9RX1q4DQB6GR
	QW6EWfA8oMfHQ65Ap/MKK9IBsuFnx20uPTp+cBX2ZRnv1L01of5Bvp6ut3d22h4r6K9t9sH4NjU
	dV0yTJOwL8x+WH2UDopesI3NUMtqeI/SSwoB6qLC1suTgrqUDBqYRBPyk60MvbPeL5zevxDlEXR
	y5kGVkjG95NssyTbdkcMEhoP6xK5YzKc2nIxYYkdBHfyRWPsDKwvQPkfuV+HoMyVi7Om6sW7RY0
	PE0CrTkiFxJlvNERWyvBk+TV8Op+VgNZtjtHc8IDE/X/XaFk7NtbB+ZZtu4/9M81J+3OVxPs6x4
	vSzGx9MGTjrCaVo+rG+K/EOKDLywMmNjlbpVnMfimvMPyTK8s+KvaSUdZU5Lz8LME0VCzJA==
X-Google-Smtp-Source: AGHT+IH+9zsImSCc7orlX0RldS4bLmQszAZzitZJe+WIVraTy1p1VS7DLY+Q6kRP+GCfhZ9BfFS4EA==
X-Received: by 2002:ac8:580c:0:b0:4ab:ab85:e54e with SMTP id d75a77b69052e-4b10aa7a720mr51069351cf.8.1755192586784;
        Thu, 14 Aug 2025 10:29:46 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4af7b43e8bdsm163098231cf.45.2025.08.14.10.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:29:46 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:29:45 -0400
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
Message-ID: <689e1d09c5284_19a06829473@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250813165201.1492779-1-jackzxcui1989@163.com>
References: <20250813165201.1492779-1-jackzxcui1989@163.com>
Subject: Re: [PATCH v1] net: af_packet: Use hrtimer to do the retire operation
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
> ---
>  net/packet/af_packet.c | 20 +++++++++++---------
>  net/packet/internal.h  |  4 ++--
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index bc438d0d9..636b72bf6 100644
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
> +	hrtimer_start(&pkc->retire_blk_timer, ms_to_ktime(pkc->tov_in_msecs),
> +		      HRTIMER_MODE_REL_SOFT);
>  }
>  
>  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> @@ -676,7 +677,7 @@ static void init_prb_bdqc(struct packet_sock *po,
>  	else
>  		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
>  						req_u->req3.tp_block_size);
> -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> +	p1->tov_in_msecs = p1->retire_blk_tov;

Can probably drop this field as it's the same as retire_blk_tov.

Or convert to ktime_t next_timer, to be able to replace ktime_get()
with ktime_add_ms when rearming when calling hrtimer_set_expires.

>  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
>  	rwlock_init(&p1->blk_fill_in_prog_lock);
>  
> @@ -691,8 +692,8 @@ static void init_prb_bdqc(struct packet_sock *po,
>   */
>  static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
> -	mod_timer(&pkc->retire_blk_timer,
> -			jiffies + pkc->tov_in_jiffies);
> +	hrtimer_set_expires(&pkc->retire_blk_timer,
> +			    ktime_add(ktime_get(), ms_to_ktime(pkc->tov_in_msecs)));
>  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
>  }
>  
> @@ -719,7 +720,7 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>   * prb_calc_retire_blk_tmo() calculates the tmo.
>   *
>   */
> -static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
> +static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
>  {
>  	struct packet_sock *po =
>  		timer_container_of(po, t, rx_ring.prb_bdqc.retire_blk_timer);
> @@ -790,6 +791,7 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
>  
>  out:
>  	spin_unlock(&po->sk.sk_receive_queue.lock);
> +	return HRTIMER_RESTART;
>  }
>  
>  static void prb_flush_block(struct tpacket_kbdq_core *pkc1,
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index 1e743d031..41df245e3 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -47,10 +47,10 @@ struct tpacket_kbdq_core {
>  
>  	unsigned short  retire_blk_tov;
>  	unsigned short  version;
> -	unsigned long	tov_in_jiffies;
> +	unsigned long	tov_in_msecs;
>  
>  	/* timer to retire an outstanding block */
> -	struct timer_list retire_blk_timer;
> +	struct hrtimer retire_blk_timer;
>  };
>  
>  struct pgv {
> -- 
> 2.34.1
> 



