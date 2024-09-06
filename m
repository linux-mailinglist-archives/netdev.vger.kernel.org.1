Return-Path: <netdev+bounces-125996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C090E96F822
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CAA2865FE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464B71D2F49;
	Fri,  6 Sep 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJy4/doy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11281D0DCB
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636356; cv=none; b=I368Gs+T+nWbZ3vlxHgi6IKyYObN72RSccargRBKChwMpqrRJnqB//t2LQMJwxCxVqZJoVSuGoweiBd1stueK/7tSyrHJ1qprVZNA9Bz9fH85FmR7ZduQFBEuSSpYpk71gqHUa9xMxJ9xqhoXWQpENkWYw2fw3ho5OZyGmfAcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636356; c=relaxed/simple;
	bh=brb52DGRWVT5H8RAFZ30LWISTdRnqjsRwezcuOz6T2Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BWz17d1XLkF7RudVI1oxD0v1Um51ZS40RXZ2Of/Ar56HhREawnaAahcYmwQZ80Ssh3nJJwmCvtNMAGEoIuk3dremidv8XlGQAtw+/ls4xs6l9BF12EBfCNr+U2aHCgXYpVIyHd1gT6Ly0YNPWfnd/C0EGQT2oaCGFR37hhVaoj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJy4/doy; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-45812fdcd0aso4520021cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725636353; x=1726241153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVntJnzW4tsceKu1TgH7nkcx5u8KoYAfmT/FavIk39Q=;
        b=ZJy4/doyJ3q5YUIJQ6PjkHwccO4nMxJxBkK5kk2SgseOVBX/0rGJsQKTbkgO4u5uNl
         Z5YICgGsXfkv/Rzz7j5cPqXo6UzdBXEcA4CmZMffWUhm7yeA7Ub3OM8ecpijlQ7g4GPj
         M6S6nqVvy8h4cN+jitrZW06nuhIxW5MGHG4dZWO+wONcH2EJRrU5nTJlmJoJy8SqIQlv
         kbFTSlwxw/bwL6p+mmM/8RLyB58PeVB2odBXp0KpSQlWszJIPVeVzfsTTvnAcB3SEWRE
         Xx36gnSC4qSAVumZ2jzzL0eDZ3IHZMdpTn7yMzKzYDbhAZhrOVaIepE9kBEZpVfH4y8q
         lANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725636353; x=1726241153;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BVntJnzW4tsceKu1TgH7nkcx5u8KoYAfmT/FavIk39Q=;
        b=aypkuAqoNtSgJLUUJxaEI1vGiYfsCrBHR0fhgfcc1PwYitW+dNGUCLH/K26uSWdvPM
         KWiWyDmZiDBE4rkS6UUvxEb4qPhhkOInT0Js3sa5g3Hqu4hCiTP8DQmjD1/P8UM1nKbL
         zAuyw6kL9slQUIsy1q6C9nKcZ3dnZOPa3Kzt1dxzNO+xZO+AlbZhSMOmBqpIoJMcfbPN
         uIcji0YKxS8g999O0CCu5//rWHeipwhJZGS9j2Si+6mGA3s/QSIXTHPw2vGpXwWsge76
         J8RBbYbZMjVjw8qchoxQqFFeJ1XevbNXpsue1IbGAXrYdM7RkfBsbYWE/fQqsfnHk2bE
         6ksA==
X-Gm-Message-State: AOJu0YzjsHYv7xEK+X2vmkafTUkqzrShuVmzUU9kjevdjg6PKnnqgUS6
	NeW4LBdEA6BvkPxXmK9KLpbMiolHlHlVeHUiiH95CYADP19M8Aym
X-Google-Smtp-Source: AGHT+IHHTeVmt9CQf2wPEUGKdZPxJ4DfZc0ryIBGQfzE4xJg0vEi+P9KiBg+PU5K2uvexgHTwHrTUg==
X-Received: by 2002:ac8:7fd0:0:b0:44f:e11c:b0d8 with SMTP id d75a77b69052e-457f8b9714cmr168833421cf.7.1725636352915;
        Fri, 06 Sep 2024 08:25:52 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801db349asm16829301cf.76.2024.09.06.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:25:52 -0700 (PDT)
