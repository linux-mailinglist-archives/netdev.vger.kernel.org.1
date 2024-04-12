Return-Path: <netdev+bounces-87456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56498A3293
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639091F25AA9
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF2D1482F0;
	Fri, 12 Apr 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqG4KtYz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B61487E4
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936192; cv=none; b=Z8PT/mC+BUMJW354ML7Mit7QyKXVQd7UBetbHaTULDiPviTAQV4z6pPTt/6yi4936bZu5c4M4jkRb7nVqRLwW9rAjXfZTMsJQAJPilqIK4j6i1UIxv9j1nTzL3F/CgxqiQffq8Iq10/DWqvDLLs/gn21Ap0ZeMJtZd4HHWi0JkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936192; c=relaxed/simple;
	bh=p/g0mPRsHl0wBu7q1bDxx1/4gIIYZYrG29KsauoNnQU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FlwrQu5MmVaEeu5xAHQTO4wfmVNWjC72lhm+6LEJPgaAtMplFv0k+r89XKZ7tq+MlA2deh5fyyrEr5KRhXLdxKTcg28XNjoHhSuuobVVs6O+JhgZTmP/cvBDU1qjhTBrAbvvswgO9iu5mrXHAXRDcnOi52LqADO5235y5qEx6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqG4KtYz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78d61a716ddso65634085a.3
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712936189; x=1713540989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KssNzYoh6yejpI5S71OKxgR3WEkceco+D11r0+S34A=;
        b=CqG4KtYzL65/PBlAwwQTpv1yCyrhuCSaSZNh9u4+3YYXL7KK+vgk64IJA+7sfyHHrc
         JOnJeCOYZ/zSoYFpaIk5fOWQRDQVNY2T+dpLFwj0EJtv5AG8IAt5PRqaaO2dz3S8KaR3
         0aduCfbOT7RxHTrBXsDF40tNyi7qqZqW613SpJdo0CEeI7fIZfQZ7SIif7NWVk1HDKMB
         B9pQAHPwNLwytAFtgQcIrJZjhrUuivNlhJveL9OGSbs6j4ygToR9QyFQyNUiUO+rATTy
         8RcEOx0Q96cjH4G2m/+kANA5GcJ2L/vXhUYTzXGUPAG2uxBCiGsG3/o840M3+Dvo/oJe
         A6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936189; x=1713540989;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4KssNzYoh6yejpI5S71OKxgR3WEkceco+D11r0+S34A=;
        b=G5/D1H+sB3C1Jjr9a/NYDuYerRxNFVBvgu5KIjsDHiQxY0YneBKMhFEN+Ly2yAcl2M
         aISISsfILmDjA7y+svB6CgkZwwtsww/U8hffwFOwMbdRPj00piNiATtiQvC9YQJzZzIB
         of5DuJElodV6N2OahTRGB0ErL8e5qBEZoGSZeD1EU7aibp/u8MMWoZBnNcnEMl3uqWUn
         gePWmRFUN2+yabj+GPaXlbORYwkiDo15W3pj8/e3LMvtlUgWgvi6nrMMxxJ+4nFUA7o/
         evqXFNtUKyJh2wMsX7x6z3zotBpfy/7fD881utY1oM/Kbg96coQmUybE7F5NbBm1VrUx
         YB0A==
X-Gm-Message-State: AOJu0Yzwnx36YWKGWLM99nniNbU7F+xodmSa8FC++OWTsjpgi98fzj19
	TOTiCwOdCv924hsuFU9hdXm5pndol+O9XMi0E6UaAfP3vCUm0sMr
X-Google-Smtp-Source: AGHT+IF7gNeVPUl3XqXQ/3nsiRcv4d8DoKPJm1sBLcv1ZOcUf8XOkojqBkJj3hebxUT3GyGtZr2m+g==
X-Received: by 2002:a05:620a:1710:b0:78c:c56b:f63a with SMTP id az16-20020a05620a171000b0078cc56bf63amr3666103qkb.13.1712936189474;
        Fri, 12 Apr 2024 08:36:29 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id vv10-20020a05620a562a00b0078d6c4b0b3bsm2534976qkn.26.2024.04.12.08.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:36:29 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:36:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com
Message-ID: <661954fce5f33_38e2532949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <0ac5752d-0b36-436a-9c37-13e262334dce@bytedance.com>
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-3-zijianzhang@bytedance.com>
 <6615b264894a0_24a51429432@willemb.c.googlers.com.notmuch>
 <CANn89iLTiq-29ceiQHc2Mi4na+kRb9K-MA1hGMn=G0ek6-mfjQ@mail.gmail.com>
 <0c6fc173-45c4-463f-bc0e-9fed8c3efc02@bytedance.com>
 <66171b8b595b_2d123b29472@willemb.c.googlers.com.notmuch>
 <0ac5752d-0b36-436a-9c37-13e262334dce@bytedance.com>
Subject: Re: [External] Re: [PATCH net-next 2/3] selftests: fix OOM problem in
 msg_zerocopy selftest
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zijian Zhang wrote:
> On 4/10/24 4:06 PM, Willem de Bruijn wrote:
> >>>>> In this case, for some reason, notifications do not
> >>>>> come in order now. We introduce "cfg_notification_order_check" to
> >>>>> possibly ignore the checking for order.
> >>>>
> >>>> Were you testing UDP?
> >>>>
> >>>> I don't think this is needed. I wonder what you were doing to see
> >>>> enough of these events to want to suppress the log output.
> >>
> >> I tested again on both TCP and UDP just now, and it happened to both of
> >> them. For tcp test, too many printfs will delay the sending and thus
> >> affect the throughput.
> >>
> >> ipv4 tcp -z -t 1
> >> gap: 277..277 does not append to 276
> > 
> > There is something wrong here. 277 clearly appends to 276
> > 
> 
> ```
> if (lo != next_completion)
>      fprintf(stderr, "gap: %u..%u does not append to %u\n",
>          lo, hi, next_completion);
> ```
> 
> According to the code, it expects the lo to be 276, but it's 277.

