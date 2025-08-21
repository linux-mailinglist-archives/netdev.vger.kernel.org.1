Return-Path: <netdev+bounces-215659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90468B2FCFD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41A5AE6820
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCEC2DF71E;
	Thu, 21 Aug 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY0OYmRL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53EC287243;
	Thu, 21 Aug 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786741; cv=none; b=KVo4PEwAUXWPxgRZFwjTNy2jiEM4g5dYFNdJc1j1zebvItXvYuxmIF+KR0QAPWYr4qcu96dJYuq0t1/jPKai/DzNyFPOsU1bi+de/yGtOKSyO8XUfbqPCMaZ7SnPDnYJ011UzpRf1amahRMg3ZdTNqzueu1iAPzjpM7UhEZlZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786741; c=relaxed/simple;
	bh=7liCWNBinK+iuXThV7ZSKeojKN4zFN/0itzK7p6Gjpk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rqww5WmmoxpNGFnM+NAmGLVIUARJUrFruHypj6ap4Mn9L078SRGeXB3Uwoyxeue7atq2v+VAY3ZL7fbSr74GU20Ogk1YA6ZAlHhQfXjMABZYC8sZ8MOjxaR+Z0zehBcmRNZdktb74fDphz3a53aWHvRGJORzBfgBbBwMaJ5kA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY0OYmRL; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-70a9f15f15fso9264226d6.2;
        Thu, 21 Aug 2025 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755786737; x=1756391537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmaMAkOApVYgj0tONPoDNZ2U9RwoX8Dq1gGok/DRfzk=;
        b=lY0OYmRLdqdsQ5qEJZGX2F23AD+bZ+zyI0stVqg9GsSEDItsyhHAKN1nKV+Nnrx993
         FLdL3m8Ra2OBFVMTKrErxS7Uh0122klDc3p+QCU4Ob2Ar2Yei6U9xFDE7Tfg9ZR5R8F0
         4WglxmGLq5oKWxxbpzBKUw5pFQ9PATDIrbBoINjtTuHQGjaflyn2nrOcq9jG5mnv9FHQ
         Ho5smp/hnuDO3ecsZFm6UPhJtGaYswM1SaDGR2MMaMKNiOrWPSzVcftpLQZ3cTF2F84R
         iY1h6s9lmsDrlHgJVWAjE2Ztt9fvassPOHaBBZB8JfS9NpLT+KA5WvH8nqNZLJLSa/2d
         yLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786737; x=1756391537;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wmaMAkOApVYgj0tONPoDNZ2U9RwoX8Dq1gGok/DRfzk=;
        b=v6F0dAgC4NvwDNoK4XqCVKNeusXoCwjRkRYWf7GasMwS/Xw7J3RhQg9LI04+PZOLke
         O5H+pYLWG2CJWH7n2yfLOEmGtgxVuSlgkttFQonfv7TpD50cQGYUajdQjmHpubQkrJkP
         5P8L5iw6v+5x8AwHRZgZov6eM7aDlPbVrZoDlkqMcQlTELEn0764V0GCXvm0lRxlnKRS
         S8FkWiXPFW/lx+38EnvRW6Y7Y518GcsYuJRILMGLDO01o8PyRHJd7DR6UUNiYuKt7sv6
         7OtPMNfm5ix0cr4ybthtk2GSuds6bHBwO+x4y64QAk17wbsF2GLaWbYaJRGnTad2gLR0
         E0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVaeqd6r9WiQlgdsqr+PZmuxZAZYN4EuQgq1eUv1d4N7NciyIdl52Vm3WO5bkJERQL5elcrrUyzl+9E8rY=@vger.kernel.org, AJvYcCXaoqtOhAemogruqNH2gH3OAAvNv5jQeQO68thjzmU7qPYlnHN1VHZwAIFJvdQDOIlwznG5CnHw@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCrWBpUJvItP/X4mmESurvcHceZCsTDUpufglFY95xN8gB70B
	idS1nCtPqqtaZ7CKNoUWydNnevmD17+lmbfkVhAVxoYIfQX3cOlwnwFBXndq+TF/
