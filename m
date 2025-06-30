Return-Path: <netdev+bounces-202628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF75FAEE650
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16D03A7F27
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8E92E717D;
	Mon, 30 Jun 2025 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dujheQIU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944628C5BF;
	Mon, 30 Jun 2025 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306361; cv=none; b=PMiYpbWf4/OMhEuuVdIT+I5AqsnMxfKIwfFj5y9O9uT70A+mnt6OtPcH8/x33A4IAO3bU5hUSOe7hZfjHfhOblHxBVopjzQjDO7TPoQOQkN/gfl0muGdV0SklFNRTl0qf37NDNPE7APw3vzWNjthifmYQMz1Xsao4Oog90OmCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306361; c=relaxed/simple;
	bh=E3MRjSUpTkCDblzO7R25ovzwgQNFm4lYSqmPFM5Y2y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5XHDGnccKJErhpnSOFU9PQ9ISxUuKQ7P6H8+yqfGHgCA7YZ1IWHi8f30dW4VW3QRhmJoU/BGQttqoIopXc86GEwkNqwz7U9yXpON2JzOCCoPnuqT130TniW7u/YOUZ/6fKIrXkqlSVAZYvKZl/z+8DqrXTouVlWlfMRAnJ2EOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dujheQIU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3139027b825so1538868a91.0;
        Mon, 30 Jun 2025 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751306358; x=1751911158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2J25bGVpgh8pIy8pe8vQjyoRwObkYDh4mB+hDfyBtpw=;
        b=dujheQIUx/tn43poXLEUgp2qStk7KHfiwczE8cP2aUe+2bOqXFV3fKfiQQw4VJIvSk
         hezwLO4S7ohc8AlXd7FZBYhNZdtZH41U3t1Piy68yUqbm+zHHJKgaOl5K+SY/TlQbnax
         VIZgEtmGX3tHMkBV6yJX2OlgVaY6lMjLYuvO51g7vSOAB4tCIz7pryRlk3QnERdlxEuR
         enCUOxPqRjMQjzq0h82QgJ2VhAuGEJmmQbaLh/WS7F9rm+5JmUK+OZ3eaGobP14qGLfq
         GXquzdB5aVtwe5ZGKHEWdOaiKP747Yqt9T7YH0f+Li4tyiOKhnvkZFGj5DrwMcNO9W6S
         q1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751306358; x=1751911158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J25bGVpgh8pIy8pe8vQjyoRwObkYDh4mB+hDfyBtpw=;
        b=iz2/nVRyu/tH/rVmm1y2GtTLnnDhqrVgIhBb/Rz6IkX46BTNWkimB1J8x32m/RlKlT
         YavOGMGqgUcAbzffItOQgjT5A0iMlpaqP4aS4Y4bKqhF9j5HdAwtE6fp7oNBLac1/7Vo
         qNp0yPDLN0md0QZop1kfsi3tx5xpyVD23cDZVzdFgfff1oa3SXyoxd7E05zpJPpLECc9
         F+/+oE/S5DwJbtNQlwE8TmP1eQpC0BGHx88cWHXcwnAm7ivRj2zEjquIIvErtVZDioTF
         CExxkGmv7yMVM/OmoRvX9mYYz9XeP6o6pkQn7spIUOQJ1xblahuYUx3q1QFLsQ6lBn4W
         9sXA==
X-Forwarded-Encrypted: i=1; AJvYcCUiZZARQXQLg8zGyD0NkXy207LUnxIHFn1udewimcgAb7QYkTUjgxkblbp1m1XS15zlfkpQytTO@vger.kernel.org, AJvYcCVFpRKfQbQ5vm5kOmAl0usQIEBSTvp0YRU7lV2dzbKn8BzLH5TDQ8LFbYqQl+DioDvqlxtePG2QbcSlcKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Y98QiOHFKxM1cPQfZh8LAE4azYhxAalKo8XXc8QU9z+NVCc8
	1hz77cviDfvz/6ZCBPBp0J6hPknWkelKey+mYPyBdZk+JqJGGttxG7Jz
