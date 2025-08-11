Return-Path: <netdev+bounces-212479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59847B20CA3
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019891661A0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17E2DCF7C;
	Mon, 11 Aug 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7RaZTr/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8622D3A94;
	Mon, 11 Aug 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923729; cv=none; b=A2JF/fO59XMqPMDIhUr7owChkpWzFF4UMDUJN+E0ZT1nA+DnOlS2RaIJvd+KYb52T2EGBj/C7NsrvJdMd1xVggVkWOLhEhYtuFyOfUr90ajpAU8TU+zIabWDkxnwVINpW/ieUwZRxayl0OSVR1P0VSJEa/XRZ7z9QfgxfW5VPWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923729; c=relaxed/simple;
	bh=nDuchMi8mVM0wp5S5hSDIwXAzStQnxICgcTeoA6T5RE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WgJXlIXFvQzIWwjGA4ZSUgXSR89sHDR08CvM09HOAM4Gnom6OqPm4kWkaRRJK0zPMUBiu7eNlVQs2IIohbvaZNAFqmqQcXy6JA1Qu//iT50aeevrRjWpFXPmrsVY6P6E8skZoWca+Svmgv7yb0yrVowvPB/af7mPSR+vp16LH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7RaZTr/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e80ba947cfso444616885a.0;
        Mon, 11 Aug 2025 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754923726; x=1755528526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXBDHL4mVvVYrVgUSoDAtfm0vOyJChENzyyx6qRT6Y0=;
        b=O7RaZTr/oqog2nLquuXXkbm/n88VEb65PQJW9TglSEKH9l8n9ILrXPyrcnOc66fWsO
         oqzcvbH05/xUJgUX+TFIbCEwbvwB3t4k4xFwrTwq/3JwTkqL0Dmd+XfZ2xHFoi1T+Xth
         EjWiqbKrk+JOONv1U2h5uNgMR+ogACA7Iyx8PqctZAK+cwdBJ7Ca6mtMEe5UVeD8fl2B
         8NXrI2A/GKf2c9m6R19FNbrHTHGYMOuKAGVjSd+Mn1VRVcVKZ5DPpKpcYZHSWxbZOFmK
         pjbHBof2sPNQ4jiQA7SH9QcKcmqx5ZPDwF9ezsLttQSML0vFEu4ZjPeCMG9jeRlTT7VN
         Z4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923726; x=1755528526;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXBDHL4mVvVYrVgUSoDAtfm0vOyJChENzyyx6qRT6Y0=;
        b=nnwgFIz9+NkLKtzMie6/D8iShkHiwVfNTdTQA0JrnUOzCx2eA10muDjfqDP9h8/0gg
         H5LUqgrGgJ17+E6j2UAwtZ/7B1Nk1yTijz7NuTVmRA2GHFvP0G2C6Ff2heELRkF1WAa/
         0nPZnwC4jC/muEk1WR06cBn2SJGBSDa8c5UQPyORucScwVKDun6Ac4bLYJ9lV75jtp4G
         7Sgg3bQ4KvjnCh0oLT3thKTpqKiRzyCzn6JQZNNtZhyG3bG+Bp3fCrxRCnoMJJlxmhvM
         GGdJtyx1Z2AJrg/A2tPBH/sCtAnlJxCQtjokDcMiLuSJFLijPTs8fJrny+SzHqvlSp14
         Jt1g==
X-Forwarded-Encrypted: i=1; AJvYcCVim+DjhpXUBqhtoE48YZA966biR0LcZomRwgWMbOLMv4VK24blQ+gcgsM2RLuqSa7ebDSQUsYp@vger.kernel.org, AJvYcCVyIOKlnbqeMZqAGMzqa1BQ23c8SwM5BQk2nSe434JNJa0wGMvO3GVGThnxGhfeb00AckYrJXGTn9CkOGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYn7tAQsW1Jwc1w3zcN83vSo6f0I5GI7WXcr2JSUAgCuFfnK6f
	71GOiORljhTxMJdvYCqb9t421vb1MfrmNFl7SRn23qM54OmYaFwQ8+Pn
