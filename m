Return-Path: <netdev+bounces-126125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132DA96FE9A
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44771B22BB8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891C615B10E;
	Fri,  6 Sep 2024 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4S9lYXg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95D1581EA
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725666634; cv=none; b=qGYZGeYgoFEgoDZ6VgqUb4gy94cC9qj6KYOWRFs2xkEWosnLUL5m9PMA2TJ0WvSEWjYimRpJSYhSEo7nICD160M45vLKDIoY3Agi+rw3/YIjhtsU48usysppzx0S5WAI7/6kILf9GFYjBRqnFxFmGX0gWWiGlwWNAjEnDTXqGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725666634; c=relaxed/simple;
	bh=dhgXD1OyXJ+RwJ2S3JHf7CeBAUq9PBSY4h6adh7iYgk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MIuZZaIfYYvlOikYi96dtMCuLjEjZwVgvIBnN61oP3aNbAEoDJ1ZBGi94PSgtuMcluH9ERt3D/Xm9nyF6BG/18W9utNu2r7M9Og1kuCwFllcZenkitHbzGdAQBY4WJzrycMIn9FnO5aqGzqGHbVvvBAu24YiMSbCvcohlzyME/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4S9lYXg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a809736a2cso155340585a.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725666632; x=1726271432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+Zwp+9HvQc/CezXcygKdf+XRjb0SEtKNlNhnd02UYI=;
        b=j4S9lYXgnmBp7/xnJtqklwucmSB162DA+yHXmmQRk/H/Crrn6OL3F9QAhLsuwlqu5W
         lZceN6Oq099bcvAw5429rKFPkPcO3DVkNmHIzTKndZ+Z15T7h322mpONN1Vu/jhJv4ym
         Xrwjd5W21zvjdZ9DL1VTDqEem8p2WgmTgkOBzQjHY9se11o+dv5EUFBR5cWBSJvQKzHn
         06XeqQo1xDAJIpexHcsbOvgdp0SMPdv5tFH8i/416rWAAgPdqp74SyHpo9EsRB5y7Jwe
         tqM4/9cCpqaztqqi/ra6BEdDR/9VjM221aKioa3faBnhqhZ4B/Q0K6MmC9+sxJ7BKInr
         opgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725666632; x=1726271432;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+Zwp+9HvQc/CezXcygKdf+XRjb0SEtKNlNhnd02UYI=;
        b=n+bcKoE75bkHeV5O3ja1cePARwiOMGVJBTXmXUEv88Oit5tZCBGRwOgPBmMXzS/I1N
         4TL7EwdtiYvMVzAFqt8YpETsL0fDhMqH/A69pMPk0rjjZKsjnCCds7V9ZdSiPa6IPXXX
         exbWyyY4VO/DjuEqHlD716/DJjC0Z6C5xPK59qVDuBiju7vG55GPtM0yWmlOhikR3Dfz
         9+iWWYBeYkktamNFfDeP6v2T3Yqb1SfsllA7oCAgGQtA3musgemAULpGnYMfSwD3PtCR
         tYPlz5IphiJZXZEOYUsXNeBcicZ36ZfMF+g/BqBga+b0GF6Mzfpo3F4EgY6A6LbOWNIG
         hIVA==
X-Gm-Message-State: AOJu0YyYu6PxkxQ1luuUXQZiUW7sFw7Z6XHvSPnBYc1tlbEYShbrSs60
	hVY7J3S8NIFQoFGa1QtpghyTxcgRM0sS+0ebYZqmK9Ugy4GAxOuy3ngXBA==
X-Google-Smtp-Source: AGHT+IH1p5y8vGQfIha3BFLChoL++j4JqHDHrs59DW9P+3sGWubo0T0kWnGBYD297OpKkF8h+BwlTQ==
X-Received: by 2002:a05:620a:2992:b0:7a6:5c84:4303 with SMTP id af79cd13be357-7a99734314cmr557574585a.35.1725666631704;
        Fri, 06 Sep 2024 16:50:31 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7967e7asm3609485a.38.2024.09.06.16.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 16:50:31 -0700 (PDT)
