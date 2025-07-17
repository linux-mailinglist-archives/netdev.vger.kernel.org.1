Return-Path: <netdev+bounces-208011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893ABB0956D
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 22:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C5F17E55F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0121E2236FF;
	Thu, 17 Jul 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="mTyx0o/H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D7222575
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782780; cv=none; b=Ty1H3q5hZG2QbF9mEqzNfQrhO1T7X8tgciqJXXPM+DqGZOmASVcS7HwcQ8fWVnaAoCq0e6DgS1DNTPawE1uQzHN97YdeArUjAqPTOe9XjIVXazbJvhOhKef3obbPH6MDLLhQt9b6a8CSdkP7GqzVGakupD3sigbd/UhEnysSBiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782780; c=relaxed/simple;
	bh=K2kLDhPUjaZk6eC1kI7xoKHaUGHFosW0IMcOLFOJywo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEbmvm79sQ+VqKKeNn1PTH6NDtCxtHjoGChHiDEYM0y8eZoqb8tOTA8ps1TUjXlZSasL6Xk3zaAZZ2G8NgE+yrGMzxv37yZau5r2mKb/ur5Q8P1wOdAVcjsgm6PkMhRDiiF87RSfTFn8Yo0kuIs9F/obIBwzFLtWssa4izcKNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=mTyx0o/H; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7426c44e014so1488646b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752782779; x=1753387579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uIx006nGQVsF/c8eHW0jZT9bqzEKGnOOyNP5sB/pCNs=;
        b=mTyx0o/HKlG3M9flKcitpVNHtCwexDOPb+EH7UyP9h8jafPYkv0rv2McAbesuCOyxg
         BYY2rh/zKyo7qFI2FHQl7T8sGywa90IJBtLhGRU9zGAd3DkpzfhdeI7N32Vy+caDIGdq
         xpvdRsFIb0k5mwiScaX729ikrU/lLq0WLkZN00PeqLqvxfSsEuwhFqi//9qK46GMFyyq
         37Gt9wt8zY8YZVGuBlb7kTjUR/0VT2Yn6zwj7E32kPSBuIah7Zt17ZowzvDDCo30v7Yd
         1CWVKMN60vBYrmFTOWvNhP/hYuvNKoQBfgM+Nt5PSb6kpRlHycCTyNR0/I0+g5mQmTwD
         pnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752782779; x=1753387579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIx006nGQVsF/c8eHW0jZT9bqzEKGnOOyNP5sB/pCNs=;
        b=VlINJIE2H//xR/UWkyCBNLeCSiLvIGM9KYNmOXXGU22iXvFiWUcPmS7Nomt7+B7yZU
         ZOEz7VdI9XpSZSHgW6BDoIJo8D9v9dPzZEHS6c5692g96tV/W9KT4184zcI30/FTgI97
         CSlcw1H8bKF9jAcS9fpM5uSaWrk69iVT44Pyx/xBJCPeHPgcFhNc/THU+gOUQEN9J5q+
         hpXQEEbmkYrt6ODGkCVvRx3OiWf73nOeaofmSFsUhrkUX2gjPZtyMWfa7IPVhSASeUrP
         7ypDufm9KlitIpvOJHu/kDtcQlEVnFnXzAASbS2pjqc5TqWM+HqkpMNZrcRfBhTe7tKg
         +3/w==
X-Gm-Message-State: AOJu0Yy6ugCj2nksyjygZG9DZwYQwmgsaYjwRJe1XvMjtVdPkkkJPBEC
	wXQvqPX0tRu8OOc8cLwCCTNZa/abP5H8xRJdZEdn9MOZcm8yw3y0ugu+GV7JW+Ta6sh3E7bLbqE
	ahgQ=
