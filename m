Return-Path: <netdev+bounces-126124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD096FE99
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4814285CAE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDC21581EA;
	Fri,  6 Sep 2024 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsxjw5BI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE615B0FA
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725666498; cv=none; b=pDzp82hDNQBaWPvB+r3dWw/kzEO1xO3OLAhnBhgXY2SMkYW2j9fh+R9uCHbtpk1tbwrMwxo0DXJ1/DJR5zKEH1dgKDeOYZTMEnVJtmH8peWkTzf8WG+ETskCWpnfkg3Bnf6JBn7RYWeeO6Qfu0tbYcMliCjWiIM7MsdE7Lvb//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725666498; c=relaxed/simple;
	bh=sUXfsViiF3VMVX52pmJEgZQwXsB/OQPPNdE313+AUks=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l+ozS8S1jjb/8JK0HCweJ0TJVoMVWDAB2eW80cR7bcY5TJW4Rr73eGYWdvvjIuw5vwDCM/o4N3QGxujQksuugF5xZOjc5uHx407H9tHJhAOoB+sUBghq+QwigZCtRD6rA5iwO/d5g6Wc+r4XUaw01CraKvl5nD+pAtGKSGJrqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsxjw5BI; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so3076164276.2
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 16:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725666495; x=1726271295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/Uc9cN2dABLo6AmQ4/JOt5D05Jl9EX//TdZ8d+KqJI=;
        b=Bsxjw5BI5AwBdS8WTkm2RNMcWv4H2Nxvni4v/N0qxMQkzZWMqv/tXI/qFoTmhkjguc
         vX2Mnt5+g1JDn6n5QKgu6RvI++NZDH/XCiv3wxPAPTmZDLLNPe/kla8SFj4Eo6I7VECh
         wnQGHtJ+On+c1MZ+XkFKuJ3FqypqyjKnc9DVSV33HmZdma751lBGvWcuRSFB5/Pinpvl
         /vT7bWU+W6dxE1JxyeB/UD7yJtSNU4MXM1N3dJ1WoyFVcPo2HwuL9JeqahubHw26eEfC
         M59dIE8elpt46U+UH5A+0B6IV/lKjSPJ+cFq6V9QLJ35FqFwNMNrxdWDGX5fiD965bBc
         MM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725666495; x=1726271295;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w/Uc9cN2dABLo6AmQ4/JOt5D05Jl9EX//TdZ8d+KqJI=;
        b=YIcVdESwSQsqbr8P/RVb3eZujpktrnRisbOcxX8uDCilCUDvRL0fUBQdSOQ6fVWkuS
         X5/o25hpS1gflMHGlnygnHpZ8VNwmtYkkPTjGDA+AwVKeulr0r6YDD2RIQdukcxQySfA
         sUDONGSqj/UFN3LC2dt+HYNp47z7LyY1zSJFPSixTkzjgY6bTOZr9GR6tPZpZ2TLHm7m
         UPHiUzWhyHn7xarD255hfgU9sVGoDlGQ9sr/KyJHVpcyij5uVC4InJ7DJpjlphOgY2Lr
         46sGIj5HwU5IqaE1VD9GMxpZDMeatTfdqev6WiGlFny9bTOrE3gusrgf3ztem4qRKESM
         l3/g==
X-Gm-Message-State: AOJu0YwXjf0+81BraaOvDPnep0ZtskMPBd28UhyB4J/Bo8vIynKFqk15
	n6+zKH8xPoan43DrVhBM1mNuQEEhjfSfN5tZuUHwIw6dxpPikbJK
X-Google-Smtp-Source: AGHT+IEeQVDWy1hA9pJcWoHUcsuxmd0rcJdWh0jCP3TVLYgW+naZIr+FdeaLWvDOGbxRtuVf8xjzgA==
X-Received: by 2002:a05:6902:178e:b0:e1d:2917:b1f0 with SMTP id 3f1490d57ef6-e1d3488d6a8mr5626181276.21.1725666495337;
        Fri, 06 Sep 2024 16:48:15 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d957sm113136d6.81.2024.09.06.16.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 16:48:14 -0700 (PDT)
