Return-Path: <netdev+bounces-234031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF066C1BBCD
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D4758183B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2F32E427B;
	Wed, 29 Oct 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUJrapaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703C2E542C
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749194; cv=none; b=G2Dhx9JwhfbMzH0cDC/53OJUMB9pko5pT+crGqVgf6ljU8FTT3LnrG0Oc+h2bxzCxu39n94Wqx6eJkADMHqMPwYQITM8Es+FpxqEB4f19nrPwYfQJBIDhY1Fj5nMdPaJ1fz1Zy/KXqNYGHNu7tCuNJzT/y8nkap7chpJtuyVQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749194; c=relaxed/simple;
	bh=6rF4GLL9pS4cU9IPxVuHd5pEMQDEExDlCv0e5ynD+ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpLv2Egc+uCeTnTho1rM80kl28MfUZeQYE11sk3oYBPVV9yuKiS0euJC+FILrGuSVasaNU2IcYKWrWy9ck3Yq9rCk8bqaNTshYfiQpLaHbQf//l/2lOV2uhpj1+Mmo9rk6UtGyxAOBmicmrm6n20VNZ1Mna8wCRZbn4NXoSh/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUJrapaJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78617e96ae1so24990617b3.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761749192; x=1762353992; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0KB2TDOPveGK6lFN3Xm0rmM8VbnxKm93ZQZfT2ThEx4=;
        b=gUJrapaJjSKV41XojQJDaby03HkTj1wsO+KNecxIzhAGfZ6k5iKWELdGVDS2dihYxS
         vTCNgDMW6Poov491Q+59r6xEIsTG2HUGGU9cwrYm4lmMQaXyh4r1r9yzWyqGb9tlbyCF
         8Yp+B9ldkyCzh89xD+D/MmSu3wyuyqIX/SFhWieQrYsspur4NIlaFHE2cTrf3JDuDrZw
         M3SLOU/5uvpzUrJDPxtvnY3NHDieNZLXbr6XdsaVjWbfKyRGuQOTvAnWKh0aDIUBySvx
         V6fhTw6kcyEQMqUaTU859Q+mEtYhb723rqVoDnS8BTRMAknN0+oqmNsRI4E4LpEJJjh1
         6iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749192; x=1762353992;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KB2TDOPveGK6lFN3Xm0rmM8VbnxKm93ZQZfT2ThEx4=;
        b=oTcgU0lxs8G9zeemmzIMCsEBwDMOhnG+aqISnka8Ke4OrBQe7oyPHNmGfVwJF9WGwI
         sVB3H+EQazo9LFsXXA+dwibXyI4B+hB2ll2RNUVcv/TfLPqWK8zs62S7xUh88FvYN4QF
         IlYMfLWXIPx6nAkjUTVk3pK3Q9S+Soz6zfuLhfgGIvhJnXBqTvTCvWNiOP5/ZJ0SIcOt
         RiTV7GKqCRjZ1BE9gTYFJzxssytiCyQAGZLyPZpwzbQGO+jAfOD/Ue9Mz92LIbCfqcOW
         BoO2Fn6zJDUwFMedZd2eHui6y6zcaypQPBz5Bc4YbL8LPiMlZGGvFmuo0rQcMYgWg9z6
         3ZXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQXNi3n+BWvQ4DR5mdYJzjDpopRY4sn6DnFN6i1ymSsDQafKudTMGWml/vXWdt9ywyS/bvvsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHObuDSCmMjRHs/Z8ulg9b//Kte1mL0nwZOQPRVKuWuNlnZuU
	MjkKq7I6A1/5p8EvTnWzva+lCe2vgjgM+Xfxgznlbe9NnwaMhKs3buTK
X-Gm-Gg: ASbGnctfLZLimAMN/tFz1d5p+z1JiML4J5WzXYyJgv93pi9e/NGOQ0iU+mlwc7Z8cYd
	HACrVVZXwAed+ht8avPS5ZB8N0kAcBiM0E807Dz3fzfmyPjWwA97IFYP7xXT9UpnZDIITai5p5T
	ddTM5apnoOzPIlwTP4v/Cm8Y3tww7ZjkXuIMoxhski36CRmmVjnzKexWJSI0mTvKCuyYmsfounO
	mQYd6GBlPhqK7JZiJnkbpWxpmZZHHGGHxYkWozk40odJ+mDTF+YaFdCPai3Q89v/IWglGKUVXwK
	7PC7v6DVytquxME6COb0nJyr654V1+ZhmG/DcbC02DjqD7PEWZYoox4fw8DF90+5TKzfk5YdL/y
	4YolRgm/3hcIMz4uaKFSwz67FS62tm4V0WI32pvBaByyc8p7oZWtz+2NLqgWTLEEYPGNGWrQRel
	o1jYfcyNPmR+gR+MdQvW56mWd5e1aW1J3j1Mwx
