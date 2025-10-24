Return-Path: <netdev+bounces-232339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EFBC043B0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1B6E34B4CB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1599D2609C5;
	Fri, 24 Oct 2025 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3X8C14bl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A1333086
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 03:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275885; cv=none; b=DIjUcQE8mbQCcNpUPDtVcn2osq/RqmojSub8zUzNAlQzLoemJskH8fOWyHcyah3nvP2bco84QUcTLR+T3y6PugP1uE+z3761QNAwmaY1M5o0CWNWiLhwLS2asa/Ene3HCdFLziawWws1lnJm3Qz1l24vKI1QnPsOqTLRo0H0Q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275885; c=relaxed/simple;
	bh=Mm2VyaI4Igfss9i7TU8/z7aHTWUycbu8XrGKZEVvMDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SqW1mb9LU4P7TMk/BVLSxIbNEQzDCEBhOfjynedLKTmKn6wGl1SGtGRbaMDDOgmIyYEDbHUu2gZxPQI2TwV9TpHyFHj8lHF/2bHYIaBSnMPHYu7I7weFVouvd0vy5zZuFvxtly4C/SRQSygj579nRblRc3JOl4Y+4CjhZD5KGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3X8C14bl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2697410e7f9so36495155ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 20:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761275883; x=1761880683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=86TD3UzM8BdgXc7Yqd4HgeHYcCczwfuxg2J/6uVoESo=;
        b=3X8C14blxZrrQslcVrMTQFDI4WRmtE1Lu1graPsoUsBZ1ghExnhKSRrvwqTlhyfJnp
         H2TwGiQTruWEQIjJXhkoqQF0AvXmvgvd3rdnW/yYSFLBw6FSJ1tW1tuPtu7GUnNr+L90
         V7y5/14PnkifDQslPICtXoKwRnS+zbPhfDvocXR8dJFcHCbXmyEHciWzF67jD9/7Bzya
         9wvr9TODXQAkUtSM2IdP/NUoHFURgPRw+2tFuHCWKOZrtVtudswlQKRuGuSjXrcvveLM
         W+CMqaCHXsb1ETMcIqsnxwrGz1Sah1do30s13cY1ho1VeYQfgnJt/SatNzl+DiKNladl
         cO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275883; x=1761880683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86TD3UzM8BdgXc7Yqd4HgeHYcCczwfuxg2J/6uVoESo=;
        b=hMH3qcdZRl/+ZBLDNlQfptFXMArMQRfGt2wO/Do/tuPiDoI+ccmOg5wLdG1EJ5HjEm
         gTWc6k7rEX2gUMzrTcNXGnYoJlBj+779ewmzL92V1X6GEygNWx7XOk6Byk8KV16SjzSx
         KEbNhury/EN5EyQdpEA8iGWzFAaeoMjioDadCGRBmgG1LyvX3ykESAYtGP49V+EgWMqh
         18JmROiJ7R+taW3xEP9KQvtgFIk1lywpNyRPTGxdqWdYWUJ/xx6NtCnne1LnZ31SOUUN
         YJYoBIVktCpOVtGhslfyw8TNnPvfSlaOKsM2w7jc8obSG9pi3TkpFHzDfq+znTe3dkJF
         XndA==
X-Forwarded-Encrypted: i=1; AJvYcCUUS4t+ExaMcRHisG1Z/mw0c65IWSySZKT3pvP7cDBIDaC+WZA0n5XSr8YufiZpfV/5yPerEbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrnv0BfhioYGFt34eKRcXmiyzNnyBUqUXElIBbWZnDbLuNgjZu
	XJEBNzToHV3pK2HORpAcWU4mASXSUa5VUA+O08p5FfFOO6g8n/ngR1DMVAGhPyQK8igIpG33Zo4
	RPYDZlw==
X-Google-Smtp-Source: AGHT+IGbDXf3zXQD4ouIpOm4qwyHLbnbWkwJ/gIVE7mT+Z9sFC3feertEA2eWKr2O8i5iT2f1gFWGeayNYw=
X-Received: from pjbbk16.prod.google.com ([2002:a17:90b:810:b0:32d:a4d4:bb17])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0c:b0:267:af07:6526
 with SMTP id d9443c01a7336-290cb65c541mr349189525ad.55.1761275882800; Thu, 23
 Oct 2025 20:18:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:17:06 +0000
In-Reply-To: <20251024013153.2811796-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024013153.2811796-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251024031801.35583-1-kuniyu@google.com>
Subject: Re: [PATCH] net: rose: Prevent the use of freed digipeat
From: Kuniyuki Iwashima <kuniyu@google.com>
To: lizhi.xu@windriver.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jreuter@yaina.de, kuba@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Lizhi Xu <lizhi.xu@windriver.com>
Date: Fri, 24 Oct 2025 09:31:53 +0800
> There is no synchronization between the two timers, rose_t0timer_expiry
> and rose_timer_expiry.
> rose_timer_expiry() puts the neighbor when the rose state is ROSE_STATE_2.
> However, rose_t0timer_expiry() does initiate a restart request on the
> neighbor.
> When rose_t0timer_expiry() accesses the released neighbor member digipeat,
> a UAF is triggered.
> 
> To avoid this uaf, when rose_timer_expiry() puts the neighbor, the base
> member digipeat is set to NULL.
> 
> syzbot reported a slab-use-after-free Read in ax25_find_cb.
> BUG: KASAN: slab-use-after-free in ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
> Read of size 1 at addr ffff888059c704c0 by task syz.6.2733/17200
> 
> Call Trace:
>  ax25_find_cb+0x3b8/0x3f0 net/ax25/af_ax25.c:237
>  ax25_send_frame+0x157/0xb60 net/ax25/ax25_out.c:55
>  rose_send_frame+0xcc/0x2c0 net/rose/rose_link.c:106
>  rose_transmit_restart_request+0x1b8/0x240 net/rose/rose_link.c:198
>  rose_t0timer_expiry+0x1d/0x150 net/rose/rose_link.c:83
> 
> Freed by task 17183:
>  kfree+0x2b8/0x6d0 mm/slub.c:6826
>  rose_neigh_put include/net/rose.h:165 [inline]
>  rose_timer_expiry+0x537/0x630 net/rose/rose_timer.c:183
>  call_timer_fn+0x19a/0x620 kernel/time/timer.c:1747
> 
> Fixes: dcb34659028f ("net: rose: split remove and free operations in rose_remove_neigh()")
> Reported-by: syzbot+caa052a0958a9146870d@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>  include/net/rose.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/rose.h b/include/net/rose.h
> index 2b5491bbf39a..9b0dc81a9589 100644
> --- a/include/net/rose.h
> +++ b/include/net/rose.h
> @@ -163,6 +163,7 @@ static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
>  		if (rose_neigh->ax25)
>  			ax25_cb_put(rose_neigh->ax25);
>  		kfree(rose_neigh->digipeat);
> +		rose_neigh->digipeat = NULL;

How does this synchronise with the timer which is going to
touch rose_neigh being freed below ?


>  		kfree(rose_neigh);

Isn't the problem that we reach here without stopping all timers
or that a timer does not hold refcnt ?


Also, please post a patch in a separate thread so that patchwork
will not be confused.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#resending-after-review

---8<---
The new version of patches should be posted as a separate
thread, not as a reply to the previous posting.
---8<---

