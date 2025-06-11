Return-Path: <netdev+bounces-196550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D23AD53CF
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FD11886838
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDAD241116;
	Wed, 11 Jun 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7aDMJ5n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC3255F5C
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641075; cv=none; b=pTli4BhP0ld4Emv04BqM067aO3RnbxFXNvvfdhexdev+R1CKgqWeBV9rRTjBz1a6AakAr/4pj2rRTjYWSVlkwPCwVxoNRVcJY/ppC8VErL4ZAg2QNtiBBIXgiTDiNuPw+dGkrtc5WZ+kEhpxFtashUXfYxRROlG5IitlyTlj3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641075; c=relaxed/simple;
	bh=n2sCuIGW6nUSRAdvVdyxbrqbUYkNbc6C4w7kUS6xJB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU9hHp9aBD7ZzrSIEpoXL2jkW+s9O2TOTDxcYihBw7LrrQoJ/p+OnflSQZxkwxJFq94GCDzXHEC++B4HfJ+KZBdVaaUJMwAN0A75xEcK8xehu4J+arkMVo3TosqUpOAFyVXVdRUcq4AH3Zi/ykHM6xlONxK0WNF8SezXT7C0B58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7aDMJ5n; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-afc857702d1so5337517a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749641073; x=1750245873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=01q9lmBrR4WkJt3VKlEY17LHa4ar7JHvakmVAsN7gv4=;
        b=W7aDMJ5njAYK2NOGkA1/c+OACsPzujGTs4kovrKaGU780fvmD6R6Q/DO6bklBWlkAU
         WofPFbo9+7bx8dbWQksIoCLcuEuCIid5ByhdOuUgm1Oo7U4oz/1LRUXSBLZHEBPSewYf
         9t723pvP46yUo1QlvQV2CEUUpt4VpCI9yOEH0tKe6NCCPiHMUK0yCs4aSUOWAYm9vIB5
         nI54MJF6lQqDEllUksunTDhSm0jnuPNP/s4TymzGhV4orvrWcJy3VRa7XYZSjBHlIxgl
         4qHulSEA+dldBvqx6QuPbUmjZQo9/XYGzJ3rpCUyAl0SriARI0LjiyFuCJzGRHgmvu0r
         OiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641073; x=1750245873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01q9lmBrR4WkJt3VKlEY17LHa4ar7JHvakmVAsN7gv4=;
        b=bCYesJQzNKfeDNhp2Zk6RoXhKvf5nQiYHSZPhWTC/5AK8f3nxiXq+zJ/Q1HLZpEhBa
         QaiU0oF/xZhu9UnvgUgwQn+BhJtZ9o3kWFZYu3wmGRkHDQippCsFrxvPJukNc8kU135B
         Jj+7w1h36p0p7+07QvupUJUN+xJWPDTqPmLqI2x1guLZdzgNQF+zVmk9cjgieVoQpd3+
         x8caO83m0lzkrYxGjvNkSRue2OQotzpVZXEUWeQScjmCOtVo0s+6YGy0nqwMLg+JByPT
         fuO3VW5jySULJzOebwnSf3n+qHlU7+Rhn0j9toVmi4nFDXk9p8sC3Cgr4QoRquF/vs6T
         O3cA==
X-Forwarded-Encrypted: i=1; AJvYcCU2LGmtL3YEwWpgFNvZ2jhuP92YKM2gyOuLl/JO0yaGcdVgtonMHGEuUBgZMVvevgD7/UB4mz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytU2J5Mk1wfMUPfJuC82JS2UZ8jiahkc/JObf+V4Fw03c3LGa0
	kqcfx5egbA6DQ8BzAyae2ZVv6WpZ4lu1f6Wa0nc56+qb6OPGR2D7rMZA
