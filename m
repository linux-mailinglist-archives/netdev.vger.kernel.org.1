Return-Path: <netdev+bounces-130544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3398AC13
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B791C22D3B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197FB1990AE;
	Mon, 30 Sep 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2eZl+tT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120EC199247
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720886; cv=none; b=u4cQywDEiYviyN6vpnWsBKKCJE4LP8wpbbtybQ5Ll6x8wJGavc4H7B8hiE7yMw58HKEdNx1UQT7/CxgnMV4BhyBogH9VaVWe2r+ZBZzF7VAK9mUYdG9f/NUTRItuwG1kUDBmRyX+/oFVfWhqIG8H71tgMZq0uaLuJY+5n6KK1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720886; c=relaxed/simple;
	bh=J31iYw2EsL6fME8Jo9sRiFNQanqUmiDy11cY3scqyl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kH55FM2PYWNbJPQzhl1u07KkvUJNjvHVUxISaWOMjA5jE7ONeltvOgXmgIp1s7RtdWiCIyVyfGHGg95zQcrnZ7KIiUT8DfBGJU+K4gVWeP8+/+s9dnyy1tEUbG0jSCFJLdnnCM6mvN6U4G1ubbiAiKY8xPMq2jkMDhmXNpIwN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2eZl+tT; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso9728071fa.1
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727720882; x=1728325682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNMX9i6xizZxd1sDK+DA0ZYLDA/frsIwMVk0c/LHdgk=;
        b=H2eZl+tT/l7ntkKYpmA1Snbs3ju+rfxJe8qVlyl4wbMcS5RGl7CncVIAuZQYWYCphs
         l9nPp2xeWKWrhZH/H60QeyS0QzetLzLxQ41AGgqHmuTSbXyOoZxDzXgS5C4qBrtcI1r/
         gEAUtlqlWEL1Zgis0Fx43b9u2UQs8o6+SpktA+KZPhsdP8jLvGQrpEEMlXnqpEsH7BRO
         weajnC1rxychVlC8pVPUbJbgOicqDDLGbP5BmQP60Cnd0M5/rJ/RznsObyO8DUCJX7RC
         uV+sPSIfzW2tgIs/TDZq+3xRgL7aRSxJcJc331HpNt3fRCXZRx+DrhMAVEW0fpt/mD/y
         Ai+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720882; x=1728325682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNMX9i6xizZxd1sDK+DA0ZYLDA/frsIwMVk0c/LHdgk=;
        b=fdOToaGgy5b7X6h4EFF9Fdvya+z2h1D+1HslPlsDs23/1tNuzL7qw6Rg8khxQTa+Gl
         Fh45H8ScudF0OfkbXM9n/3IHkfVy0HKzYeBe0WNw3XZ6f7uVv+vVn6HVFDK7N1AKLdox
         78QiBpiavyRwZ8htWvQ5RZqewy4mGrrN58OumxEYqXFQZr0mrKxMJuXq2PMoHWlW9Mlx
         CV6v3CheHRXoRkiWdKSsMyB5FolRhnbOymHMFwtnDFBD8JFpGOdjcIiDWw24CAEoQgTl
         6P3P3VntxxE6guIFjAYx3m9XsCg9Y7czZgN5s3giV0MIyrr0c6SbWoBN50ctj5kOF7cW
         S/Tg==
X-Gm-Message-State: AOJu0YzV0LdRA8BVygwdbf6bbR51IMNalbrHrg69HmAD2141OMQFwUMl
	F0+tjIJuE0KqJ6AOCJ1TCNhK/WOU4yWJZeGNx+wp2UKMtwE/IT+Yf237tcbmKCggQkNri2zIaVJ
	w6aMm9oM0JruYuUr9nVN502s9bmNXeAJKZrcbBVz6FFjUy20GbB3n
X-Google-Smtp-Source: AGHT+IEU+USdR74v6Bl8WAplHOTuuqK1D48GRRV5rqcrAqMGrlwW8HtfzJYX20k/2tOEeZuatwVlUXdhav1t7KTEMH4=
X-Received: by 2002:a2e:709:0:b0:2ef:21b3:cdef with SMTP id
 38308e7fff4ca-2f9d3e69d25mr50245751fa.25.1727720881787; Mon, 30 Sep 2024
 11:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930180916.GA24637@incl>
In-Reply-To: <20240930180916.GA24637@incl>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Sep 2024 20:27:50 +0200
Message-ID: <CANn89iJQDWEyTC5Xc77PEXyxbbvKjm=exb5jKB0-O3ZzZ=W1Hg@mail.gmail.com>
Subject: Re: [RFC PATCH] ipv6: route: release reference of dsts cached in sockets
To: Jiri Wiesner <jwiesner@suse.de>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 8:09=E2=80=AFPM Jiri Wiesner <jwiesner@suse.de> wro=
te:
>
> An unbalanced refcount was reported for the loopback device of a net
> namespace being destroyed:
> unregister_netdevice: waiting for lo to become free. Usage count =3D 2
>
> Analysis revealed that the IPv6 net device corresponding to the loopback
> device did not get destroyed (in6_dev_finish_destroy() was not called).
> The IPv6 loopback device had an unbalaced refcount:
> net dev 73da100 lo refcount 1
> Operation                     Count Balancing Operation     Count
> hold  __ipv6_dev_mc_inc           2 ma_put                      2
>       addrconf_ifdown             1                             0 unbalan=
ced
> hold  fib6_nh_init                2 fib6_nh_init                2
> put   inet6_ifa_finish_destroy    1 ipv6_add_addr               1
>       ip6_dst_destroy            90                             0 unbalan=
ced
>       ip6_dst_ifdown             90                             0 unbalan=
ced
> hold  ip6_route_dev_notify        6 ip6_route_dev_notify        6
> hold  ipv6_add_addr               1 inet6_ifa_finish_destroy    1
> put   ma_put                      2 __ipv6_dev_mc_inc           2
> hold  ndisc_netdev_event          2 ndisc_netdev_event          2
>       rt6_disable_ip              1                             0 unbalan=
ced
>
> The refcount of addrconf_ifdown() balances the refcount increment in
> ipv6_add_dev(), which had no corresponding trace entry. The
> rt6_disable_ip() and ip6_dst_ifdown() entries were hold operations on the
> looback device, and the ip6_dst_destroy() entries were put operations. On=
e
> refcount decrement in ip6_dst_destroy() was not executed. At this point, =
a
> hash was implemented in the debug kernel to hold the changes of the
> refcount of dst objects per namespace. The trace for the dst object that
> did not decrement the IPv6 refcount of loopback follows:
>
> Function        Parent       Op  Net            Device Dst              R=
efcount Diff
> ip6_dst_ifdown: dst_dev_put: dst ff404b2f073da100 eth0 ff404af71ffc9c00 1
> ip6_negative_advice: tcp_retransmit_timer: dst_hold ff404b2f073da100 eth0=
 ff404af71ffc9c00 1
