Return-Path: <netdev+bounces-214375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF5B29345
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D277A18F0
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D928540B;
	Sun, 17 Aug 2025 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWD0xYsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C67A1A00E7;
	Sun, 17 Aug 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755437306; cv=none; b=gBfRp2QQiM5vE91+OuztKMQTtG46ZHhI5lyAXk4kMRj79//zjrZrMiVhwTmzJ2mYjLeUfEuTwwmUZD5ce6tUcMVgjqbrobh2JAGa7eyQoG73ylIeqzT9iPVPc8k8W1OJuxZDXIDAVTF8Kda0/UEhA5IAJsI/06HfctOhHhSSPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755437306; c=relaxed/simple;
	bh=eTA9ON/yXxqjfMBcdqM/Q7Naw0xU0ljxGkoMRyNqI70=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tyGXLFf7s4REI2oNKhLfg92RvWKra0BPLFyFkTopqiTwzYVqaBSp6/MSGDBUOcqbCP4QmHVVcaNW3xTNMEOCFmWsTmXpEyENbh2+oLy9oaFQcqe8/MMi8zRzhascEORyjVp4K3rg1+nJqTpZp7ESGco4VU5m0HEwxKjQKvdPvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWD0xYsc; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e8706a9839so396775485a.3;
        Sun, 17 Aug 2025 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755437303; x=1756042103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1MZ6OX1HMPAX7oegSlohuyHPNiQ6mKMIQWVfU4UfFM=;
        b=dWD0xYscGhuUnTXoSMGj1KKEnqPofGtZE1cS8I8H6DVcYHe1sf5KDmctaM0hjoZPYk
         45rg1Ll9LCWqBz5mxc1MAwnPrX5MN4biaFY2pjZDyYX3GsjTMq0tPo3niOIhf1hLU3KU
         jWqvPzZINPRBkyJBU3KYMBoByvwMhlPeCNrWUPKkGeDmqk6rdiPoP+e1o0vN1XXGWZ35
         wW0aLE3/z+R+KibZgmqInYzSTtSdgF9GUOL3pSMxjvrTMgFWE8Uo66g7MLzZsDjw3Cp2
         9tqXkFqv0BjQ7OyrqPMW4Xiy8XTPptgLvS30uHGfqN7ZgehjJYR4I+VWHvohANGKGwQX
         Cc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755437303; x=1756042103;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M1MZ6OX1HMPAX7oegSlohuyHPNiQ6mKMIQWVfU4UfFM=;
        b=IYtB3OvHR6jqPjsSs5f1gExjb9BRXtwRVLwnUeVAroUG6nw8zlys6aGag9k7oQkIN9
         lpFCobOAyCd9VSlgtzwu4x1K45ydjwbTZeP2aA+UR4J10iOXQcymzCibSL9eo55XLsDm
         s7Up4iEovkEAzva3n1FTE08mxefLP3Qd26zDzKHKz3Qa3MRN7MFObbBPGqVSX7NpUcPl
         iV1MShH4TCJdVHLXcTrNrBh9SPMH0ZCubrbApr+C7QXl5/2D1FB9jx7sLoPcDIPKEKeV
         U/40m5WIK70BuhybNP0nRyjpBtcBphPmEBqSKQOWHzDxpFr/MOETn4l/6jlnLYxGdDJc
         QUCA==
X-Forwarded-Encrypted: i=1; AJvYcCUFalbueOFZsBo0Jhjsp0VYh1btz6ecKRU0d3+qNfo85pbnWm/FukiS01SjTuxbndVDCyVHmnfaSEKfZb0=@vger.kernel.org, AJvYcCW8rdEiul9QNkz+b8pYzo806haL7FSTHnVpDyv8qsveAno32NwMeretp8RYNSdVprOVF9QsvUDb@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkOyoojC8JmYSq+q5sObEFgwo10aAlbv7MIrFxm+AzMQdfDbj
	sCsy/aJuh2oHcgkx+4k4rhXT1fmW6qy4MuPhgbQRG917q05URCUlFL7FLvab+yOF
X-Gm-Gg: ASbGncvBFxqKXo0r7MDG5JSIPiEf2qLMkRFpkoT3njViuogWkbC7gti1F32yskXT172
	jGx1kn425EiJ3AnPtBhNZB5SKJ7SWmKcsNDr5uFVxsQK8iT7cnvCjHLSRx/Mm/q1QZjpK3Nlb+F
	T8x21QYjVQ5YYBI5yulpoPBGrkwADj/LQGa9artiOPH2ZLENxOi23sztk6msaJNyXh9QktcSLb3
	OiXMVQRbMTvWUHNVvQRtnyvQdLTi0Bg8LWG1qR5jvg73waOSOUg2uJwzDNt1IPh7wLaAcsMgBF7
	IPUkEmMoZeFJzqfa7OAzPjX8YwTiPCvZDQ0I+TCKfzGQnCuWmtRkuZjUx/qeaAEfiGgdzbXmw4n
	p+tiQpf7t2KyJVgk8S1qY49PRfcI97CcSEon9QchFnuqnlwC8w70QMXoH2mU/YWnJbwbj9w==
X-Google-Smtp-Source: AGHT+IGu08qWIMtZtymcyUvVGEv6L/U1GXTnwTG/kkwBp6f8pwLAaLRbK8jgM1k7tshetlsYfZvrPQ==
X-Received: by 2002:a05:620a:1aa2:b0:7e6:9730:3d47 with SMTP id af79cd13be357-7e87e103c51mr940064785a.52.1755437303367;
        Sun, 17 Aug 2025 06:28:23 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e020509sm422362285a.15.2025.08.17.06.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 06:28:22 -0700 (PDT)
Date: Sun, 17 Aug 2025 09:28:22 -0400
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
Message-ID: <willemdebruijn.kernel.8e1f4bf2adac@gmail.com>
In-Reply-To: <20250816024831.1451167-1-jackzxcui1989@163.com>
References: <20250816024831.1451167-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v3] net: af_packet: Use hrtimer to do the retire
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
> ---
> Changes in v3:
> - return HRTIMER_NORESTART when pkc->delete_blk_timer is true
>   as suggested by Willem de Bruijn;
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
> 
> ---
> ---
>  net/packet/af_packet.c | 24 ++++++++++++++----------
>  net/packet/internal.h  |  3 +--
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a7017d7f0..763b0c968 100644
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

Here we cannot use hrtimer_add_expires for the same reason you gave in
the second version of the patch:

> Additionally, I think we cannot avoid using ktime_get, as the retire
> timeout for each block is not fixed. When there are a lot of network packets,
> a block can retire quickly, and if we do not re-fetch the time, the timeout
> duration may be set incorrectly.

Is that right?

Otherwise patch LGTM.

>  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
>  }
>  
> @@ -719,8 +719,9 @@ static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
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
> @@ -732,8 +733,10 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
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
> @@ -790,6 +793,7 @@ static void prb_retire_rx_blk_timer_expired(struct timer_list *t)
>  
>  out:
>  	spin_unlock(&po->sk.sk_receive_queue.lock);
> +	return ret;
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