X-Gm-Gg: ASbGncvk7I0wJ4Qx6V8mCljr4J3llnvdQ7DWXJJtltZgPP1bjwyw8XKGp0nUnZ3LHhU
	iSFloi9jozY+CxNfEPwwSrzpUB+Mf3zLMWV/aOs1M5Kqxy67fFlUfcyu0a0E3zUmfHIQx80qpt/
	Gh0y3shpP3q2Hh8j5/w+2jyHhdwkJjKA6qalWlxB0eB7UrwWfPBt8LQjTYKyBN5RZDIPw3/MEYy
	3HamGg1dvJ2QugUh4bqiqAp+IeOMz1tM5CQMbCoHzmyA/wUo/eKWT/ZIKYxvFJ1N31/C+gQ9hQJ
	TSBHt+xYBmPTG1i1BeoTb2dv62b/rRXnaS9M6hITnpwXiN+tqmvBP2r2zF39qaCKA/mvo6jWygE
	hhnsGwBlAsRnY0kpGn0AhKkDqGAKIScnL5HStNvWRTeIbhTBCDEVaoJlbHGNS7NgSfoog0g==
X-Google-Smtp-Source: AGHT+IFPFVg2gXHXiaRJcu8a9JQUclG8hnCMHp7rqRJ+DcFxoG3ygQoPk0US4ECqBN4y6aiHEhqABA==
X-Received: by 2002:a05:6214:2b0d:b0:709:7e8a:aa72 with SMTP id 6a1803df08f44-70d89026cb0mr29806126d6.48.1755786737348;
        Thu, 21 Aug 2025 07:32:17 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70ba937ad86sm103152816d6.61.2025.08.21.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:32:16 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:32:16 -0400
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
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.970c1e7dc19d@gmail.com>
In-Reply-To: <20250821085318.3022527-1-jackzxcui1989@163.com>
References: <20250821085318.3022527-1-jackzxcui1989@163.com>
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
> On Wed, 2025-08-20 at 19:15 +0800, Willem wrote:
> 
> > > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > > +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> > > +					     bool start)
> > >  {
> > > -	mod_timer(&pkc->retire_blk_timer,
> > > -			jiffies + pkc->tov_in_jiffies);
> > > +	if (start && !hrtimer_is_queued(&pkc->retire_blk_timer))
> > > +		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> > > +			      HRTIMER_MODE_REL_SOFT);
> > > +	else
> > > +		hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
> > 
> > Is the hrtimer still queued when prb_retire_rx_blk_timer_expired
> > fires? Based on the existence of hrtimer_forward_now, I assume so. But
> > have not checked yet. If so, hrtimer_is_queued alone suffices to
> > detect the other callstack from tpacket_rcv where hrtimer_start is
> > needed. No need for bool start?
> > 
> > >  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
> > >  }
> 
> 
> Since the CI tests have reported the previously mentioned WARN_ON situation within
> hrtimer_forward_now, I believe we should reevaluate the implementation of the
> _prb_refresh_rx_retire_blk_timer function, which is responsible for setting the
> hrtimer timeout, and establish the principles it should adhere to. After careful
> consideration and a detailed review of the hrtimer implementation, I have identified
> the following two principles:
> 
> 1. It is essential to ensure that calls to hrtimer_forward_now or hrtimer_set_expires
> occur strictly within the hrtimer's callback.
> 2. It is critical to ensure that no calls to hrtimer_forward_now or hrtimer_set_expires
> are made while the hrtimer is enqueued.
> 
> 
> Regarding these two principles, I would like to add three points:
> 1. In principle 1, if hrtimer_forward_now or hrtimer_set_expires is called outside of
> the hrtimer's callback without triggering the timer's enqueue, it will lead to the
> hrtimer timeout not being triggered as expected (this issue is obvious and can be
> reproduced by writing a kernel object and setting a short timeout, such as 2ms).
> 2. Both principles above are aimed at preventing scenarios where hrtimer_forward_now
> or hrtimer_set_expires modify the timeout while the hrtimer is already enqueued, which
> could lead to disarray in the hrtimer's red-black tree (after all, the WARN_ON check
> for enqueue in the non-inlined hrtimer_forward_now interface exists to prevent such
> situations). It is also important to note that apart from executing the hrtimer_start
> series of functions outside the hrtimer callback, the __run_hrtimer function, upon
> returning HRTIMER_RESTART after executing the hrtimer callback, will also enqueue the
> hrtimer.
> 3. The reason for principle 2, in addition to principle 1, is that when setting the
> timeout using hrtimer_forward_now in the hrtimer's callback, there is no protection
> provided by the lock for hrtimer_cpu_base, meaning that if an hrtimer_start action is
> performed outside the hrtimer's callback while simultaneously updating the timeout
> within the callback, it could cause disarray in the hrtimer's red-black tree.
> 
> The occurrence of the WARN_ON enqueue error in the CI test indicates that
> hrtimer_forward_now was executed in a scenario outside the hrtimer's callback while
> the hrtimer was in a queued state. A possible sequence that could cause this issue is
> as follows:
> cpu0 (softirq context, hrtimer timeout)                             cpu1 (process context, need prb_open_block)
> hrtimer_run_softirq
>   __hrtimer_run_queues
>     __run_hrtimer
>       _prb_refresh_rx_retire_blk_timer
>         spin_lock(&po->sk.sk_receive_queue.lock);
>         hrtimer_is_queued(&pkc->retire_blk_timer) == false
>         hrtimer_forward_now
>         spin_unlock(&po->sk.sk_receive_queue.lock)                 tpacket_rcv
>       enqueue_hrtimer                                                spin_lock(&sk->sk_receive_queue.lock);
>                                                                      packet_current_rx_frame
>                                                                        __packet_lookup_frame_in_block
>                                                                          prb_open_block
>                                                                            _prb_refresh_rx_retire_blk_timer
>                                                                              hrtimer_is_queued(&pkc->retire_blk_timer) == true
>                                                                              hrtimer_forward_now
>                                                                              WARN_ON
> 
> In summary, the key issue now is to find a mechanism to ensure that the hrtimer's start
> or enqueue, as well as the timeout settings for the hrtimer, cannot be executed
> concurrently. I have thought of two methods to address this issue (method 1 will make the
> code appear much simpler, while method 2 will make the code more complex):
> 
> Method 1:
> Do not call hrtimer_forward_now to set the timeout within the hrtimer's callback; instead,
> only call the hrtimer_start function to perform the hrtimer's enqueue. This approach is
> viable because, in the current version, inside __run_hrtimer, the state of the timer is
> checked under the protection of cpu_base->lock. If the timer is already enqueued, it will
> not be enqueued again. By doing this, all hrtimer enqueues will be protected under both
> sk_receive_queue.lock and cpu_base->lock, eliminating concerns about the timeout being
> concurrently modified during enqueueing, which could lead to chaos in the hrtimer's
> red-black tree.
> 
> Method 2:
> This method primarily aims to strictly ensure that hrtimer_start is not called within the
> hrtimer's callback. However, doing so would require a lot of additional logic:
> We would need to add a callback parameter to strictly ensure that hrtimer_forward_now is
> executed within the callback and hrtimer_start is executed outside the callback. The
> occurrence of the WARN_ON in the CI test indicates that the method of using
> "hrtimer_is_queued to make the judgment" does not cover all scenarios. The fundamental
> reason for this is that the hrtimer_is_queued check must be precise, which requires
> protection from cpu_base->lock. Similarly, using hrtimer_callback_running check would not
> achieve precise judgment either. It is necessary to know on which CPU the hrtimer is running
> and send an IPI to execute hrtimer_forward_now using local_irq_save on that CPU to satisfy
> the aforementioned principle 2), as it is inappropriate to acquire the cpu_base->lock within
> the af_packet logic; the only way to ensure that the hrtimer_forward_now operation is
> executed without enqueueing the hrtimer is by disabling IRQs.
> 
> Since strictly ensuring that hrtimer_start is not called within the hrtimer's callback leads
> to a lot of extra logic, and logically, I have also demonstrated that it is permissible to
> call hrtimer_start within the hrtimer's callback (for the hrtimer module, the lock is
> cpu_base->lock, which is associated with the clock base where the hrtimer resides, and does
> not follow smp_processor_id()), it does not matter whether hrtimer_start is executed by the
> CPU executing the hrtimer callback or by another CPU; both scenarios are the same for the
> hrtimer module. TTherefore, I prefer to use the aforementioned method 1) to resolve this
> issue. If there are no concerns, I will reflect this in PATCH v7.

Thanks for the analysis.

Using hrtimer_start from within the callback that returns
HRTIMER_RESTART does not sound in line with the intention of the API
to me.

I think we should just adjust and restart from within the callback and
hrtimer_start from tpacket_rcv iff the timer is not yet queued.

Since all these modifications are made while the receive queue lock is
held I don't immediately see why we would need additional mutual
exclusion beyond that.


