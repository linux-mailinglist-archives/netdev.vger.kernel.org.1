Return-Path: <netdev+bounces-91459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC578B2A59
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 23:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2641F21344
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A59153812;
	Thu, 25 Apr 2024 21:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X00i172Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8F14F9ED
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078900; cv=none; b=RfZi27RDpcUDlutmUJRJYnZwzBId0P0RofUnx8a1RYTFFOiPztqL5jQN6pZ38P7IwRLVy0IXnQceBuCdWXYl7cOoefwLHfeHNWvgUaDGSGeUbg4N2UmYw/DgHj4F+xE2/PBy9J0LTXRGHn2V+kjpDDu0R9TMXhgd64RU0LkTkt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078900; c=relaxed/simple;
	bh=bi6tTdZm8ODbcuOduzGa1ERUaCo+bFyLKRsaMStMaUs=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=p+Q2wCVMuPUg9JnmaFUuisrrxV2ZU/9dYpY0vjsAlDgTKU08ZYwc20z0T/b6M6UXXQsKPWOrW3+glXahT0HNEHF5GEBm6T0U4huVSUN1nCjizNvo4Jvwtpp6dg7ON6PZa0Bp3YztOQryYofuL0R9c9qWTRXMEpv7+AhnxH/5Rok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X00i172Q; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78f103d9f64so182129285a.0
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714078898; x=1714683698; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aOPBXjAr7bA8ZbQoSogAAAqU2GLn9V4a97bYFy2/Yqg=;
        b=X00i172Qn8Q/n6uzD6Z74aPvqdXWAHTh9sfG30HVHW2/sEz3EYF1EDQn21pGhW2tZn
         Che+EOkKvcKTqrvIlsXegG3HWdmhDbJ6IqfQY6E2IsW7QsLmY0eHlIxLFF9oHkNXUkAY
         HODmbdVkjTbINdK6u/JjqY+jRvCU9TjKXVhf84l0nIuJa9K+0WvI9Cu8ThakldO04+vQ
         lMq8h0PZAYsjaLBIxfHUPN88U8WpWlD7WEf3s9/iB9+lEeLYT6/4ljJh8emGsvbvbsHO
         uh4UO9m+7FTdAyPabrv9MSJmCXVY/G+OCW/939EmfAI5Y3MObrHoi4BmO+V+pzApxkWU
         wfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714078898; x=1714683698;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOPBXjAr7bA8ZbQoSogAAAqU2GLn9V4a97bYFy2/Yqg=;
        b=lGGEBDIFONTnE62wM+Jfr2aa2ha3VV3tcSEAASy5FCuMki9oezuauVeOHF/WcU8wFE
         w10XWCFk1Dx4oRGnHwCpeqSDpGXUef9cJb40rK4EZQcMaHjf3WBOTbs6wnJKCJKl4t6R
         7n1HB6vjAPx4Qm029fPbeN+A+WhpAFRfIX3JyWLlugk690ivgK85f4K8H/acu7ldPAfu
         Ba7NG4MJONdeKUlPT3wEdCQpReyfAD1oCZj0WuWPzgbXHK68lhkSbcBPV3q2oVoyY/Gj
         baT3HNZEzigv2PM6EX/oSKupAevuXHixa0OlUE/zR8j30bfI7WFTSzlzzyHrywtEhdMw
         ix7w==
X-Forwarded-Encrypted: i=1; AJvYcCUELyBsThZWgnlzsZZ20ppfz38Hz/M+5ZN0T3ivGYPzrH9kXvRK+yi+K4Oso3lvhNMzN6C6obKt3GLnyx5WXtRFR+cnfJSM
X-Gm-Message-State: AOJu0YxhpzneWL1GVRYUTXDvYyfH7vw2vvW6iBkOoxybGizuTeuvifU+
	Rwc4yVbvOjeqlJJxoNuSbC/DlSGaNIuBWtElmRrrLU1I5eAHUhbSb4U/l9N2bw==
X-Google-Smtp-Source: AGHT+IE7OTRE50eLvfVa1xG4lybp6Q7Od2V1GbZuTecWBu1/r4AgbQlzwRolyaBj4t8Ezb2H6vSuEg==
X-Received: by 2002:a05:620a:450d:b0:790:a960:28f4 with SMTP id t13-20020a05620a450d00b00790a96028f4mr715658qkp.25.1714078897594;
        Thu, 25 Apr 2024 14:01:37 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a245300b0078ebe12976dsm7354692qkn.19.2024.04.25.14.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 14:01:37 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:01:36 -0400
Message-ID: <b6f94a1fd73d464e1da169e929109c3c@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Davide Caratti <dcaratti@redhat.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org, Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH v2] netlabel: fix RCU annotation for IPv4 options on socket  creation
References: <c1ba274b19f6d1399636d018333d14a032d05454.1713967592.git.dcaratti@redhat.com>
In-Reply-To: <c1ba274b19f6d1399636d018333d14a032d05454.1713967592.git.dcaratti@redhat.com>