> dst_alloc: ip6_dst_alloc: dst_hold ff404b2f073da100 eth0 ff404af71ffc9c00=
 1
> ip6_route_output_flags: ip6_dst_lookup_tail: dst_hold ff404b2f073da100 et=
h0 ff404af71ffc9c00 84
> dst_release: ip6_negative_advice: dst_put ff404b2f073da100 eth0 ff404af71=
ffc9c00 1
> dst_release: tcp_retransmit_timer: dst_put ff404b2f073da100 eth0 ff404af7=
1ffc9c00 20
> dst_release: inet_sock_destruct: dst_put ff404b2f073da100 eth0 ff404af71f=
fc9c00 29
> dst_release: __dev_queue_xmit: dst_put ff404b2f073da100 eth0 ff404af71ffc=
9c00 34
> dst_release: rt6_remove_exception: dst_put ffffffff9c8e2a80 blackhole_dev=
 ff404af71ffc9c00 1
>
> The ip6_dst_ifdown() trace entry was neither a hold nor a put - it merely
> indicates that the net device of the dst object was changed to
> blackhole_dev and the IPv6 refcount was transferred onto the loopback
> device. There was no ip6_dst_destroy() trace entry, which means the dst
> object was not destroyed. There were 86 hold operations but only 85 put
> operations so the dst object was not destroyed because the refcount of th=
e
> dst object was unbalanced.
>
> The problem is that the refcount sums are ambiguous. The most probable
> explanation is this: The dst object was a route for an IPv6 TCP connectio=
n
> that kept timing out. Sometimes, the process closed the socket, which
> corresponds to the refcount decrements of the
> dst_release()/inet_sock_destruct() entries. Sometimes, the TCP retransmit
> timer reset the dst of the sockets, which corresponds to the
> dst_release()/tcp_retransmit_timer() entries. I am unsure about the
> dst_release()/__dev_queue_xmit() entries because inet6_csk_xmit() sets
> skb->_skb_refdst with SKB_DST_NOREF.
>
> The feature that sets the above trace apart from all the other dst traces
> is the execution of ip6_negative_advice() for a cached and also expired
> dst object in the exception table. The cached and expired dst object has
> its refcount set to at least 2 before executing rt6_remove_exception_rt()
> found in ip6_negative_advice(). One decrement happens in
> rt6_remove_exception() after the dst object has been removed from the
> exception table. The other decrement happens in sk_dst_reset() but that
> one is counteracted by a dst_hold() intentionally placed just before the
> sk_dst_reset() in ip6_negative_advice(). The probem is that a socket that
> keeps a reference to a dst in its sk_dst_cache member increments the
> refcount of the dst by 1. This is apparent in the following code paths:
> * When ip6_route_output_flags() finds a dst that is then stored in
>   sk->sk_dst_cache by ip6_dst_store() called from inet6_csk_route_socket(=
).
> * When inet_sock_destruct() calls dst_release() for sk->sk_dst_cache
> Provided the dst is not kept in the sk_dst_cache member of another socket=
,
> there is no other object tied to the dst (the socket lost its reference
> and the dst is no longer in the exception table) and the dst becomes a
> leaked object after ip6_negative_advice() finishes. This leak then
> precludes the net namespace from being destroyed.
>
> The patch that introduced the dst_hold() in ip6_negative_advice() was
> 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b2=
2
> only refactored the code with regards to the dst refcount so the issue wa=
s
> present even before 92f1655aa2b22.
>
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
> ---
> At the moment, I am sending this as an RFC because I am not able to
> reproduce the issue in-house. The customer that encountered the issue is
> currently running tests. For the customer's testing, I fixed the issue
> with a kprobe module that calls dst_release() right after
> rt6_remove_exception_rt() returns in ip6_negative_advice(), which is not
> quite the same as the change proposed below.
>
>  net/ipv6/route.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b4251915585f..b70267c8d251 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2780,10 +2780,7 @@ static void ip6_negative_advice(struct sock *sk,
>         if (rt->rt6i_flags & RTF_CACHE) {
>                 rcu_read_lock();
>                 if (rt6_check_expired(rt)) {
> -                       /* counteract the dst_release() in sk_dst_reset()=
 */
> -                       dst_hold(dst);
>                         sk_dst_reset(sk);
> -
>                         rt6_remove_exception_rt(rt);
>                 }
>                 rcu_read_unlock();
> --

Interesting, what kernel version is your customer using ?

I think that with recent kernels (after 5.18), we do not see issues
because of the use of blackhole_netdev
instead of loopback.

