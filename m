Return-Path: <netdev+bounces-232287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 96086C03E6D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1600434B873
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144D2BD5BF;
	Thu, 23 Oct 2025 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4wVXkmy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C627F00A
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263582; cv=none; b=qZ37719r8LK6h5UfBP5eaujqKkrCsoN8kurN7s03actrcd11hK+Ks9TVdOKEMvmGy9p0qlhmd+y0l7fFBp25/7EmQdc9eh0ljsTx6f+qZngWQ5+m24f3aEeXQWv4dFR3Mx5Ytxr7NarajXPH+82m55xRrExDnOHbGUtDB2CSILs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263582; c=relaxed/simple;
	bh=AT3+wNihqmSYhjuBv/jofqfpVzIh8fFWtMB1yLIwi3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rqYXluUNGypyb+3W3SLS+BRwdzwdxT9N+95UP9j3hTY7n5JBVPjmkGjhPN/avNKQgcji24ksh9EuEWGzLHQxlAeLWgzvS31a3FQqsRgAOHEJzO0ZOeVvLN4CUzgBHKpA7arUfJaWFd5zd/H+Awf6/lHS7CSV0Nj1+p4/vzy2V+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4wVXkmy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc08so3308361a91.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761263580; x=1761868380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eo2oCT09CGUkGtiJETLA5OKUbDW0FKSCX+nZlCeQsGg=;
        b=k4wVXkmyhyqE9l48IJCLR9XPDG1UoTKsy9jmc5uMJFWTWMywf+DoPWrg2gHCuuqVYr
         LeCUKQ6rVFOZ3IdqCgaf3gLEP+R6kAeYJ6vru8xogcHofAqs0i3RcTgtq150S9d8f6c/
         ysCzsBZGiS4S4Si6DGe2UgqUevd6olZ/o8vgLrI0tZQBYM6rBecHctibwKw6pZMIvTnD
         bQCwq3C6wXXs9Ao6TuO3Hmia2d7HcQiTZGQkXahVHFrXFxzFXOxmi0Wp2prR6ih4UUyG
         T874NM7LkFEuXMv2a21EohwkciFnboHNC/4y9dZQ5fQzxhBkAn3W1viKYTEXDM5jfsKn
         J6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761263580; x=1761868380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eo2oCT09CGUkGtiJETLA5OKUbDW0FKSCX+nZlCeQsGg=;
        b=kI5/c9+0NIqMdvfBP7rSFuj0VMTSJRJ3XK9dvHzPkmBOCXpJAGd/xy6du5B0d9uQca
         lxGGU7ZjSwyyHPSo869L8qhwGCkDeeK8xd1vg5XmllBngW2ZOm5Vv3/6fPy4O+EvW66I
         WoOr95ZDKFmbmc5FtqAiHS8v1icIkDhzKFUY8qt3uzzRK26x4JOC7GOa5BNc/sIJebDC
         +L/wfRE7198RYVsmndk4s/mZH7vFexpnQhJEkIY7P2Usc5T9oMJnnCfujZoX0b/EDCUq
         A9u28ebJok54lEjgl5AuDMWVkXHkOLzBZZlTtqRXwqF8q2E1v1gW1dFK5peaJ/5PPz+s
         t/cw==
X-Forwarded-Encrypted: i=1; AJvYcCXIgAzb7W0eceRHVqQKGsA7cg1Zhm4Rck+JeZWbAFCq8gCZ6p3rsMy52obvTBX9/ieZVxbLGC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVTXPZEKDwObG5kqh4iTTJfTO03am0e1rrK6HYBcWE3zX3KU9A
	vWc3jTWszkVTUo5IxFfoob8M2HMnTwvGU0T5M9lqNHxx4w6ZujZcT3ECldi2nN6cIfW7pB6Grus
	SXLqppQ==
