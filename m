Return-Path: <netdev+bounces-260832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIOCDPvAnmnsXAQAu9opvQ
	(envelope-from <netdev+bounces-260832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:29:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D779194FFA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C193D31588C8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC5387374;
	Wed, 25 Feb 2026 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNLmZjpT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD02C11EF
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011310; cv=none; b=CpwODWu0c1iqwLpQs7zSULL81Q8GSER7ex335XkwAM/xsUFJ2x7vGgjJeCqZZiw62PoTVHHbU45GFx/Rz12u0kIAlMKzkvEfPfCUGhUeIZrwcvs4eI+wr4v/km8m9UnlAnfT+1ThaEQ349rz+22HYAM3y3iY0PeGJjWzeh267Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011310; c=relaxed/simple;
	bh=uR+FHRvgMS0My+A8b/hXZJBomP/5mjTDYeDFN34P1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMOccq3IGV1k94ZEmtY1JzyVvrtu6lgkRu/wakVeLRUqKeHySaS/y8Wks12UnxwHuPPY4LlqfGarIrpu61osf8pi53oCDT4TMGIWOOszofoqqoijqB55wZA91rhwUR/GS8+GxqwTufLjZI+MfKzVG4gK+3Zng4C6E11hbzziSlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNLmZjpT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483703e4b08so5692625e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772011306; x=1772616106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36E00Mt78zkDakn20fS4QqpcK/9dmMkZpzDB/+zMCj0=;
        b=RNLmZjpTZ1nJkiGGYtKYUJT1zqnQYvOkjqcAhIaEmpn5vOMxZOhhqtrnhCoB16a8Xf
         Yhkn2cHmkiEJJB6bdcbEa/oUdpPS2s2jCXkRkZnyRAi0RQ/rPDrpHqc4kCdtmdLXgvoY
         UXubk99tNAZmCXwg8BDGpJ2Z2dsEbPRJ7lM1UI64gU7MahTl0X6SJb7qx4k34QSS42Ym
         I+CgzbCQ4aJrsVEkECoA++dOkg5wa97S7QIMAR/peGlsJveet/cBnggVBdyICMZgUus6
         lPBHT7Jg7/Tl0jkKi7cUSVTad0q5Us7avqg632iTthZaMknShPRA2P+EFxjTWB+BEDTi
         CRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011306; x=1772616106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36E00Mt78zkDakn20fS4QqpcK/9dmMkZpzDB/+zMCj0=;
        b=k9IUgu/4SPk8CyM/fXKXPF8XCYouYMlyZxh51AIzDKthTnMBVqLEQcQJywipAX6UXl
         AM7XefFN4gTRYyrXxtljLYC7u1E4jkde3n7XVXC5v4aeJeyWc3rGUGhuqrC7ehgWIhEn
         iePuDp72T+zYgLCV3eDWfMlRiphZYiKchLaLCju2MbBj4Q1qwnA07cc2Ecb/zcSwAsmO
         7EYRUAf+IlW6nbTUnveYjfIRPwEehkkLpKc3deMErL4qt40HCJ6umupnQPqxnAwGnrWx
         T1DbhrgcISOG5SwOyjKyreLaLJInKf4sbjf5DsQwVJ0BPIggu03/ApFMUrdFF0bXBOZn
         uKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxzgxVxBkqQZmAOB8KeUEZ/HgeQqkxyl5/txp1N2jqekW4AeR79+o4Id253AOlBHInRZnqHi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTgvIp4D0eUp50XwOYHBM8Gor0TBGyeK60+RZnl8xzWnYKwph
	1CpadJGGXKyDyc/7/6Gseozy/wy/LVhn/P44Cd+aYhnnSGASDQgmnOBo
X-Gm-Gg: ATEYQzxRAJ95hW1qGAParUjEIeLf2s7qKn+5R+83v6fOpI2n1NFNq4ESi1Vjss19yEq
	cVAERQiA/02W6nWq66l0fuPl5CQ3Wdpv0ZzCfWvXhQVWhMfxMNIClYY1pg9hc5Vl4nUmYLftoul
	kwa7sX0KjVPHevnY7eIeaoZ3QYDv1br7vp46pSLSmx6b5lajMex/WhQaqnnVOdI0Rn+BFFX2gMZ
	wda28iCRb1ODrjGFISt6aHU3N7KCE2XAcI1nYsvcOwh+3JuJ9CRi8WFk+YDBSMikp5KIn2oWM8A
	Pdq0Yv5kV+JB6bgr0JNuclXy57s3FR+fepJR5tuWGXELwRErr7gPU7qd1e4eCixjvieho5YcJCy
	N5/2/D31LsddaESRiXKBmAsZMPJ4EDCyCJbDmGiLb4bCmfI0XGc94POlGz3wb1bXDcNQNcJTTHd
	zTIb75+sGez/h1AWTJjB4v53wGX1JPIwxvCC/0MdfJOLXcQoKc0a+aR+2RMqaG852f
X-Received: by 2002:a05:600c:3652:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-483bd726fc9mr35770595e9.6.1772011306218;
        Wed, 25 Feb 2026 01:21:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c60bsm32005302f8f.27.2026.02.25.01.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:21:45 -0800 (PST)
Date: Wed, 25 Feb 2026 09:21:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: use cmpxchg() in lock_sock_nested()
Message-ID: <20260225092144.40f64b6f@pumpkin>
In-Reply-To: <20260225033216.601205-1-edumazet@google.com>
References: <20260225033216.601205-1-edumazet@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260832-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D779194FFA
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 03:32:16 +0000
Eric Dumazet <edumazet@google.com> wrote:

> Add a fast path in lock_sock_nested(), to avoid acquiring
> the socket spinlock only to set @owned to one:
> 
>         spin_lock_bh(&sk->sk_lock.slock);
>         if (unlikely(sock_owned_by_user_nocheck(sk)))
>                 __lock_sock(sk);
>         sk->sk_lock.owned = 1;
>         spin_unlock_bh(&sk->sk_lock.slock);

There has to be a better commit message that just quoting the old code.
The whole thing is quite subtle.
Not helped by the 'helper' sock_owned_by_user_nocheck() obfuscating things
and that __lock_sock() is 'wait for socket to be unlocked' and doesn't
actually lock it at all.

	David

> 
> On x86_64 compiler generates something quite efficient:
> 
> ffffffff81e96100 <lock_sock_nested>:
> ffffffff81e96100:       f3 0f 1e fa             endbr64
> ffffffff81e96104:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> ffffffff81e96109:       b9 01 00 00 00          mov    $0x1,%ecx
> ffffffff81e9610e:       31 c0                   xor    %eax,%eax
> ffffffff81e96110:       f0 48 0f b1 8f 48 01    lock cmpxchg %rcx,0x148(%rdi)
> ffffffff81e96117:       00 00
> ffffffff81e96119:       48 85 c0                test   %rax,%rax
> ffffffff81e9611c:       74 33                   je     ffffffff81e96151 <lock_sock_nested+0x51>
> ...// slow path
> ffffffff81e96151:       2e e9 19 c4 33 00       cs jmp ffffffff821d2570 <__pi___x86_return_thunk>
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/sock.h |  9 +++++++--
>  net/core/sock.c    | 10 ++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 55b61e4b0d8318887d527e919fc1103d78ac6d14..84c21fb38a28406e387dc33e0fb5decd18893950 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -81,8 +81,13 @@
>   * mini-semaphore synchronizes multiple users amongst themselves.
>   */
>  typedef struct {
> -	spinlock_t		slock;
> -	int			owned;
> +	union {
> +		struct slock_owned {
> +			int		owned;
> +			spinlock_t	slock;
> +		};
> +		long	combined;
> +	};
>  	wait_queue_head_t	wq;
>  	/*
>  	 * We express the mutex-alike socket_lock semantics
> diff --git a/net/core/sock.c b/net/core/sock.c
> index cfb2a6209946089669882cdbd5d1b36c53838989..2a03d1432111f2dcea9d700f80efb7b0bb4a47d8 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3780,6 +3780,16 @@ void noinline lock_sock_nested(struct sock *sk, int subclass)
>  	mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
>  
>  	might_sleep();
> +#ifdef CONFIG_64BIT
> +	if (sizeof(struct slock_owned) == sizeof(long)) {
> +		socket_lock_t tmp;
> +
> +		tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);
> +		tmp.owned = 1;
> +		if (likely(!cmpxchg(&sk->sk_lock.combined, 0, tmp.combined)))
> +			return;
> +	}
> +#endif
>  	spin_lock_bh(&sk->sk_lock.slock);
>  	if (unlikely(sock_owned_by_user_nocheck(sk)))
>  		__lock_sock(sk);


