Return-Path: <netdev+bounces-272047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OEMO88xxWkn8AQAu9opvQ
	(envelope-from <netdev+bounces-272047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:17:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3B335CF1
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FF2C3022301
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D202C08DC;
	Thu, 26 Mar 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9YD+uHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47072C3256
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530814; cv=none; b=LfnTlF+swCcHYiQYy/jQ2ZcsQOgOPKldT0Yr/mdwujrQR6zzZaVr578V/RTAMmDdbxGpZ8Vf2YjBe6NlokF/DwG4M9zXMv3GTlPwHeUEwvb0L+RnpMgJMxdGxgrb2dfs6i+wmN04MfN1uZRqhF5LFjafJR+iMBs/q4zyhEbzmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530814; c=relaxed/simple;
	bh=V6HW9UYjenGZVQAgFZWZlIWxFV9vu/u3wlaBdXIFaq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpjIRxpNRU66UKqTnS16bW/VEj4Jnb5f5sPeViPojoTfOF4pHAp7vPbX3rb3SIxFmum//9zqmT/X/qoAWgmtRJv007n4DwIEf5VxndVpO663qB9NgMd2VQrhktbneZ09KiMj0+F9hk7KgLp7c6aBKQ9xucsC5wWbzCtXcg1Huac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9YD+uHd; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c742d4df00cso869237a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774530812; x=1775135612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5TVksCgcrzrqKn5iMwLFlGEX0qCajZntp0ANB8dIpg=;
        b=r9YD+uHdM1KpSLJTNPOeB2pS2DpcGHhSOhBvUXHt8ZMx5zVKOE+d2AsO659pnIbTDs
         wocggaXa9t48GMSZlunvvJuqGnLTA/p1s5QIn/3yH9qGD9gGkz+dfdMdTVlRzHOcBvoe
         Heze9Ax/b7uKPzene5z8ls/v2ZU9mXhyhjjebhRA2FmfAi4TEmBNduQNBvmRGSoQcUoF
         7rTKiR9u5wajXwXeuP8eHhDjhG5sdi7L4KetrdLNwoTrRbvW17r+xIdpbcuA3LfhkJAK
         Feauo6tqZk83jYoJ5ZyTtiBZAfbgof3jpehnMQuKw8eQkYZypNhc2hjmMZMRP+B9kba7
         diCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774530812; x=1775135612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5TVksCgcrzrqKn5iMwLFlGEX0qCajZntp0ANB8dIpg=;
        b=ApdC+ugvGfJrYymEI8QguwlHKq/sc1Vi6rkGEeTv14N5+SNZ6mWiV7EElLO1oQ8eGs
         TpKlORHxupsVQgVCk9fscb57gXehAIVrypzKzEVQUygKfORBfR79r63JH34gOw3l9NHv
         CZWMv+tLVlW0HYtMsve7nYC1RMy6DpM/i7ycQjiJJUjnK7qoLYenxC81quG0zQjMZWzJ
         HhSGE5NmIOKWJKfBGq1vdvRTblZsS57o80toIc7U0WAFHEGFWKj1go0cgHCFR001j3wQ
         4KwW6CO36lJlmzH26oc1WR5XCZfBEckVY6R1MxeIPvT0W6jogcvSJA9/KGC5gxX+O8BF
         HSTA==
X-Forwarded-Encrypted: i=1; AJvYcCXRhEMBqCGYYbati7igaCV+gM2nfB324NSvRFBbR/mfybA9y/NNY/btVMMD5EWn4irX9uQavgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHm8MFQOqdMq+ERYeuw2wmljF1UXflGQFptWb0wh/GsFYv63DJ
	6T9Gw1JLmfTIdfmTtg3iH+PeBz5T08bACfZMdWYWUL7rUZJITaVSJKGU
X-Gm-Gg: ATEYQzzcIuWkSHP+d1ZH6M+VTQBWQRjdHiXnD53dKcNGqSAacWgPneqXLFRvgfGd27v
	6xKCa38rOytIHwkuSPG9/At6YI61LmLZ0YXiKWQ1I6Qt4MwOzfoYJmdtjLSYY+A+lbeuk5l54xn
	qjl4R3KgD6p8ypoRi6ha07vMf7AJ7h4amxECIL1NNblxFBA4u7LdW12jfrE6n9OLPs1ygUfBRZ2
	7obzqqbVH2mLChybQfkbth3wxm41oAd7Xb7p7c22hN8FBMvnU7n6fHT+5jIwwa8/T5oAFmoqoUf
	1jb9b6edKBLR7S4D4jzNw5hcaVL8ofQ1k+GXSzBI2M4phUf2V1TT94LHTZVcvnxOrI4RSmANhLd
	MIxETmk3p/WIdip+KwTRB1aCOzZE+dLkVLXlLfQhJlDt4gMplA+mN6KoMlZBWTzfK8SZGs1q7nO
	rRlPfYGO+zHWWEgwFjWncVy/2LtHQ=
X-Received: by 2002:a17:902:e54f:b0:2b0:4f16:22f7 with SMTP id d9443c01a7336-2b0c48e89dbmr16205665ad.16.1774530812133;
        Thu, 26 Mar 2026 06:13:32 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc68914bsm32581495ad.0.2026.03.26.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 06:13:31 -0700 (PDT)
Date: Thu, 26 Mar 2026 13:13:23 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org,
	Fei Liu <feliu@redhat.com>
Subject: Re: [PATCH net] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Message-ID: <acUw8zYwbbpgo8KJ@fedora>
References: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
 <CANn89i+SX1Kp7D2JzzEtg-zRkJzi4bdjzc2snvM7npJQzNp0+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+SX1Kp7D2JzzEtg-zRkJzi4bdjzc2snvM7npJQzNp0+Q@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272047-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DE3B335CF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 05:05:57AM -0700, Eric Dumazet wrote:
> > diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > index dd26657b6a4a..64de761f40d5 100644
> > --- a/net/ipv6/ip6_fib.c
> > +++ b/net/ipv6/ip6_fib.c
> > @@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
> >         if (!f6i)
> >                 return;
> >
> > -       if (f6i->fib6_metrics == &dst_default_metrics) {
> > +       if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
> > +               struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
> >                 struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
> >
> >                 if (!p)
> >                         return;
> >
> >                 refcount_set(&p->refcnt, 1);
> > -               f6i->fib6_metrics = p;
> > +               if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
> > +                       kfree(p);
> >         }
> >
> 
> The following line should happen before the cmpxchg(),
>  ->metrics[X] accesses also need READ_ONCE()/WRITE_ONCE() annotations.

Hi Eric,

Jiayuan also suggested to using READ_ONCE()/WRITE_ONCE() for metrics[X]
accesses. But I don't get why this line should happen before the cmpxchg(),
Would you please help explain?

> 
> 
> >         f6i->fib6_metrics->metrics[metric - 1] = val;
> >

Thanks
Hangbin