X-Google-Smtp-Source: AGHT+IEr0sIdLf9PssBrGinYWfeFT8qXFc+cSs4JUokXl/UIi8NX/JszZEzp0LPPd/6TpUd+ipCSMg==
X-Received: by 2002:a05:690c:dc9:b0:785:f54a:99e6 with SMTP id 00721157ae682-78628f7a7dbmr32458397b3.32.1761749191693;
        Wed, 29 Oct 2025 07:46:31 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7862e389945sm4977587b3.57.2025.10.29.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:46:31 -0700 (PDT)
Date: Wed, 29 Oct 2025 07:46:29 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/4] net: devmem: use niov array for token
 management
Message-ID: <aQIoxVO3oICd8U8Q@devvm11784.nha0.facebook.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-3-47cb85f5259e@meta.com>
 <CAHS8izOKWxw=T8zk1jQL6sB8bTSK0HvNxnX=XXYLCAFtuiAwRw@mail.gmail.com>
 <aQEsYs5yJC7eXgKS@devvm11784.nha0.facebook.com>
 <CAHS8izOnir-YHPH+R0cQzu1i0HD2Z0csW6qUT8FFXh1PkmHabQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOnir-YHPH+R0cQzu1i0HD2Z0csW6qUT8FFXh1PkmHabQ@mail.gmail.com>

On Tue, Oct 28, 2025 at 07:04:15PM -0700, Mina Almasry wrote:
> On Tue, Oct 28, 2025 at 1:49 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> ...
> > > > @@ -307,6 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > > >                 goto err_free_chunks;
> > > >
> > > >         list_add(&binding->list, &priv->bindings);
> > > > +       binding->autorelease = true;
> > > >
> > >
> > > So autorelease is indeed a property of the binding. Not sure why a
> > > copy exists in sk_devmem_info. Perf optimization to reduce pointer
> > > chasing?
> > >
> >
> > Just stale code from prior design... Originally, I was going to try to
> > allow the autorelease == true case to be free of the
> > one-binding-per-socket restriction, in which case sk_devmem_info.binding
> > would be NULL (or otherwise meaningless). sk_devmem_info.autorelease
> > allowed sock_devmem_dontneed to choose the right path even when
> > sk_devmem_info.binding == NULL.
> >
> > ...but then I realized we still needed some restriction to avoid sockets
> > from steering into different dmabufs with different autorelease configs,
> > so kept the one-binding restriction for both modes. I abandoned the
> > effort, but forgot to revert this change.
> >
> > Now I'm realizing that we could relax the restriction more though... We
> > could allow sockets to steer into other bindings if they all have the
> > same autorelease value? Then we could still use
> > sk_devmem_info.binding->autorelease in the sock_devmem_dontneed path and
> > relax the restriction to "steering must only be to bindings of the same
> > autorelease mode"?
> >
> 
> Hmpf. I indeed forgot to think thoroughly about the case where, for
> some god-forsaken reason, we have bindings on the system with
> different auto-release values.
> 
> But now that I think more, I don't fully grasp why that would be a
> problem. I think we can make it all work by making autorelease a
> property of the socket, not the binding:
> 
> So if sk->devmem_info.autorelease is on, in recevmsg we store the
> token in the xarray and dontneed frees from the xarray (both can check
> skb->devmem_info.autorelease).
> 
> If sk->devmem_info.autorelease is off, then in recvmsg we grab the
> binding from sk->devmem_info.binding, and we do a uref inc and netmem
> get ref, then in dontneed dec uref and napi_pp_put_page if necessary.
> 
> The side effect of that is that for the same binding, we may
> simultaneously have refs in the sk->xarray and in the binding->uref,
> because the data landing on the binding sometimes belonged to a socket
> with sk->devmem_info.autorelease on or off, but I don't immediately
> see why that would be a problem. The xarray refs would be removed on
> socket close, the urefs would be freed on unbind.
> 
> Doesn't it all work? Or am I insane?
> 

No not insane. I think that works really well and will simplify things a
lot. Let's give that a whirl for the next rev.

[...]