Date: Fri, 06 Sep 2024 19:50:30 -0400
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
Message-ID: <66db9546f0ecb_2a33ef294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <a3ccb46c-7493-4a6d-8792-bb5ccd19bce3@linux.dev>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-3-vadfed@meta.com>
 <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
 <66d9debb2d2ea_1eae1a2943d@willemb.c.googlers.com.notmuch>
 <bc6dcf94-bddb-4703-9451-21792378c45a@linux.dev>
 <66db1f004a0c_29a3852944d@willemb.c.googlers.com.notmuch>
 <66db2eef2d90_29c8c329475@willemb.c.googlers.com.notmuch>
 <a3ccb46c-7493-4a6d-8792-bb5ccd19bce3@linux.dev>
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
> On 06/09/2024 17:33, Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> >> Vadim Fedorenko wrote:
> >>> On 05/09/2024 17:39, Willem de Bruijn wrote:
> >>>> Vadim Fedorenko wrote:
> >>>>> On 04/09/2024 12:31, Vadim Fedorenko wrote:
> >>>>>> TCP sockets have different flow for providing timestamp OPT_ID value.
> >>>>>> Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
> >>>>>>
> >>>>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >>>>>> ---
> >>>>>>     net/ipv4/tcp.c | 13 +++++++++----
> >>>>>>     1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >>>>>> index 8a5680b4e786..5553a8aeee80 100644
> >>>>>> --- a/net/ipv4/tcp.c
> >>>>>> +++ b/net/ipv4/tcp.c
> >>>>>> @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
> >>>>>>     }
> >>>>>>     EXPORT_SYMBOL(tcp_init_sock);
> >>>>>>     
> >>>>>> -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> >>>>>> +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
> >>>>>>     {
> >>>>>>     	struct sk_buff *skb = tcp_write_queue_tail(sk);
> >>>>>> +	u32 tsflags = sockc->tsflags;
> >>>>>>     
> >>>>>>     	if (tsflags && skb) {
> >>>>>>     		struct skb_shared_info *shinfo = skb_shinfo(skb);
> >>>>>> @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> >>>>>>     		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
> >>>>>>     		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> >>>>>>     			tcb->txstamp_ack = 1;
> >>>>>> -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> >>>>>> -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> >>>>>> +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> >>>>>> +			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
> >>>>>> +				shinfo->tskey = sockc->ts_opt_id;
> >>>>>> +			else
> >>>>>> +				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> >>>>>> +		}
> >>>>>>     	}
> >>>>>>     }
> >>>>>>     
> >>>>>> @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> >>>>>>     
> >>>>>>     out:
> >>>>>>     	if (copied) {
> >>>>>> -		tcp_tx_timestamp(sk, sockc.tsflags);
> >>>>>> +		tcp_tx_timestamp(sk, &sockc);
> >>>>>>     		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
> >>>>>>     	}
> >>>>>>     out_nopush:
> >>>>>
> >>>>> Hi Willem,
> >>>>>
> >>>>> Unfortunately, these changes are not enough to enable custom OPT_ID for
> >>>>> TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
> >>>>> flow:
> >>>>>
> >>>>> tcp_skb_collapse_tstamp()
> >>>>> tcp_fragment_tstamp()
> >>>>> tcp_gso_tstamp()
> >>>>>
> >>>>> I believe the last one breaks tests, but the problem is that there is no
> >>>>> easy way to provide the flag of constant tskey to it. Only
> >>>>> shinfo::tx_flags are available at the caller side and we have already
> >>>>> discussed that we shouldn't use the last bit of this field.
> >>>>>
> >>>>> So, how should we deal with the problem? Or is it better to postpone
> >>>>> support for TCP sockets in this case?
> >>>>
> >>>> Are you sure that this is a problem. These functions pass on the
> >>>> skb_shinfo(skb)->ts_key from one skb to another.
> >>>
> >>> Yes, you are right, the problem is in a different place.
> >>>
> >>> __skb_complete_tx_timestamp receives skb with shinfo->tskey equal to
> >>> provided by cmsg. But for TCP sockets it unconditionally adjusts ee_data
> >>> value:
> >>>
> >>> 	if (sk_is_tcp(sk))
> >>> 		serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
> >>>
> >>> It happens because of assumption that for TCP sockets shinfo::tskey will
> >>> have sequence number and the logic has to recalculate it back to the
> >>> bytes sent. The same logic exists in all TCP TX timestamping functions
> >>> (mentioned in the previous mail) and may trigger some unexpected
> >>> behavior. To fix the issue we have to provide some kind of signal that
> >>> tskey value is provided from user-space and shouldn't be changed. And we
> >>> have to have it somewhere in skb info. Again, tx_flags looks like the
> >>> best candidate, but it's impossible to use. I'm thinking of using
> >>> special flag in tcp_skb_cb - gonna test more, but open for other
> >>> suggestions.
> >>
> >> Ai, that is tricky. tx_flags is full/scarce indeed.
> >>
> >> CB does not persist as the skb transitions between layers.
> > 
> > Though specifically for TCP, it is possible to look up the fast
> > clone on the rtx queue, whose tcp_skb_cb will be unperturbed. But
> > the tcb currently does not have this data either.
> 
> It will work fine for software timestamps, but we cannot do the same
> trick in case of HW timestamps, right?

I'm not really advocating it. The only user of this trick that I can
find is skb_still_in_host_queue, through skb_fclone_busy.

That said, it would also work for hardware, as the SKB_FCLONE_ORIG
remains on the rtx queue. In the common case. But skb_fclone_busy
points out edge cases, such as if a driver call skb_orphan..