Date: Fri, 06 Sep 2024 11:25:52 -0400
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
Message-ID: <66db1f004a0c_29a3852944d@willemb.c.googlers.com.notmuch>
In-Reply-To: <bc6dcf94-bddb-4703-9451-21792378c45a@linux.dev>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-3-vadfed@meta.com>
 <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
 <66d9debb2d2ea_1eae1a2943d@willemb.c.googlers.com.notmuch>
 <bc6dcf94-bddb-4703-9451-21792378c45a@linux.dev>
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
> On 05/09/2024 17:39, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> On 04/09/2024 12:31, Vadim Fedorenko wrote:
> >>> TCP sockets have different flow for providing timestamp OPT_ID value.
> >>> Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
> >>>
> >>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> >>> ---
> >>>    net/ipv4/tcp.c | 13 +++++++++----
> >>>    1 file changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> >>> index 8a5680b4e786..5553a8aeee80 100644
> >>> --- a/net/ipv4/tcp.c
> >>> +++ b/net/ipv4/tcp.c
> >>> @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
> >>>    }
> >>>    EXPORT_SYMBOL(tcp_init_sock);
> >>>    
> >>> -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> >>> +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
> >>>    {
> >>>    	struct sk_buff *skb = tcp_write_queue_tail(sk);
> >>> +	u32 tsflags = sockc->tsflags;
> >>>    
> >>>    	if (tsflags && skb) {
> >>>    		struct skb_shared_info *shinfo = skb_shinfo(skb);
> >>> @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> >>>    		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
> >>>    		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> >>>    			tcb->txstamp_ack = 1;
> >>> -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> >>> -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> >>> +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> >>> +			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
> >>> +				shinfo->tskey = sockc->ts_opt_id;
> >>> +			else
> >>> +				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> >>> +		}
> >>>    	}
> >>>    }
> >>>    
> >>> @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> >>>    
> >>>    out:
> >>>    	if (copied) {
> >>> -		tcp_tx_timestamp(sk, sockc.tsflags);
> >>> +		tcp_tx_timestamp(sk, &sockc);
> >>>    		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
> >>>    	}
> >>>    out_nopush:
> >>
> >> Hi Willem,
> >>
> >> Unfortunately, these changes are not enough to enable custom OPT_ID for
> >> TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
> >> flow:
> >>
> >> tcp_skb_collapse_tstamp()
> >> tcp_fragment_tstamp()
> >> tcp_gso_tstamp()
> >>
> >> I believe the last one breaks tests, but the problem is that there is no
> >> easy way to provide the flag of constant tskey to it. Only
> >> shinfo::tx_flags are available at the caller side and we have already
> >> discussed that we shouldn't use the last bit of this field.
> >>
> >> So, how should we deal with the problem? Or is it better to postpone
> >> support for TCP sockets in this case?
> > 
> > Are you sure that this is a problem. These functions pass on the
> > skb_shinfo(skb)->ts_key from one skb to another.
> 
> Yes, you are right, the problem is in a different place.
> 
> __skb_complete_tx_timestamp receives skb with shinfo->tskey equal to
> provided by cmsg. But for TCP sockets it unconditionally adjusts ee_data
> value:
> 
> 	if (sk_is_tcp(sk))
> 		serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
> 
> It happens because of assumption that for TCP sockets shinfo::tskey will
> have sequence number and the logic has to recalculate it back to the
> bytes sent. The same logic exists in all TCP TX timestamping functions
> (mentioned in the previous mail) and may trigger some unexpected
> behavior. To fix the issue we have to provide some kind of signal that
> tskey value is provided from user-space and shouldn't be changed. And we
> have to have it somewhere in skb info. Again, tx_flags looks like the
> best candidate, but it's impossible to use. I'm thinking of using
> special flag in tcp_skb_cb - gonna test more, but open for other
> suggestions.

Ai, that is tricky. tx_flags is full/scarce indeed.

CB does not persist as the skb transitions between layers.

The most obvious solution would be to set the flag in sk_tsflags
itself. But then the cmsg would no long work on a per request basis:
either the socket uses OPT_ID with counter or OPT_ID_CMSG.

Good that we catch this now before the ABI is finalized.

If necessary TCP semantics can diverge from datagrams. So we could
punt on this. But it's not ideal.