> > > >
> > > > +static noinline_for_stack int
> > > > +sock_devmem_dontneed_manual_release(struct sock *sk, struct dmabuf_token *tokens,
> > > > +                                   unsigned int num_tokens)
> > > > +{
> > > > +       unsigned int netmem_num = 0;
> > > > +       int ret = 0, num_frags = 0;
> > > > +       netmem_ref netmems[16];
> > > > +       struct net_iov *niov;
> > > > +       unsigned int i, j, k;
> > > > +
> > > > +       for (i = 0; i < num_tokens; i++) {
> > > > +               for (j = 0; j < tokens[i].token_count; j++) {
> > > > +                       struct net_iov *niov;
> > > > +                       unsigned int token;
> > > > +                       netmem_ref netmem;
> > > > +
> > > > +                       token = tokens[i].token_start + j;
> > > > +                       if (token >= sk->sk_devmem_info.binding->dmabuf->size / PAGE_SIZE)
> > > > +                               break;
> > > > +
> > >
> > > This requires some thought. The correct thing to do here is EINVAL
> > > without modifying the urefs at all I think. You may need an
> > > input-verification loop. Breaking and returning success here is not
> > > great, I think.
> > >
> >
> > Should this also be changed for the other path as well? Right now if
> > __xa_erase returns NULL (e.g., user passed in a bad token), then we hit
> > "continue" and process the next token... eventually just returning the
> > number of tokens that were successfully processed and omitting the wrong
> > ones.
> >
> 
> Ugh. I did not notice that :(
> 
> I guess the existing dontneed doesn't handle that well anyway. Lets
> not fix too much in this series. It's fine to carry that behavior in
> the new implementation and if anything improve this in a separate
> patch (for me at least). It'd be a bit weird if the userspace is
> sending us bad tokens anyway, in theory.
> 

Duly noted. I'll leave that for future work.

[...]

> > > >  static noinline_for_stack int
> > > >  sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
> > > >                                  unsigned int num_tokens)
> > > > @@ -1089,32 +1142,32 @@ sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
> > > >         int ret = 0, num_frags = 0;
> > > >         netmem_ref netmems[16];
> > > >
> > > > -       xa_lock_bh(&sk->sk_user_frags);
> > > > +       xa_lock_bh(&sk->sk_devmem_info.frags);
> > > >         for (i = 0; i < num_tokens; i++) {
> > > >                 for (j = 0; j < tokens[i].token_count; j++) {
> > > >                         if (++num_frags > MAX_DONTNEED_FRAGS)
> > > >                                 goto frag_limit_reached;
> > > >
> > > >                         netmem_ref netmem = (__force netmem_ref)__xa_erase(
> > > > -                               &sk->sk_user_frags, tokens[i].token_start + j);
> > > > +                               &sk->sk_devmem_info.frags, tokens[i].token_start + j);
> > > >
> > > >                         if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> > > >                                 continue;
> > > >
> > > >                         netmems[netmem_num++] = netmem;
> > > >                         if (netmem_num == ARRAY_SIZE(netmems)) {
> > > > -                               xa_unlock_bh(&sk->sk_user_frags);
> > > > +                               xa_unlock_bh(&sk->sk_devmem_info.frags);
> > > >                                 for (k = 0; k < netmem_num; k++)
> > > >                                         WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> > > >                                 netmem_num = 0;
> > > > -                               xa_lock_bh(&sk->sk_user_frags);
> > > > +                               xa_lock_bh(&sk->sk_devmem_info.frags);
> > > >                         }
> > > >                         ret++;
> > > >                 }
> > > >         }
> > > >
> > > >  frag_limit_reached:
> > > > -       xa_unlock_bh(&sk->sk_user_frags);
> > > > +       xa_unlock_bh(&sk->sk_devmem_info.frags);
> > > >         for (k = 0; k < netmem_num; k++)
> > > >                 WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> > > >
> > > > @@ -1135,6 +1188,12 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> > > >             optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> > > >                 return -EINVAL;
> > > >
> > > > +       /* recvmsg() has never returned a token for this socket, which needs to
> > > > +        * happen before we know if the dmabuf has autorelease set or not.
> > > > +        */
> > > > +       if (!sk->sk_devmem_info.binding)
> > > > +               return -EINVAL;
> > > > +
> > >
> > > Hmm. At first glance I don't think enforcing this condition if
> > > binding->autorelease is necessary, no?
> > >
> > > If autorelease is on, then we track the tokens the old way, and we
> > > don't need a binding, no? If it's off, then we need an associated
> > > binding, to look up the urefs array.
> > >
> >
> > We at least need the binding to know if binding->autorelease is on,
> > since without that we don't know whether the tokens are in the xarray or
> > binding->vec... but I guess we could also check if the xarray is
> > non-empty and infer that autorelease == true from that?
> >
> 
> I think as above, if autorelease is (only) a property of the sockets,
> then the xarray path works without introducing the socket-to-binding
> mapping restriction, yes?

Indeed, makes sense!

Best,
Bobby