X-Google-Smtp-Source: AGHT+IEQOeSykRo4Rj5MaMzLbvjbffFfTFsbM/EOLn0WBNXCeu8l+VNyetqRrDtzeRuqnAV/p+uqxvFuzh4=
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:33b:b3b8:216b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5105:b0:32e:e3af:45f6
 with SMTP id 98e67ed59e1d1-33bcf87b6a4mr33427079a91.10.1761263580523; Thu, 23
 Oct 2025 16:53:00 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:52:38 +0000
In-Reply-To: <20251023191807.74006-2-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023191807.74006-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023235259.4179388-1-kuniyu@google.com>
Subject: Re: [PATCH net] sctp: Hold RCU read lock while iterating over address list
From: Kuniyuki Iwashima <kuniyu@google.com>
To: stefan.wiehler@nokia.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Stefan Wiehler <stefan.wiehler@nokia.com>
Date: Thu, 23 Oct 2025 21:18:08 +0200
> With CONFIG_PROVE_RCU_LIST=y and by executing
> 
>   $ netcat -l --sctp &
>   $ netcat --sctp localhost &
>   $ ss --sctp
> 
> one can trigger the following Lockdep-RCU splat(s):
> 
>   WARNING: suspicious RCU usage
>   6.18.0-rc1-00093-g7f864458e9a6 #5 Not tainted
>   -----------------------------
>   net/sctp/diag.c:76 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   2 locks held by ss/215:
>    #0: ffff9c740828bec0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netlink_dump_start+0x84/0x2b0
>    #1: ffff9c7401d72cd0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_sock_dump+0x38/0x200
> 
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 215 Comm: ss Not tainted 6.18.0-rc1-00093-g7f864458e9a6 #5 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5d/0x90
>    lockdep_rcu_suspicious.cold+0x4e/0xa3
>    inet_sctp_diag_fill.isra.0+0x4b1/0x5d0
>    sctp_sock_dump+0x131/0x200
>    sctp_transport_traverse_process+0x170/0x1b0
>    ? __pfx_sctp_sock_filter+0x10/0x10
>    ? __pfx_sctp_sock_dump+0x10/0x10
>    sctp_diag_dump+0x103/0x140
>    __inet_diag_dump+0x70/0xb0
>    netlink_dump+0x148/0x490
>    __netlink_dump_start+0x1f3/0x2b0
>    inet_diag_handler_cmd+0xcd/0x100
>    ? __pfx_inet_diag_dump_start+0x10/0x10
>    ? __pfx_inet_diag_dump+0x10/0x10
>    ? __pfx_inet_diag_dump_done+0x10/0x10
>    sock_diag_rcv_msg+0x18e/0x320
>    ? __pfx_sock_diag_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x4d/0x100
>    netlink_unicast+0x1d7/0x2b0
>    netlink_sendmsg+0x203/0x450
>    ____sys_sendmsg+0x30c/0x340
>    ___sys_sendmsg+0x94/0xf0
>    __sys_sendmsg+0x83/0xf0
>    do_syscall_64+0xbb/0x390
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    ...
>    </TASK>
> 
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
> It might be sufficient to add a check for one of the already held locks,
> but I lack the domain knowledge to be sure about that...
> ---
>  net/sctp/diag.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 996c2018f0e6..1a8761f87bf1 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -73,19 +73,23 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
>  	struct nlattr *attr;
>  	void *info = NULL;
>  
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(laddr, address_list, list)
>  		addrcnt++;
> +	rcu_read_unlock();
>  
>  	attr = nla_reserve(skb, INET_DIAG_LOCALS, addrlen * addrcnt);
>  	if (!attr)
>  		return -EMSGSIZE;
>  
>  	info = nla_data(attr);
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(laddr, address_list, list) {
>  		memcpy(info, &laddr->a, sizeof(laddr->a));
>  		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
>  		info += addrlen;

looks like TOCTOU issue exists here, we should check
the boundary like this:

		if (!--addrcnt)
			break;

Otherwise KASAN would complain about an out-of-bound write.

>  	}
> +	rcu_read_unlock();
>  
>  	return 0;
>  }
> -- 
> 2.51.0