X-Gm-Gg: ASbGnctAdCAKytav7u5yxHt/V5QKebtTQ55J6omTMHGTMy3LOmw3A9hM2DiCTu2YjTo
	ywaM90+J6fgTvugiXjrWk0YWBZ+F97BVg4pJEJR3pD31TDnYqlOfsHuddpOPriEWeLAF+iz6VgE
	aOEea4bQ5qiXdZuctcI6m9p2Ib985/jEphgsHbkxRKD7PlVDxysJFLnCoKtZLpnKZyfFFGT4O/Y
	+elNx8BCf8PH7OK2axHuSPPddAoNijyW67GoPq+k5Hs3XJ3J3fQ+EvK08khMIIkd2jxm/YUe4Ix
	C1JbYGR4r9hxfa4Cow5VIYU28khvxS3G+GFkIOyT/VeLR7OHYFViagur5dMJq8Q+Yue/JKHRIyq
	Cz1kjmbKQm30KFPMtLlIL/WUXo2W5C7oWmm0Z+34KB8oATpjb62oshMz5fxVHk2mNrW+Fbw==
X-Google-Smtp-Source: AGHT+IHkvpdwfmNhSdFTQ6XRuDvM4fReonbwNVnRXQkN0fyxpsVDUwiHM3dGF3Hc7SLumwcShd1xvg==
X-Received: by 2002:a05:620a:5bc9:b0:7e2:77d0:f33d with SMTP id af79cd13be357-7e82c68964dmr1428079685a.14.1754923726067;
        Mon, 11 Aug 2025 07:48:46 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e82aa29328sm608492385a.33.2025.08.11.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:48:45 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:48:44 -0400
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
Message-ID: <689a02cce2190_532b129496@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250809124313.1677945-1-jackzxcui1989@163.com>
References: <20250809124313.1677945-1-jackzxcui1989@163.com>
Subject: Re: [PATCH] net: af_packet: Use hrtimer to do the retire operation
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
>  net/packet/af_packet.c | 22 +++++++++++++---------
>  net/packet/internal.h  |  4 ++--
>  2 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index bc438d0d9..3b3327544 100644
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
> +	if (pkc->tov_in_msecs == 0)
> +		pkc->tov_in_msecs = jiffies_to_msecs(1);

why is this bounds check needed now, while it was not needed when
converting to jiffies?

init_prb_bdqc will compute a retire_blk_tov if it is passed as zero,
by calling prb_calc_retire_blk_tmo.

>  }
>  
>  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> @@ -676,7 +677,7 @@ static void init_prb_bdqc(struct packet_sock *po,
>  	else
>  		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
>  						req_u->req3.tp_block_size);
> -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> +	p1->tov_in_msecs = p1->retire_blk_tov;
>  	p1->blk_sizeof_priv = req_u->req3.tp_sizeof_priv;
>  	rwlock_init(&p1->blk_fill_in_prog_lock);
>  
> @@ -691,8 +692,8 @@ static void init_prb_bdqc(struct packet_sock *po,
>   */
>  static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
>  {
> -	mod_timer(&pkc->retire_blk_timer,
> -			jiffies + pkc->tov_in_jiffies);
> +	hrtimer_start_range_ns(&pkc->retire_blk_timer,
> +			       ms_to_ktime(pkc->tov_in_msecs), 0, HRTIMER_MODE_REL_SOFT);

Just hrtimer_start if leaving the slack (delta_ns) as 0.

More importantly, this scheduled the timer, while the caller also
returns HRTIMER_RESTART. Should this just call hrtimer_set_expires or
hrtimer_forward.


>  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
>  }
>  
> @@ -719,8 +720,9 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
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
> @@ -787,9 +789,11 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
>  
>  refresh_timer:
>  	_prb_refresh_rx_retire_blk_timer(pkc);
> +	ret = HRTIMER_RESTART;

reinitializing a variable that was already set to the same value?
>  
>  out:
>  	spin_unlock(&po->sk.sk_receive_queue.lock);
> +	return ret;

just return HRTIMER_RESTART directly.
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