X-Gm-Gg: ASbGncvpZEKdRwbg6z++f7CPmU+Cc1opv4fF2rt8T96zWh7IQd2MkIRrJ5WBZ5k8ebN
	OIQWm6KyMq2EpqUbSO/dDqCOMNWZx1rODU9hrdW9VaFdJ9oO5mqlAbPYFbjFIC6feCWc2V7+9Ii
	RHxGkGx9vANIkw8iWzz+CRBc8Lux3fwWF+0yapFzYriFgn4DwrZCaAB37tcIGiJJqXAd//Jk7bu
	2hTxt2YaOBTRURtqY9rrJzvMNJkiipcOloBpTxsZmG/8t5EVUSXY8lNZUaLju84Al4aF+n7bg83
	T/MLCGYS1MGxH6ItFeJrRd6Ud2inv1lnGvn+QH3Wng9lBnJo9fxCxd0kdAvIW9hVju49VxbNwLh
	ld1IGy5FFPDaw
X-Google-Smtp-Source: AGHT+IHtSTT6gNjQJsf1d4CouuOm5NNb+EWVYo6p/YYkc7VkSHh8H4SO2Dlk2gJ4e0RZF1vzySsDSw==
X-Received: by 2002:a17:90b:3510:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-313af22d60bmr4237615a91.30.1749641072797;
        Wed, 11 Jun 2025 04:24:32 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b20078b1sm1190627a91.14.2025.06.11.04.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:24:32 -0700 (PDT)
Date: Wed, 11 Jun 2025 07:24:27 -0400
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, vinicius.gomes@intel.com,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, v4bel@theori.io,
	imv4bel@gmail.com
Subject: Re: [PATCH] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <aElna+n07/Jrfxlh@v4bel-B760M-AORUS-ELITE-AX>
References: <aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX>
 <CANn89iJiLKn8Nb8mnTHowBM3UumJQrwKHPam0JYGfo482DoE-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJiLKn8Nb8mnTHowBM3UumJQrwKHPam0JYGfo482DoE-w@mail.gmail.com>

On Wed, Jun 11, 2025 at 04:01:50AM -0700, Eric Dumazet wrote:
> On Wed, Jun 11, 2025 at 3:03 AM Hyunwoo Kim <imv4bel@gmail.com> wrote:
> >
> > Since taprio’s taprio_dev_notifier() isn’t protected by an
> > RCU read-side critical section, a race with advance_sched()
> > can lead to a use-after-free.
> >
> > Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.
> >
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> 
> Looks good to me, but we need a Fixes: tag and/or a CC: stable@ o make
> sure this patch reaches appropriate stable trees.

Understood. I will submit the v2 patch after adding the tags.

> 
> Also please CC the author of the  patch.

Does “CC” here refer to a patch tag, or to the email’s cc? And by 
“patch author” you mean the author of the patch 
fed87cc6718ad5f80aa739fee3c5979a8b09d3a6, right?

> 
> It seems bug came with
> 
> commit fed87cc6718ad5f80aa739fee3c5979a8b09d3a6
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> Date:   Tue Feb 7 15:54:38 2023 +0200
> 
>     net/sched: taprio: automatically calculate queueMaxSDU based on TC
> gate durations
> 
> 
> 
> 
> > ---
> >  net/sched/sch_taprio.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> > index 14021b812329..bd2b02d1dc63 100644
> > --- a/net/sched/sch_taprio.c
> > +++ b/net/sched/sch_taprio.c
> > @@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> >         if (event != NETDEV_UP && event != NETDEV_CHANGE)
> >                 return NOTIFY_DONE;
> >
> > +       rcu_read_lock();
> >         list_for_each_entry(q, &taprio_list, taprio_list) {
> >                 if (dev != qdisc_dev(q->root))
> >                         continue;
> > @@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
> >
> >                 stab = rtnl_dereference(q->root->stab);
> >
> > -               oper = rtnl_dereference(q->oper_sched);
> > +               oper = rcu_dereference(q->oper_sched);
> >                 if (oper)
> >                         taprio_update_queue_max_sdu(q, oper, stab);
> >
> > -               admin = rtnl_dereference(q->admin_sched);
> > +               admin = rcu_dereference(q->admin_sched);
> >                 if (admin)
> >                         taprio_update_queue_max_sdu(q, admin, stab);
> >
> >                 break;
> >         }
> > +       rcu_read_unlock();
> >
> >         return NOTIFY_DONE;
> >  }
> > --
> > 2.34.1
> >

