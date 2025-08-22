Return-Path: <netdev+bounces-215928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67081B30F13
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B086685BDC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC92E54B9;
	Fri, 22 Aug 2025 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzrP7DC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601611C2324;
	Fri, 22 Aug 2025 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844670; cv=none; b=ctfuA7TIUGGV+ISqHaXVS99YFBsxYUVfBSGyWn4SvK2VIeHh/cPPW9TBppxca78QLXTUz4hipHrkiA7SLMvxlhE+lTQAb6pRXqeLvjao7VRafZtRhI+9RHEDTZkbfc8w4ENzwigAaSLTf7+IOA6d/MioJU45Z2ZO9FstcVtkfII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844670; c=relaxed/simple;
	bh=3ptJvRkorx30o/nmj79EaSDid0byC9I3VNPmVg+/Eqg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Jeds1DRXg3qImQ8owoN5EZUalw/NL1w+x0tt7hKm5MaEa5DNJbyqMqROai+V0aWtnlfRHzaMer4nshHlZKhhnM6hEWQlfhYm2CsE1E5Gi/433jHiw/hqvZJaznplvPF4WxHCUjE3xlUyyCQrQ8LbuSnglj9BlXuz8rem98WNZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzrP7DC/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109bcceb9so21817181cf.2;
        Thu, 21 Aug 2025 23:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755844668; x=1756449468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksGVMnBHOv+KVHUZNMSVUIxA0uiJlyV/kU3aXFvzdl0=;
        b=AzrP7DC/X6drB5ee8bCYKslliZ1hKM0MN0Fga1dkOKbvfEkXWwcjdeIi4nm8owT/GH
         O93dKtMe/gYB5FSD0n4LSNzoeoR19q6uKEQsV99ay4ANHmp0dUGUCXudUpLIxNaAZm+Q
         8Tv7MZq/OCqbxFrD2ZAky09by8qhYAqAzkM9PWWuPLV6p7lx8aCrsShNy1m7bJT5d8YK
         X423AZ//wfjzKtdv9EoZ3crQNWs9G5+ByYWLh1A0x9ACoprALI1aTYQ64W6PdZEpur4I
         xKE7J+gwmQgrPE7PPsNX3wtvg2IDUkd0MznxQ5n9OO8n8HoWQhbgTGaN9TubAjglxJ/1
         Q+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755844668; x=1756449468;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ksGVMnBHOv+KVHUZNMSVUIxA0uiJlyV/kU3aXFvzdl0=;
        b=XSGry6fJ+n4sitcLskriGIXd1HMG/gqme2iGpt5n8W5OCZDYpQlaZ1Ku3N0HeW6KeS
         cw8VP2AWCpljv5Pf4z/bajq0h9+bPeWX2B3bjNLQY3WtVX6jLmqrqpjcebWndZJZM5H+
         NTGREKNxOUMD3FOkr/CIIx3GBhvT1bYR0H55/rppZiXNEJOWbf1N4i98Y2jv59perFs6
         0eQRJAHfNNVRB/TAZIH1Ndq73ky6i08Ze7+p415d8UULSTsjEi71YsCsOB9s0lj4CT+1
         DLEhifedfFZx719GrgVzDrgQOu+WjmtSHAlxkAfmEneJHUzDGeYjK4ZrQG0tAE6KEuny
         M0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCX1/1V8bajXSzzI1ldC2PMU7tBtPODbba1VSLas5LXU3rFzetorq/Fw5UhX/HgsnJknVYpx2ifEzIsYmds=@vger.kernel.org, AJvYcCXT1Jvvc7cqDltsmqnIUzu/bk4uh/Vk4nPgYybFXphZ626g7UD5UWs7f0+0JK/+6IDCu+s2QKdS@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkeYWmibMS3M0qd0noPybz5mhTUdyg2eKjOnYH4SagPt3tIFL
	Zujo4VnIypq387CzjdARRpySVCVtW/Jrql7hXvXLw9DgLcvZ2CskrKpZ
