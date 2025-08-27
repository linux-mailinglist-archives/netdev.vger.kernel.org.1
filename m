Return-Path: <netdev+bounces-217450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E2B38BB5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AB87B8E17
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B76309DDC;
	Wed, 27 Aug 2025 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLQ0qBjX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0730CDB2;
	Wed, 27 Aug 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331592; cv=none; b=t3HP1uEAKBx1ovdad9yoreT7ktMZBE+mikD5k4RrmYsU/kebo4Yu7aO2C+LVVaClKg4/Y1kYpu/57SQF/asOueQPakrdjjoCpnGnb/PsFBQzsfUJqFeyYzP111pmcqaxwuXEC0PGD6+PWF2SRss4XJsKoEPyHzVVqdxQ8ZYubiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331592; c=relaxed/simple;
	bh=JmD+WMWxUegH+EbXCwoviJ0ZlvUZdbPJnTN1DfD7jJU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KzzFNdCSRAmRkhAz/4+sCt0Kjr3382kQ8UaT0nNymRlNnMvhzkIdZbVYOYETl4LHx5o4+6tMrjqWgzG66rXgsFiDnMd/P42wpHK/O7d1lwlp52HQTANbk3lUolGYn/Ydpn/Z/zRWbkdbNSofbJ1S9CCb6ANQTdyKG4R6NSWUyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLQ0qBjX; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54475262383so337635e0c.0;
        Wed, 27 Aug 2025 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756331589; x=1756936389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olLihN7iGE+H0GKDuBA0F38F7thEW/DNGdW0yAxA+Eo=;
        b=PLQ0qBjXUORp3GTcsPW0gapF00d0fQYeGAeuZcv7vYZcbpNDJNOpw4KbY5XvSQaPf8
         vLRQf5LlMrQAndlCCZXm9ucJcjbtNNWCfjVdTInR2yC9oGQ3L+nBgvbcf4ZeOhS+cdkY
         4uRfs4KCR0HMtUkRrtGrZPASTnJahlnBc3hjx8N1ap9ALjwW6vnfErDewFBjv24Y1iW6
         cm53Xq5UQqiIUfuZ1JGDsgMtHq/t3qWhmEUJiIKGr/EtRCujKcqRDgCyuGExwdZqxfAT
         KS18LNVmtscyHN9kWwk/ROALoQVsJ2locKBEUD/z9U3oN2ExoVJ2rYrQ6jOzAfRdLwkT
         KTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331589; x=1756936389;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=olLihN7iGE+H0GKDuBA0F38F7thEW/DNGdW0yAxA+Eo=;
        b=FfSkxF2/l7msY+UzCnZRI44qbzoU9n6WHt4fCKtHlW85Bh69yLIWdnrumZ8lfiOSVh
         jFUQC9H/2IbS2vEsinN157PW49HucW7GzTY0VxbTf7eLDyhJvyP3huaxr+lai+Ni1+SX
         f+b2d0QSRPXx20zZyzFQsttbQhH0X/8KCOqms71YfJiR+7R9RSxXktSmZTZkNTVhpNTb
         Ilzn2dQhU2DdgxX4Ql0Z5ll40mE/z5Q72LY1OYUPij3mutiScS40J780/TomwgWiohSa
         BJ5u+MeEhhc3bE/Xyrvb9K0lJ2n6XAbQyCLPNMro7DedSk8SPSgvAcA0MQaCnhXrePB2
         dqSA==
X-Forwarded-Encrypted: i=1; AJvYcCU61aj4p/rY7H3q4PO2xTrKsJ17/PyVrtHJfRMoEG+2haGmq3nYzZYhG5DPo13rb5JV0Rtew1W/0Cldz+4=@vger.kernel.org, AJvYcCW+YMEYPHwi4aq0l+5KmiOpoWcbw8+w68Jzk/SLSjORuhkT2ub72x3EuSQ6eBnEQWWLYqBzjR9H@vger.kernel.org
X-Gm-Message-State: AOJu0YwrSw2rpyKOdrfxbsd5ghLMHJNIE5zt9VMhF899UcwzxpOLqbiR
	DqpASfmRAw/AcKYPnwxksgFBT1vkZK4S098eaccVK2y42/RzjoJiWY7usfLcFg==