On Apr 24, 2024 Davide Caratti <dcaratti@redhat.com> wrote:
> 
> Xiumei reports the following splat when netlabel and TCP socket are used:
> 
>  =============================
>  WARNING: suspicious RCU usage
>  6.9.0-rc2+ #637 Not tainted
>  -----------------------------
>  net/ipv4/cipso_ipv4.c:1880 suspicious rcu_dereference_protected() usage!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  1 lock held by ncat/23333:
>   #0: ffffffff906030c0 (rcu_read_lock){....}-{1:2}, at: netlbl_sock_setattr+0x25/0x1b0
> 
>  stack backtrace:
>  CPU: 11 PID: 23333 Comm: ncat Kdump: loaded Not tainted 6.9.0-rc2+ #637
>  Hardware name: Supermicro SYS-6027R-72RF/X9DRH-7TF/7F/iTF/iF, BIOS 3.0  07/26/2013
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0xa9/0xc0
>   lockdep_rcu_suspicious+0x117/0x190
>   cipso_v4_sock_setattr+0x1ab/0x1b0
>   netlbl_sock_setattr+0x13e/0x1b0
>   selinux_netlbl_socket_post_create+0x3f/0x80
>   selinux_socket_post_create+0x1a0/0x460
>   security_socket_post_create+0x42/0x60
>   __sock_create+0x342/0x3a0
>   __sys_socket_create.part.22+0x42/0x70
>   __sys_socket+0x37/0xb0
>   __x64_sys_socket+0x16/0x20
>   do_syscall_64+0x96/0x180
>   ? do_user_addr_fault+0x68d/0xa30
>   ? exc_page_fault+0x171/0x280
>   ? asm_exc_page_fault+0x22/0x30
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>  RIP: 0033:0x7fbc0ca3fc1b
>  Code: 73 01 c3 48 8b 0d 05 f2 1b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 f1 1b 00 f7 d8 64 89 01 48
>  RSP: 002b:00007fff18635208 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
>  RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fbc0ca3fc1b
>  RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
>  RBP: 000055d24f80f8a0 R08: 0000000000000003 R09: 0000000000000001
> 
> R10: 0000000000020000 R11: 0000000000000246 R12: 000055d24f80f8a0
>  R13: 0000000000000000 R14: 000055d24f80fb88 R15: 0000000000000000
>   </TASK>
> 
> The current implementation of cipso_v4_sock_setattr() replaces IP options
> under the assumption that the caller holds the socket lock; however, such
> assumption is not true, nor needed, in selinux_socket_post_create() hook.
> 
> Let all callers of cipso_v4_sock_setattr() specify the "socket lock held"
> condition, except selinux_socket_post_create() _ where such condition can
> safely be set as true even without holding the socket lock.
> While at it: use rcu_replace_pointer() instead of open coding, and remove
> useless NULL check of 'old' before kfree_rcu(old, ...).
> 
> v2:
>  - pass lockdep_sock_is_held() through a boolean variable in the stack
>    (thanks Eric Dumazet, Paul Moore, Casey Schaufler)
>  - use rcu_replace_pointer() instead of rcu_dereference_protected() +
>    rcu_assign_pointer()
>  - remove NULL check of 'old' before kfree_rcu()
> 
> Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>  include/net/cipso_ipv4.h     |  6 ++++--
>  include/net/netlabel.h       |  6 ++++--
>  net/ipv4/cipso_ipv4.c        | 13 ++++++-------
>  net/netlabel/netlabel_kapi.c |  9 ++++++---
>  security/selinux/netlabel.c  |  5 ++++-
>  security/smack/smack_lsm.c   |  3 ++-
>  6 files changed, 26 insertions(+), 16 deletions(-)

...

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 8b17d83e5fde..c4ac704cbcc2 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1815,6 +1815,7 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
>   * @sk: the socket
>   * @doi_def: the CIPSO DOI to use
>   * @secattr: the specific security attributes of the socket
> + * @slock_held: true if caller holds the socket lock
>   *
>   * Description:
>   * Set the CIPSO option on the given socket using the DOI definition and
> @@ -1826,7 +1827,8 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
>   */
>  int cipso_v4_sock_setattr(struct sock *sk,
>  			  const struct cipso_v4_doi *doi_def,
> -			  const struct netlbl_lsm_secattr *secattr)
> +			  const struct netlbl_lsm_secattr *secattr,
> +			  bool slock_held)

This is a nitpicky bikeshedding remark, but "slock_held" sounds really
awkward to me, something like "sk_locked" sounds much better.

>  {
>  	int ret_val = -EPERM;
>  	unsigned char *buf = NULL;
> @@ -1876,18 +1878,15 @@ int cipso_v4_sock_setattr(struct sock *sk,
>  
>  	sk_inet = inet_sk(sk);
>  
> -	old = rcu_dereference_protected(sk_inet->inet_opt,
> -					lockdep_sock_is_held(sk));
> +	old = rcu_replace_pointer(sk_inet->inet_opt, opt, slock_held);
>  	if (inet_test_bit(IS_ICSK, sk)) {
>  		sk_conn = inet_csk(sk);
>  		if (old)
>  			sk_conn->icsk_ext_hdr_len -= old->opt.optlen;
> -		sk_conn->icsk_ext_hdr_len += opt->opt.optlen;
> +		sk_conn->icsk_ext_hdr_len += opt_len;
>  		sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
>  	}
> -	rcu_assign_pointer(sk_inet->inet_opt, opt);
> -	if (old)
> -		kfree_rcu(old, rcu);
> +	kfree_rcu(old, rcu);

Thanks for sticking with this and posting a v2.

These changes look okay to me, but considering the 'Fixes:' tag and the
RCU splat it is reasonable to expect that this is going to be backported
to the various stable trees.  With that in mind, I think we should try
to keep the immediate fix as simple as possible, saving the other
changes for a separate patch.  This means sticking with
rcu_dereference_protected() and omitting the opt_len optimization; both
can be done in a second patch without the 'Fixes:' marking.

Unless I missing something and those changes are somehow part of the
fix?

--
paul-moore.com