X-Gm-Gg: ASbGnctnfr2LDS3bRpSwiCKEkzhUmZcAkUo4NPLuhedZBGPSHg2XLSPvE8l4xQ9EoLU
	/owNs7j+8g6upICEebgaqEvdeXOa4E1EwciRT22l2XH7PC+aBOU63zmojZWUky52SIhzBnrBWLO
	Vq2Eg5KORZtetwiT9vljvBYY5YI11GB0CP8wAEEn5UOWMOUii35mAHC5UCe+JW6ERHwq1fP3p/P
	1QTlYlpXvEkwEHEF+/eVmwIUXDk6T+cqeThMDg0LSUHTiVeZK3QpYBd9/X03R9BewjIlNxjfT2K
	wEJZMWco/u0l/NPE1ZVIGrYZw1sK3tF6NUUtBry2NAGVcrTelppwAneG027ZqPWu/yu03M5vp3S
	7k7kmfEZCnJKZpOADqzsQY15sj8eojA5M
X-Google-Smtp-Source: AGHT+IEJN/3KWaqbThdFa0brSr3FdkdbT10ZJvQfRQ5AxyQTz1vxjRuyoduEZS23i1phvBHHDKbCpg==
X-Received: by 2002:a05:6a00:1248:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-756ea6c7d8amr12363412b3a.23.1752782778399;
        Thu, 17 Jul 2025 13:06:18 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f9762esm16998351b3a.148.2025.07.17.13.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:06:17 -0700 (PDT)
Date: Thu, 17 Jul 2025 13:06:15 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: netdev@vger.kernel.org
Subject: Re: [bug report] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHlXt3HBd--0JGqZ@xps>
References: <4a04e0cc-a64b-44e7-9213-2880ed641d77@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a04e0cc-a64b-44e7-9213-2880ed641d77@sabinyo.mountain>

On Thu, Jul 17, 2025 at 11:51:43AM -0500, Dan Carpenter wrote:
> Hello Xiang Mei,
> 
> Commit 5e28d5a3f774 ("net/sched: sch_qfq: Fix race condition on
> qfq_aggregate") from Jul 10, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	net/sched/sch_generic.c:1107 qdisc_put()
> 	warn: sleeping in atomic context
> 
>    547  static int qfq_delete_class(struct Qdisc *sch, unsigned long arg,
>    548                              struct netlink_ext_ack *extack)
>    549  {
>    550          struct qfq_sched *q = qdisc_priv(sch);
>    551          struct qfq_class *cl = (struct qfq_class *)arg;
>    552  
>    553          if (qdisc_class_in_use(&cl->common)) {
>    554                  NL_SET_ERR_MSG_MOD(extack, "QFQ class in use");
>    555                  return -EBUSY;
>    556          }
>    557  
>    558          sch_tree_lock(sch);
>    559  
>    560          qdisc_purge_queue(cl->qdisc);
>    561          qdisc_class_hash_remove(&q->clhash, &cl->common);
>    562          qfq_destroy_class(sch, cl);
>                 ^^^^^^^^^^^^^^^^^
> We used to unlock first and then did the destroy but the patch moved
> this qfq_destroy_class() under the sch_tree_unlock() to solve a race
> condition.  Unfortunately, it introduces a sleeping in atomic context.
> 
>    563  
>    564          sch_tree_unlock(sch);
>    565  
>    566          return 0;
>    567  }
> 
> The call tree is:
> 
> qfq_delete_class() <- disables preempt
> -> qfq_destroy_class()
>    -> qdisc_put() <- sleeps
> 
> net/sched/sch_generic.c
>     1098 void qdisc_put(struct Qdisc *qdisc)
>     1099 {
>     1100         if (!qdisc)
>     1101                 return;
>     1102 
>     1103         if (qdisc->flags & TCQ_F_BUILTIN ||
>     1104             !refcount_dec_and_test(&qdisc->refcnt))
>     1105                 return;
>     1106 
> --> 1107         __qdisc_destroy(qdisc);
> 
> It's the lockdep_unregister_key() call which sleeps.
> 
>     1108 }
> 
> regards,
> dan carpenter
Thanks Dan for the explanations. 

What do you think about this solution: We split qfq_destory_class to two 
parts: qfq_rm_from_agg(q, cl) and the left calls. Since the race condition
is about agg, we can keep the left calls out of the lock but moving 
qfq_rm_from_agg into the lock.

This could avoid calling __qdisc_destroy in the lock. Please let me know 
if it works, I can help to deliever a new version of patch.

Best,
Xiang