X-Gm-Gg: ASbGncvFqt2OWmsl7IzQNCUnNPGwHDX/LSyzlcc8OwYggTNTOcP7y/4NprNVFMtmlOk
	v/Rx3Ybb2UizW8ejGGw9GpWV2lL2f3vsbnwEAtLLFKaBb0lDTXKTVP2talAT6ijxLRvcT/RCVtF
	vrvCq1Bkn7Y92SCPVvZHyV9Qic/gOqhHO3Q++Q9z3EN6R2ajNS8PX1oYPZT2Zldh1V3QzDVqZ9U
	An9wTeP+DUBZUiO4IhkEnz/3rUvU1HY+8M22tZtrLx64Yi761yMTOsBNQjRro+iqc7Nwjw0i98n
	6AVwY4jYEy99un6Pf4X3IAS1hSMVhIAc/OMfCCzNcAmhWww4Fz+YUDSb0PKPiQvfa5Y96DqYvyw
	cIwCpwj6lXFLgmjM/88NKypapbj3yqAc8v0yrkAGd8K08fSBZLhoss2+lgPYG/oZa3sWnYcTyDX
	1lbA==
X-Google-Smtp-Source: AGHT+IH74uxSZvh5SzFH2g6KUcNiA/0oo+dw0XHY5TfWmNp2WlhPOzDO87TvjOEuvaalF9IooO2OOw==
X-Received: by 2002:a05:6122:4686:b0:542:97fa:2b17 with SMTP id 71dfb90a1353d-54297fa3821mr4075321e0c.9.1756331589512;
        Wed, 27 Aug 2025 14:53:09 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-5443005c642sm1502305e0c.20.2025.08.27.14.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 14:53:08 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:53:08 -0400
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
Message-ID: <willemdebruijn.kernel.e7f6fdfe20e3@gmail.com>
In-Reply-To: <20250827150131.2193485-1-jackzxcui1989@163.com>
References: <20250827150131.2193485-1-jackzxcui1989@163.com>
Subject: Re: [PATCH net-next v8] net: af_packet: Use hrtimer to do the retire
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
> Changes in v8:
> - Delete delete_blk_timer field, as suggested by Willem de Bruijn,
>   hrtimer_cancel will check and wait until the timer callback return and ensure
>   enter enter callback again;
> - Simplify the logic related to setting timeout, as suggestd by Willem de Bruijn.
>   Currently timer callback just restarts itself unconditionally, so delete the
>  'out:' label, do not forward hrtimer in prb_open_block, call hrtimer_forward_now
>   directly and always return HRTIMER_RESTART. The only special case is when
>   prb_open_block is called from tpacket_rcv. That would set the timeout further
>   into the future than the already queued timer. An earlier timeout is not
>   problematic. No need to add complexity to avoid that.

This simplifies the timer logic tremendously. I like this direction a lot.
 
>  static void prb_setup_retire_blk_timer(struct packet_sock *po)
> @@ -603,9 +592,10 @@ static void prb_setup_retire_blk_timer(struct packet_sock *po)
>  	struct tpacket_kbdq_core *pkc;
>  
>  	pkc = GET_PBDQC_FROM_RB(&po->rx_ring);
> -	timer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> -		    0);
> -	pkc->retire_blk_timer.expires = jiffies;
> +	hrtimer_setup(&pkc->retire_blk_timer, prb_retire_rx_blk_timer_expired,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
> +	hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> +		      HRTIMER_MODE_REL_SOFT);

Since this is only called from init_prb_bdqc, we can further remove
this whole function and move the two hrtimer calls to the parent.

>  }
>  
>  static int prb_calc_retire_blk_tmo(struct packet_sock *po,
> @@ -672,11 +662,10 @@ static void init_prb_bdqc(struct packet_sock *po,
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
> @@ -686,16 +675,6 @@ static void init_prb_bdqc(struct packet_sock *po,
>  	prb_open_block(p1, pbd);
>  }
>  
> -/*  Do NOT update the last_blk_num first.
> - *  Assumes sk_buff_head lock is held.
> - */
> -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> -{
> -	mod_timer(&pkc->retire_blk_timer,
> -			jiffies + pkc->tov_in_jiffies);
> -	pkc->last_kactive_blk_num = pkc->kactive_blk_num;

last_kactive_blk_num is now only updated on prb_open_block. It still
needs to be updated on each timer callback? To see whether the active
block did not change since the last callback.

