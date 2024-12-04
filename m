Return-Path: <netdev+bounces-149066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5339E3F59
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50AABB3B020
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FABA20C47F;
	Wed,  4 Dec 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hw8zvWKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89520CCF4
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328595; cv=none; b=Ha/PNct3Zgu6gyjcgibds372IhhQrwKbr6SzocL8KrGpQ4jrz6Z6PRLVY/WMJD5HPmJ7pYeltv3tUhDnZo2Pm/Pj8nWPJrD3cK/Gsy2qqnVT0uHIHbzAnScXbfINRg0bgQWEIFxTzYAnpJWHUMaEPPhu33Bo5RsCkTIymIjO9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328595; c=relaxed/simple;
	bh=TybumzxOQvVZeNNhq0SAIu18I54Db9zFQFLU4aLPJjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fgg2npftZDzrwDEr5oK+9Cevx8FCvl16v7dFFw8wNf9DQi7LrJn3yp6xUcY6QxGSfGXHOlHiMJbjJfWXgxq+G/cTkSpTTqGxUxfhm5CCEb2QbfIBM3spJ797KrWq61kuOzjufhibexJqEVoZwpntv8AKOUz2nmswywMux/9GmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hw8zvWKK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0bde80b4bso7321641a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 08:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733328592; x=1733933392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIx0cZ+xuBv+spBUWfE6TZojEqVIyYPJbLU+xwyY+Yo=;
        b=Hw8zvWKKFO/shxoA9dz6YtDpfqgv7fcz6YIQX2P8YJc57exE3E8dmlYeMAZimqKY8V
         LPqW/fh31YKVF9YlTKov4lzq76/s/7fy4gpw3V6IpdWnWDr47XIelUQUVjUVea9xmv1f
         Nk6Cz3KsUxIzVfi+I5JD2GpQUHn0epcMRtHO2U5QaCEAP2j8R5ulyQ756KPkFOzs4/YQ
         l7oyVjBmIlq49wzgtYxu1yKkB6liYvJhG2vP+Ea7izMkysHfUlhdvCBE7vPVotlMUSzL
         +rDdA2O0Sy4SsF/ARY0bB+SO/CPzQuf74LvyQVcgBaaLMRNJvQyLPP7wyL4DQQPoz8GD
         vFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733328592; x=1733933392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIx0cZ+xuBv+spBUWfE6TZojEqVIyYPJbLU+xwyY+Yo=;
        b=Sc1GKY7kXrPm6ZpNPwIaPWSmIv50C9LFerxjW4A1FI4Xhmpy9r70QiHfwwUctLVOGw
         g4EVK2rm5G0deaL3TsfDWAHeHL5MMgI6rxokvdoRS8RfL8QzfWblLpAoK3ON5rSSRxYB
         4iFW5viWkN73KFwcOYdxl5lBGx+KM1ZbGiFUU8VBk6J9zo/86w7nb+1fujtkrQIPGUNu
         ZabtxmMeW74w+pR9DjYlYaWxNYV0DHTFTbwEbRtoyfyLBwTFaTQhwkkiyHDN0R9Zmsif
         vd1iZqifDmqgM8IzBAEQfi1s0GJrktk4FaaJRxuqh7Dd7g7HREepojvqhqAjB2sAFR8F
         YIvA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZGmaV3YoXnxPeLlaI13NGWBEWBVUJPfsvXoh4GJhMY3sIsi6z4LDfZ207isso/LhGYk/6As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOHoJPz6YPrlcrVM0eTNSBtLrguHBwrt7umjyg0VWN2P1pvLe
	9sx7dtHDaHR18qoJ3/7Y2Tfmli7YZM4XzY2ky+1eFNAfr84CCQwegGvnjqCmQtj89RUnCob+fvs
	2XoBCppPYwLYNrmqv2i2WkjQ7couyyeuW50yQ
X-Gm-Gg: ASbGncuED05sTwvbEv9pY7IGsfg660kqucKvnkwpTV6HHROaCENF9sqI/k2dkP6uKjP
	dnKrVSpvDq5uyRgNt+9VS0+DGooWgp9aQ
X-Google-Smtp-Source: AGHT+IFE9UMo4erbSN9M+VfMRKwtWRycw4VhfobpnM6PyoMDn/Q5NIyharHFeOKdW3Tx6WkeiH5SrGKYbEzKHPVPqH4=
X-Received: by 2002:a05:6402:4301:b0:5d0:cfad:f77 with SMTP id
 4fb4d7f45d1cf-5d10cb566d5mr7360431a12.12.1733328591447; Wed, 04 Dec 2024
 08:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJ-GfHU=sLWJiuqNcoH+AnBtj9dSxpXHjqbAS_VZ8fzAw@mail.gmail.com>
 <20241204160006.61496-1-kuniyu@amazon.com>
In-Reply-To: <20241204160006.61496-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 17:09:40 +0100
Message-ID: <CANn89iLzMCgkKLGjnyZ8YMd4ft81sfQyueC52TROuVx0ua0qYg@mail.gmail.com>
Subject: Re: [PATCH v2 net] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, ebiederm@xmission.com, jmaloy@redhat.com, 
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 5:00=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 4 Dec 2024 16:01:10 +0100
> > > diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> > > index 439f75539977..b7e25e7e9933 100644
> > > --- a/net/tipc/udp_media.c
> > > +++ b/net/tipc/udp_media.c
> > > @@ -814,10 +814,10 @@ static void cleanup_bearer(struct work_struct *=
work)
> > >                 kfree_rcu(rcast, rcu);
> > >         }
> > >
> > > -       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> > >         dst_cache_destroy(&ub->rcast.dst_cache);
> > >         udp_tunnel_sock_release(ub->ubsock);
> > >         synchronize_net();
> > > +       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> >
> > Note that ub->ubsock->sk is NULL at this point.
> >
> > I am testing the following fix, does it make sense to you ?
>
> Ah yes, net needs to be cached before sock_release().
>
> Thanks for catching this !
>


BTW the following construct in tipc_exit_net()

while (atomic_read(&tn->wq_count))
     cond_resched();

should really be replaced by a completion or something like that :/

