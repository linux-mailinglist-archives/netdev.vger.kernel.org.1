Return-Path: <netdev+bounces-215042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D27B2CDBA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100783AFEBB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489F310635;
	Tue, 19 Aug 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXym7sMQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88878273D6D;
	Tue, 19 Aug 2025 20:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634907; cv=none; b=akrT0hFIHY5Hu2D5nFCo1cM86L2SJRnd5nKNpYpD78PcnzSbYmnKZaiCoVRBhExlCEDh3lfqJLHxPYZXIC/d0pZPjZjl2jfbENOONz/+jpovsNiA683mnT+hHn9nxSG/RhqNOPXbzxpdKb4NY1NyLIyeXIaA7Kn2GYEwBgFfKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634907; c=relaxed/simple;
	bh=JmwDj0yM2hIxDCp945snAW1tIJFxf+MqSewCaUoodss=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p1SEXsCM1JCs4/aiugOT8P0ZGi24Y1+0qGN1wopIeIwLaWnEDAMvS6YoaUhgBkHRQR5Gqbg3HIP/HSW3D4Bg/DYuoi8jzIb1xbq+lhCZRBD9De27tG5KPlVRrLVfN9uRHwh0oLkCfWo5XlTYHkAv14k6zJlLNEt4cgPP0hCquAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXym7sMQ; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-50f8ac28305so1634685137.2;
        Tue, 19 Aug 2025 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755634904; x=1756239704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErXHqYgIOywZbhEmGRe/ErbrEiUlQahOfnrKJ/dVBS8=;
        b=kXym7sMQWH8RB444zFBgw+QATLySe6glH/b5qxhUK0pzAKhL1/plvjVqNE2j97sRl5
         6QwMygP+aXbpThTsD7vNWQe//e4IcJViCMSyADCbcxaNCsF0b0dSA+dTabQawrOcE97t
         Be2F3C4HHMpqcXGM5O8Pf3WudDDW2M6Kd2tjJvU+A0iX6bO/XrVAMccjPJHWqBhE3cmi
         Nak/2PAxwUNL70GyiK4nkDVs3GWGEKUFZMUZHRIeqDhJt1OLzFkutbR45puyEKbCvKn4
         jqHuYPEd49m3tQs/7uv7pxfalmXDlT81TgD9A0/mCWxv14bqWwTiOZ29a+nJ3bLbxKIk
         QB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755634904; x=1756239704;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ErXHqYgIOywZbhEmGRe/ErbrEiUlQahOfnrKJ/dVBS8=;
        b=f9MycN94hZ253CUYyXA+DRmwdbddJ+RCVCPdNuGOkv37sDnRn2CSmnFLextR1B2o0o
         RajSJVPGSDvFaBPpYf2q8iboiskB98B+GwNm5Gbjc02LQlXh4iF68D4BovG7T16lGaIq
         R9D2vzMLP9f+WbMCyIR9XFhmMS2iVDp5eqjHFPmpC7PHHvqk4sbCcW1pugvnMQVvoFYQ
         QHNdwlxf87dVF1LeMaUWTXzRoL0K2CEqLRxU0nyRyXMiguI7QT1sNT4wwa6ge0MVv0U8
         UCsr9/BBSh1pWuDqXcDtYDzRdOBietnvnpFiWi355tXJIrAN1c2vtrkowf5NPR620b6h
         Mf7g==
X-Forwarded-Encrypted: i=1; AJvYcCVdOTXAI+XtkWabZJeU1smwJfyienfH4jUI94Gugngkqc2k3JkCO5TaVufaGryaK3/yoi2YuszKZHHgq8M=@vger.kernel.org, AJvYcCWM39exxLFueXZaeg6Q5YunqiSsed8sUOe4B375polTa9Y4GKjdvVGRWU254upiMfnTwlIMNHBc@vger.kernel.org
X-Gm-Message-State: AOJu0YwSd1lpgLkZ50Ovn50oZ/4IPlAzM69QIXJFrBSEKrj2TE/9xKMG
	w0qYLrA29ULoOQmooWeKeLf4dVbmo1WOtSxCZYCUwljLoh+BroTpOFL9