X-Gm-Gg: ASbGncsdoq1MNWS51D9MBX8/iVnEcPKLJhz7T6qJ69tBkmhtzlzu/MB0Xn/ZaE69XdC
	hqq+8n/8bDKK6hfL2/0Qv2Cq4Ld0C3wyAefZ9wIyTgR9vJWIyNVQgf5h74VNHsFQE8cJ/mb9FRD
	dS5DPfLv2HDhhBajBW6jXgDa8UHD3N4MONQtpVMKSrP4ZyLieOVv+/sk77C3uE2LWR5uuxBdH+e
	jGT52lBOVTH4E8+SGrJeaft8ztN9d3U51/pKHBx7C0gv8rjI/E9++kxvx6KviKDcZETrJtPGSJF
	bTyIn/uc50sESJ51/yaAqteMs1enUZDvOtQcxS/bdcPlkZfCHfKc98OP2WcRBQ==
X-Google-Smtp-Source: AGHT+IHX83Rt64kyzEC0NV7DLNV4TZApXaBUaUDQJdOBRv6/Vil7f6N2l0bfOYrH1+W4YetdGwHEAQ==
X-Received: by 2002:a17:90b:1dc4:b0:311:e8cc:4264 with SMTP id 98e67ed59e1d1-318c922ef55mr26316071a91.12.1751306357856;
        Mon, 30 Jun 2025 10:59:17 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1be4sm86304915ad.24.2025.06.30.10.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:59:17 -0700 (PDT)
Date: Mon, 30 Jun 2025 13:59:15 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
Message-ID: <aGLQc5JGGpMdfbln@yury>
References: <20250619145501.351951-1-yury.norov@gmail.com>
 <aGLIUZXHyBTG4zjm@zx2c4.com>
 <aGLKcbR6QmrQ7HE8@yury>
 <aGLLepPzC0kp9Ou1@zx2c4.com>
 <aGLPOWUQeCxTPDix@yury>
 <CAHmME9rjm3k1hw4yMd8Fe9WHxC48ruqFOGJp68Hm6keuondzuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rjm3k1hw4yMd8Fe9WHxC48ruqFOGJp68Hm6keuondzuQ@mail.gmail.com>

On Mon, Jun 30, 2025 at 07:55:49PM +0200, Jason A. Donenfeld wrote:
> Hi Yury,
> 
> > > > > > diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> > > > > > index 7eb76724b3ed..56314f98b6ba 100644
> > > > > > --- a/drivers/net/wireguard/queueing.h
> > > > > > +++ b/drivers/net/wireguard/queueing.h
> > > > > > @@ -104,16 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
> > > > > >
> > > > > >  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
> > > > > >  {
> > > > > > -       unsigned int cpu = *stored_cpu, cpu_index, i;
> > > > > > +       unsigned int cpu = *stored_cpu;
> > > > > > +
> > > > > > +       if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
> > > > > > +               cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
> > > > >
> > > > > I was about to apply this but then it occurred to me: what happens if
> > > > > cpu_online_mask changes (shrinks) after num_online_cpus() is evaluated?
> > > > > cpumask_nth() will then return nr_cpu_ids?
> > > >
> > > > It will return >= nd_cpu_ids. The original version based a for-loop
> > > > does the same, so I decided that the caller is safe against it.
> > >
> > > Good point. I just checked... This goes into queue_work_on() which
> > > eventually hits:
> > >
> > >         /* pwq which will be used unless @work is executing elsewhere */
> > >         if (req_cpu == WORK_CPU_UNBOUND) {
> > >
> > > And it turns out WORK_CPU_UNBOUND is the same as nr_cpu_ids. So I guess
> > > that's a fine failure mode.
> >
> > Actually, cpumask_nth_cpu may return >= nr_cpu_ids because of
> > small_cpumask_nbits optimization. So it's safer to relax the
> > condition.
> >
> > Can you consider applying the following patch for that?
> >
> > Thanks,
> > Yury
> >
> >
> > From fbdce972342437fb12703cae0c3a4f8f9e218a1b Mon Sep 17 00:00:00 2001
> > From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > Date: Mon, 30 Jun 2025 13:47:49 -0400
> > Subject: [PATCH] workqueue: relax condition in __queue_work()
> >
> > Some cpumask search functions may return a number greater than
> > nr_cpu_ids when nothing is found. Adjust __queue_work() to it.
> >
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >  kernel/workqueue.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 9f9148075828..abacfe157fe6 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -2261,7 +2261,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
> >         rcu_read_lock();
> >  retry:
> >         /* pwq which will be used unless @work is executing elsewhere */
> > -       if (req_cpu == WORK_CPU_UNBOUND) {
> > +       if (req_cpu >= WORK_CPU_UNBOUND) {
> >                 if (wq->flags & WQ_UNBOUND)
> >                         cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> >                 else
> >
> 
> Seems reasonable to me... Maybe submit this to Tejun and CC me?

Sure, no problem.