Ack. I should have phrased that message better.
 
> > If you ran this on a kernel with a variety of changes, please repeat
> > this on a clean kernel with no other changes besides the
> > skb_orphan_frags_rx loopback change.
> > 
> > It this is a real issue, I don't mind moving this behind cfg_verbose.
> > And prefer that approach over adding a new flag.
> > 
> > But I have never seen this before, and this kind of reordering is rare
> > with UDP and should not happen with TCP except for really edge cases:
> > the uarg is released only when both the skb was delivered and the ACK
> > response was received to free the clone on the retransmit queue.
> 
> I found the set up where I encountered the OOM problem in msg_zerocopy
> selftest. I did it on a clean kernel vm booted by qemu, 
> dfa2f0483360("tcp: get rid of sysctl_tcp_adv_win_scale") with only
> skb_orphan_frags_rx change.
> 
> Then, I do `make olddefconfig` and turn on some configurations for
> virtualization like VIRTIO_FS, VIRTIO_NET and some confs like 9P_FS
> to share folders. Let's call it config, here was the result I got,
> ```
> ./msg_zerocopy.sh
> ipv4 tcp -z -t 1
> ./msg_zerocopy: send: No buffer space available
> rx=564 (70 MB)
> ```
> 
> Since the TCP socket is always writable, the do_poll always return True.
> There is no any chance for `do_recv_completions` to run.
> ```
> while (!do_poll(fd, POLLOUT)) {
>      if (cfg_zerocopy)
>          do_recv_completions(fd, domain);
>      }
> ```
> Finally, the size of sendmsg zerocopy notification skbs exceeds the 
> opt_mem limit. I got "No buffer space available".
> 
> 
> However, if I change the config by
> ```
>   DEBUG_IRQFLAGS n -> y
>   DEBUG_LOCK_ALLOC n -> y
>   DEBUG_MUTEXES n -> y
>   DEBUG_RT_MUTEXES n -> y
>   DEBUG_RWSEMS n -> y
>   DEBUG_SPINLOCK n -> y
>   DEBUG_WW_MUTEX_SLOWPATH n -> y
>   PROVE_LOCKING n -> y
> +DEBUG_LOCKDEP y
> +LOCKDEP y
> +LOCKDEP_BITS 15
> +LOCKDEP_CHAINS_BITS 16
> +LOCKDEP_CIRCULAR_QUEUE_BITS 12
> +LOCKDEP_STACK_TRACE_BITS 19
> +LOCKDEP_STACK_TRACE_HASH_BITS 14
> +PREEMPTIRQ_TRACEPOINTS y
> +PROVE_RAW_LOCK_NESTING n
> +PROVE_RCU y
> +TRACE_IRQFLAGS y
> +TRACE_IRQFLAGS_NMI y
> ```
> 
> Let's call it config-debug, the selftest works well with reordered
> notifications.
> ```
> ipv4 tcp -z -t 1
> gap: 2117..2117 does not append to 2115
> gap: 2115..2116 does not append to 2118
> gap: 2118..3144 does not append to 2117
> gap: 3146..3146 does not append to 3145
> gap: 3145..3145 does not append to 3147
> gap: 3147..3768 does not append to 3146
> ...
> gap: 34935..34935 does not append to 34937
> gap: 34938..36409 does not append to 34936
> 
> rx=36097 (2272 MB)
> missing notifications: 36410 < 36412
> tx=36412 (2272 MB) txc=36410 zc=y
> ```
> For exact config to compile the kernel, please see
> https://github.com/Sm0ckingBird/config

Thanks for sharing the system configs. I'm quite surprised at these
reorderings *over loopback* with these debug settings, and no weird
qdiscs that would explain it. Can you see whether you see drops and
retransmits?

> 
> I also did selftest on 63c8778d9149("Merge branch 
> 'net-mana-fix-doorbell-access-for-receive-queues'"), the parent of 
> dfa2f0483360("tcp: get rid of sysctl_tcp_adv_win_scale")
> 
> with config, selftest works well.
> ```
> ipv4 tcp -z -t 1
> missing notifications: 223181 < 223188
> tx=223188 (13927 MB) txc=223181 zc=y
> rx=111592 (13927 MB)
> ```
> 
> with config-debug, selftest works well with reordered notifications
> ```
> ipv4 tcp -z -t 1
> ...
> gap: 30397..30404 does not append to 30389
> gap: 30435..30442 does not append to 30427
> gap: 30427..30434 does not append to 30443
> gap: 30443..30450 does not append to 30435
> gap: 30473..30480 does not append to 30465
> gap: 30465..30472 does not append to 30481
> gap: 30481..30488 does not append to 30473
> tx=30491 (1902 MB) txc=30491 zc=y
> rx=15245 (1902 MB)
> ```
> 
> Not sure about the exact reason for this OOM problem, and why
> turning on DEBUG_LOCKDEP and PROVE_RAW_LOCK_NESTING can solve
> the problem with reordered notifications...

The debug config causes the reordering notifications, right? But
solves the OOM.

> If you have any thoughts or
> comments, please feel free to share them with us.
> 
> If the problem does exist, I guess we can force `do_recv_completions`
> after some number of sendmsgs and move "gap: ..." after cfg_verbose?

I do want to understand the issue better. But not sure when I'll find
the time.

Both sound reasonable to me, yes.