X-Gm-Gg: ASbGncsiIoIwSJipUPey4YlSa9/lZDDlL7gSl737AlKoFJ3lSANiLRWXc9jj/QgsL7z
	tDCqQAWDEMmtS88e99OIKCWZtgS9o3UkHp3J4dk4U1DJEPvLWKbcy+12G+x3q0Z2PSAHtVekHS4
	l6muw3+e4izLgw1xKfBMoG8Vpswnm5xRXdurEyUR1E+1hGwyf7lOKCMiwJbi4BL+EZJ+X/55zc5
	D6ehmdbjFbqTYYG+q1tmA0PeWxxTbPb1URsRXDtVdIdzEAhhehVrFA7WEe7+ucX/uCSEXGX5J0W
	qDly+BqDcxd/sT1evSHsj0rWygY/ATgxTlIlW4xj7qu+oKn9SOlISbYMQ00yFWhGkCpWbK63anG
	33DnxNbt9FUKoRO1MmKlEXggrGScdKvzSQuHYmE7uNjQR0rURizGWjUxw9jKG8puy+wzMvA==
X-Google-Smtp-Source: AGHT+IFq5Fb+q6BwoXTONR8NfLqJRLAaqNnVbQWhZLboOUU4G8eeT+JswvN12+19Oc8bDG+85E18Yw==
X-Received: by 2002:a05:6102:5128:b0:4fb:f2ff:dd16 with SMTP id ada2fe7eead31-51a51ebe471mr181179137.17.1755634904269;
        Tue, 19 Aug 2025 13:21:44 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5127f80546fsm3109808137.14.2025.08.19.13.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:21:43 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:21:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Xin Zhao <jackzxcui1989@163.com>, 
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
Message-ID: <willemdebruijn.kernel.85f8d3f87b8b@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1a86f7d92a05a@gmail.com>
References: <20250819091447.1199980-1-jackzxcui1989@163.com>
 <willemdebruijn.kernel.1a86f7d92a05a@gmail.com>
Subject: Re: [PATCH net-next v5] net: af_packet: Use hrtimer to do the retire
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

Willem de Bruijn wrote:
> Xin Zhao wrote:
> > In a system with high real-time requirements, the timeout mechanism of
> > ordinary timers with jiffies granularity is insufficient to meet the
> > demands for real-time performance. Meanwhile, the optimization of CPU
> > usage with af_packet is quite significant. Use hrtimer instead of timer
> > to help compensate for the shortcomings in real-time performance.
> > In HZ=100 or HZ=250 system, the update of TP_STATUS_USER is not real-time
> > enough, with fluctuations reaching over 8ms (on a system with HZ=250).
> > This is unacceptable in some high real-time systems that require timely
> > processing of network packets. By replacing it with hrtimer, if a timeout
> > of 2ms is set, the update of TP_STATUS_USER can be stabilized to within
> > 3 ms.
> > 
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> 
> > -static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc)
> > +static void _prb_refresh_rx_retire_blk_timer(struct tpacket_kbdq_core *pkc,
> > +					     bool start, bool callback)
> >  {
> > -	mod_timer(&pkc->retire_blk_timer,
> > -			jiffies + pkc->tov_in_jiffies);
> > +	unsigned long flags;
> > +
> > +	local_irq_save(flags);
> 
> The two environments that can race are the timer callback running in
> softirq context or the open_block from tpacket_rcv in process context.

I meant prb_open_block

tpacket_rcv runs in softirq context (from __netif_receive_skb_core)
or with bottom halves disabled (from __dev_queue_xmit, or if rx uses
napi_threaded).

That is likely why the spin_lock_bh variant is not explicitly needed.

> So worst case the process context path needs to disable bh?
> 
> As you pointed out, the accesses to the hrtimer fields are already
> protected, by the caller holding sk.sk_receive_queue.lock.
> 
> So it should be sufficient to just test hrtimer_is_queued inside that
> critical section before calling hrtimer_start?
> 
> Side-note: tpacket_rcv calls spin_lock, not spin_lock_bh. But if the
> same lock can also be taken in softirq context, the process context
> caller should use the _bh variant. This is not new with your patch.
> Classical timers also run in softirq context. I may be overlooking
> something, will need to take a closer look at that.
> 
> In any case, I don't think local_irq_save is needed. 
> 
> > +	if (start && !callback)
> > +		hrtimer_start(&pkc->retire_blk_timer, pkc->interval_ktime,
> > +			      HRTIMER_MODE_REL_SOFT);
> > +	else
> > +		hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
> > +	local_irq_restore(flags);
> >  	pkc->last_kactive_blk_num = pkc->kactive_blk_num;
> >  }