X-Gm-Gg: ASbGnct/MNVXBJu62OtXEhkjxEgMiT0mvgfdejQXZk2TIjAp+2SqYvpdgGr/8U1OiAK
	odOAl1U8xIwIZXidHNyfs/00ZvPRidCP7sfpE6ha+ylegHHqlz1f1nrl8JnJG9qvgyR8aNQVNTy
	VDQYIVOtIvJIcg5wfysq3SLkof+gWZigwmhS9H4dkjisSwUJ0+NDfoZ0vLKX12tkIV5P+C9dPlO
	7IKUXA+cqmqYFAmszndtNShUZ9NNqZmPdevSS4OPrVoVormHLxkvtrQgz8Nae3mJWpL5wlul7X/
	QAjsCzIwpQd/eaiT8EwMJkOvIMq7AAnqkprRHNIzUE5nlznDbwQuiECR4SzHmOR735PNPiXYBiL
	y95YTeKmqnx9H0EGDw48cG+UcnlGR8tC3vZFuvEkOI5ixBLNfvBs6ChBeLu5gHsitdddnMw==
X-Google-Smtp-Source: AGHT+IF2PXmBBcwCdu2yhQ0+8QZamETgDCeN5gb9pcPrOutvGtnte/i38ECCZbepNGyT8JslDhUUUg==
X-Received: by 2002:ac8:5e12:0:b0:4ae:6b72:2ae2 with SMTP id d75a77b69052e-4b2aaacef55mr19784391cf.40.1755844668104;
        Thu, 21 Aug 2025 23:37:48 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b27e7810f0sm70469551cf.47.2025.08.21.23.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:37:47 -0700 (PDT)
Date: Fri, 22 Aug 2025 02:37:45 -0400
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
Message-ID: <willemdebruijn.kernel.60ba954529f7@gmail.com>
In-Reply-To: <20250821153017.3607708-1-jackzxcui1989@163.com>
References: <20250821153017.3607708-1-jackzxcui1989@163.com>
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
> On Thu, 2025-08-21 at 22:32 +0800, Willem wrote:
> 
> > Thanks for the analysis.
> > 
> > Using hrtimer_start from within the callback that returns
> > HRTIMER_RESTART does not sound in line with the intention of the API
> > to me.
> > 
> > I think we should just adjust and restart from within the callback and
> > hrtimer_start from tpacket_rcv iff the timer is not yet queued.
> > 
> > Since all these modifications are made while the receive queue lock is
> > held I don't immediately see why we would need additional mutual
> > exclusion beyond that.
> 
> 
> The hrtimer callback is called by __run_hrtimer, if we only use hrtimer_forward_now in the callback,
> it will not restart the time within the callback. The timer will be enqueued after the callback
> return. So when the timer is being enqueued, it is not protected by sk_receive_queue.lock.

I see.
 
> Consider the following timing sequence:
> timer   cpu0 (softirq context, hrtimer timeout)                cpu
> 0       hrtimer_run_softirq
> 1         __hrtimer_run_queues
> 2           __run_hrtimer
> 3             prb_retire_rx_blk_timer_expired
> 4               spin_lock(&po->sk.sk_receive_queue.lock);
> 5               _prb_refresh_rx_retire_blk_timer
> 6                 hrtimer_forward_now
> 7               spin_unlock(&po->sk.sk_receive_queue.lock)
> 8             raw_spin_lock_irq(&cpu_base->lock);              tpacket_rcv
> 9             enqueue_hrtimer                                    spin_lock(&sk->sk_receive_queue.lock);
> 10                                                               packet_current_rx_frame
> 11                                                                 __packet_lookup_frame_in_block
> 12            finish enqueue_hrtimer                                 prb_open_block
> 13                                                                     _prb_refresh_rx_retire_blk_timer
> 14                                                                       hrtimer_is_queued(&pkc->retire_blk_timer) == true
> 15                                                                       hrtimer_forward_now
> 16                                                                         WARN_ON
> 
> On cpu0 in the timing sequence above, enqueue_hrtimer is not protected by sk_receive_queue.lock,
> while the hrtimer_forward_now is not protected by raw_spin_lock_irq(&cpu_base->lock).
> 
> It will cause WARN_ON if we only use 'hrtimer_is_queued(&pkc->retire_blk_timer) == true' to check
> whether to call hrtimer_forward_now.

One way around this may be to keep the is_timer_queued state inside
tpacket_kbdq_core protected by a relevant lock, like the receive queue
lock. Similar to pkc->delete_blk_timer.

Admittedly I have not given this much thought yet. Am traveling for a
few days, have limited time.
 
> 
> Thanks
> Xin Zhao
> 