Date: Fri, 06 Sep 2024 19:48:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <66db94be6e209_2a33ef294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <1f17d828-5d0f-4050-be4b-8840feb8de76@linux.dev>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-3-vadfed@meta.com>
 <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
 <66d9debb2d2ea_1eae1a2943d@willemb.c.googlers.com.notmuch>
 <bc6dcf94-bddb-4703-9451-21792378c45a@linux.dev>
 <66db1f004a0c_29a3852944d@willemb.c.googlers.com.notmuch>
 <1f17d828-5d0f-4050-be4b-8840feb8de76@linux.dev>
Subject: Re: [PATCH net-next v3 2/4] net_tstamp: add SCM_TS_OPT_ID for TCP
 sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> On 06/09/2024 16:25, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> On 05/09/2024 17:39, Willem de Bruijn wrote:
> >>> Vadim Fedorenko wrote:
> >>>> On 04/09/2024 12:31, Vadim Fedorenko wrote:
> >>>>> TCP sockets have different flow for providing timestamp OPT_ID value.
> >>>>> Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
> >>>>>
> >>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >>>>> ---
> >>>>>     net/ipv4/tcp.c | 13 +++++++++----
> >>>>>     1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >>>>> index 8a5680b4e786..5553a8aeee80 100644
> >>>>> --- a/net/ipv4/tcp.c
> >>>>> +++ b/net/ipv4/tcp.c
> >>>>> @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
> >>>>>     }
> >>>>>     EXPORT_SYMBOL(tcp_init_sock);
> >>>>>     
> >>>>> -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> >>>>> +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
> >>>>>     {
> >>>>>     	struct sk_buff *skb = tcp_write_queue_tail(sk);
> >>>>> +	u32 tsflags = sockc->tsflags;
> >>>>>     
> >>>>>     	if (tsflags && skb) {
> >>>>>     		struct skb_shared_info *shinfo = skb_shinfo(skb);
> >>>>> @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> >>>>>     		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
> >>>>>     		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> >>>>>     			tcb->txstamp_ack = 1;
> >>>>> -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> >>>>> -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> >>>>> +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> >>>>> +			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
> >>>>> +				shinfo->tskey = sockc->ts_opt_id;
> >>>>> +			else
> >>>>> +				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> >>>>> +		}
> >>>>>     	}
> >>>>>     }
> >>>>>     
> >>>>> @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> >>>>>     
> >>>>>     out:
> >>>>>     	if (copied) {
> >>>>> -		tcp_tx_timestamp(sk, sockc.tsflags);
> >>>>> +		tcp_tx_timestamp(sk, &sockc);
> >>>>>     		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
> >>>>>     	}
> >>>>>     out_nopush:
> >>>>
> >>>> Hi Willem,
> >>>>
> >>>> Unfortunately, these changes are not enough to enable custom OPT_ID for
> >>>> TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
> >>>> flow:
> >>>>
> >>>> tcp_skb_collapse_tstamp()
> >>>> tcp_fragment_tstamp()
> >>>> tcp_gso_tstamp()
> >>>>
> >>>> I believe the last one breaks tests, but the problem is that there is no
> >>>> easy way to provide the flag of constant tskey to it. Only
> >>>> shinfo::tx_flags are available at the caller side and we have already
> >>>> discussed that we shouldn't use the last bit of this field.
> >>>>
> >>>> So, how should we deal with the problem? Or is it better to postpone
> >>>> support for TCP sockets in this case?
> >>>
> >>> Are you sure that this is a problem. These functions pass on the
> >>> skb_shinfo(skb)->ts_key from one skb to another.
> >>
> >> Yes, you are right, the problem is in a different place.
> >>
> >> __skb_complete_tx_timestamp receives skb with shinfo->tskey equal to
> >> provided by cmsg. But for TCP sockets it unconditionally adjusts ee_data
> >> value:
> >>
> >> 	if (sk_is_tcp(sk))
> >> 		serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
> >>
> >> It happens because of assumption that for TCP sockets shinfo::tskey will
> >> have sequence number and the logic has to recalculate it back to the
> >> bytes sent. The same logic exists in all TCP TX timestamping functions
> >> (mentioned in the previous mail) and may trigger some unexpected
> >> behavior. To fix the issue we have to provide some kind of signal that
> >> tskey value is provided from user-space and shouldn't be changed. And we
> >> have to have it somewhere in skb info. Again, tx_flags looks like the
> >> best candidate, but it's impossible to use. I'm thinking of using
> >> special flag in tcp_skb_cb - gonna test more, but open for other
> >> suggestions.
> > 
> > Ai, that is tricky. tx_flags is full/scarce indeed.
> > 
> > CB does not persist as the skb transitions between layers.
> > 
> > The most obvious solution would be to set the flag in sk_tsflags
> > itself. But then the cmsg would no long work on a per request basis:
> > either the socket uses OPT_ID with counter or OPT_ID_CMSG.
> > 
> > Good that we catch this now before the ABI is finalized.
> > 
> > If necessary TCP semantics can diverge from datagrams. So we could
> > punt on this. But it's not ideal.
> 
> I have done proof of concept code which uses hwtsamp as a storage for
> custom tskey in case of TCP:
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a52638363ea5..40ed49e61bf7 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5414,8 +5414,6 @@ static void __skb_complete_tx_timestamp(struct 
> sk_buff *skb,
>          serr->header.h4.iif = skb->dev ? skb->dev->ifindex : 0;
>          if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
>                  serr->ee.ee_data = skb_shinfo(skb)->tskey;
> -               if (sk_is_tcp(sk))
> -                       serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
>          }
> 
>          err = sock_queue_err_skb(sk, skb);
> @@ -5450,6 +5448,8 @@ void skb_complete_tx_timestamp(struct sk_buff *skb,
>           * but only if the socket refcount is not zero.
>           */
>          if (likely(refcount_inc_not_zero(&sk->sk_refcnt))) {
> +               if (sk_is_tcp(sk) && (READ_ONCE(sk->sk_tsflags) & 
> SOF_TIMESTAMPING_OPT_ID) && skb_hwtstamps(skb)->hwtstamp)
> +                       skb_shinfo(skb)->tskey = 
> (u32)skb_hwtstamps(skb)->hwtstamp;
>                  *skb_hwtstamps(skb) = *hwtstamps;
>                  __skb_complete_tx_timestamp(skb, sk, SCM_TSTAMP_SND, 
> false);
>                  sock_put(sk);
> @@ -5509,6 +5509,12 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
>                  skb_shinfo(skb)->tskey = skb_shinfo(orig_skb)->tskey;
>          }
> 
> +       if (sk_is_tcp(sk) && (tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> +               if (skb_hwtstamps(orig_skb)->hwtstamp)
> +                       skb_shinfo(skb)->tskey = 
> (u32)skb_hwtstamps(orig_skb)->hwtstamp;
> +               else
> +                       skb_shinfo(skb)->tskey -= 
> atomic_read(&sk->sk_tskey);
> +       }
>          if (hwtstamps)
>                  *skb_hwtstamps(skb) = *hwtstamps;
>          else
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d3decc13a99..1a161a2155b5 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -488,9 +488,8 @@ static void tcp_tx_timestamp(struct sock *sk, struct 
> sockcm_cookie *sockc)
>                          tcb->txstamp_ack = 1;
>                  if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
>                          if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
> -                               shinfo->tskey = sockc->ts_opt_id;
> -                       else
> -                               shinfo->tskey = TCP_SKB_CB(skb)->seq + 
> skb->len - 1;
> +                               skb_hwtstamps(skb)->hwtstamp = 
> sockc->ts_opt_id;
> +                       shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>                  }
>          }
>   }
> 
> 
> Looks like we can add u32 tskey field in skb_shared_hwtstamps and reuse
> it. netdev_data field is only used on RX timestamp side, so should be
> fine to reuse. WDYT?

We cannot really extend the struct. skb_shared_info is scarce.
hwtstamps is a union. But on tx the hw tstamp is queued using
skb_tstamp_tx, not through this shinfo data at all.

It just seems weird to have a shinfo->tskey, but then ignore it and
find yet another 32b field. Easier would be to find 1b to toggle
whether tskey is to be interpreted as counter based or OPT_ID_CMSG.

I don't immediate see a perfect solution either.

