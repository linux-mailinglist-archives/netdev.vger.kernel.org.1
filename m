Return-Path: <netdev+bounces-126017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6296F967
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFB2285C56
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60901D318A;
	Fri,  6 Sep 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+YseyOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19655322A
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640434; cv=none; b=YDpZNCxNPVDWwl5Y5dW0/6gBKXDBBtsScXkYqhQaV/zJpvlc3rUAS+jIzIkLb6HPUg+Qjpg5ykbHXYLbq60OlWM9EVujseH6fyTOhdcmfc7xBG3Z/rgjVcakeDgLRzkkwqwbsOMGjZ02AUF0pLWTVbc/r/74AWWonx03QAnwhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640434; c=relaxed/simple;
	bh=xRQGx2qyHZt5dybiAZ/DdiiZSkt83IBRf4e0OnCxMpc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VYKRglFOYylwZIWCtj2iw7hC392YN2Sip67BEd7QbBjHe2txEReXwI8UUDIAWAM5TvxUuyRugPwJu5oxMJPd6mnn99k0mHYbIVn69hmd89Rr9vsQ2KrMV2nVDYHWu7X1Frv7KoqoxWmXqTLEzAoJeZF1QLfHyRm27yDVUFOewM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+YseyOM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99e8ad977so36010085a.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725640432; x=1726245232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6nSRREYuTQSGIk0jdG4fHbkHme8kt0KwwYjL/VuTDs=;
        b=N+YseyOMRNKezexHhFNS5GWWwnzzH4q1SZgW5LWy93wl2LMTNXJPrDr/shNhnPgfut
         DjW3K0Ga3t/JJagVSe7R0SLYezB8SSYqw7uEBwNhF8evp3He1GTFsp4Lg4Npp6IE5TGj
         AsQ/sBtjY4vp8prT+9DxlFhmebfoDOV5r9rhIK4NzhgUIpZuwh8R1besYXVoqinAC1Z0
         C30tcsCOk/SjN8LF8a5k6EOofUC1kzjoAsLnou3jy62HVJN9Va7JN+DHg6it0SORmegS
         XVyK6Pn1jhJCTTYq07hEHjlsgN3ZsgVK/b/AvXxP5iBGVbk19ZPcso75TGWo7zP+i/4C
         kikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725640432; x=1726245232;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6nSRREYuTQSGIk0jdG4fHbkHme8kt0KwwYjL/VuTDs=;
        b=bNTT+bPdSuWv9F7pE6lGVybj6eWRNMYLni7dGvIYs4uOdTKwI98/l98ffOnv8ZfAoj
         nnr52DQkT7n9nHmoKrWQ0c8WsvO+WJZ3W8vXN2DkzNGDj1kMWtpZA8k7dRSbMuD/s0pM
         VF9Lr6LrPozZ3LGptfhos4Ez1aCfflvVNuSPB4YZlUwwtvA5arF5vomlAWgNe+ilJEpE
         xjybe7ZZA3BzaEmXaKNZtv1Jym/7BHBZ1+HdseDV2F1cP7131q0/pLX3lFUbnWb/lADb
         2+MHCcqz2S+KPI7gZ3BKFSVwZ3YQCKG1tgkEhGyak/NSN7e+kjZuIwAwps4I8r5nfem3
         VDRg==
X-Gm-Message-State: AOJu0YzdBRMcAJDWK6x+gTooR7Ne9iAEyvBLilUCDkCLF3oDor6l+DZ5
	MLcLSwPEzJ78QfHGlQAkJjyRHFzPysaeU8xcjOwfS+LP5Atti7B0
X-Google-Smtp-Source: AGHT+IE+LnKz3sbMc7GCkruHYqAxQwDQWIRr7CS8hD6XFHd7x9QjL7DSJ1BN+Lwr5wld5Y70WNw8QQ==
X-Received: by 2002:a05:620a:170a:b0:7a7:fa7a:75f7 with SMTP id af79cd13be357-7a80426b39bmr3382291285a.51.1725640431801;
        Fri, 06 Sep 2024 09:33:51 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a99a293381sm50602385a.98.2024.09.06.09.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:33:51 -0700 (PDT)
Date: Fri, 06 Sep 2024 12:33:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <66db2eef2d90_29c8c329475@willemb.c.googlers.com.notmuch>
In-Reply-To: <66db1f004a0c_29a3852944d@willemb.c.googlers.com.notmuch>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-3-vadfed@meta.com>
 <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
 <66d9debb2d2ea_1eae1a2943d@willemb.c.googlers.com.notmuch>
 <bc6dcf94-bddb-4703-9451-21792378c45a@linux.dev>
 <66db1f004a0c_29a3852944d@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
> > On 05/09/2024 17:39, Willem de Bruijn wrote:
> > > Vadim Fedorenko wrote:
> > >> On 04/09/2024 12:31, Vadim Fedorenko wrote:
> > >>> TCP sockets have different flow for providing timestamp OPT_ID value.
> > >>> Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
> > >>>
> > >>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> > >>> ---
> > >>>    net/ipv4/tcp.c | 13 +++++++++----
> > >>>    1 file changed, 9 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > >>> index 8a5680b4e786..5553a8aeee80 100644
> > >>> --- a/net/ipv4/tcp.c
> > >>> +++ b/net/ipv4/tcp.c
> > >>> @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
> > >>>    }
> > >>>    EXPORT_SYMBOL(tcp_init_sock);
> > >>>    
> > >>> -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> > >>> +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
> > >>>    {
> > >>>    	struct sk_buff *skb = tcp_write_queue_tail(sk);
> > >>> +	u32 tsflags = sockc->tsflags;
> > >>>    
> > >>>    	if (tsflags && skb) {
> > >>>    		struct skb_shared_info *shinfo = skb_shinfo(skb);
> > >>> @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> > >>>    		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
> > >>>    		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> > >>>    			tcb->txstamp_ack = 1;
> > >>> -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> > >>> -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> > >>> +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> > >>> +			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
> > >>> +				shinfo->tskey = sockc->ts_opt_id;
> > >>> +			else
> > >>> +				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> > >>> +		}
> > >>>    	}
> > >>>    }
> > >>>    
> > >>> @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> > >>>    
> > >>>    out:
> > >>>    	if (copied) {
> > >>> -		tcp_tx_timestamp(sk, sockc.tsflags);
> > >>> +		tcp_tx_timestamp(sk, &sockc);
> > >>>    		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
> > >>>    	}
> > >>>    out_nopush:
> > >>
> > >> Hi Willem,
> > >>
> > >> Unfortunately, these changes are not enough to enable custom OPT_ID for
> > >> TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
> > >> flow:
> > >>
> > >> tcp_skb_collapse_tstamp()
> > >> tcp_fragment_tstamp()
> > >> tcp_gso_tstamp()
> > >>
> > >> I believe the last one breaks tests, but the problem is that there is no
> > >> easy way to provide the flag of constant tskey to it. Only
> > >> shinfo::tx_flags are available at the caller side and we have already
> > >> discussed that we shouldn't use the last bit of this field.
> > >>
> > >> So, how should we deal with the problem? Or is it better to postpone
> > >> support for TCP sockets in this case?
> > > 
> > > Are you sure that this is a problem. These functions pass on the
> > > skb_shinfo(skb)->ts_key from one skb to another.
> > 
> > Yes, you are right, the problem is in a different place.
> > 
> > __skb_complete_tx_timestamp receives skb with shinfo->tskey equal to
> > provided by cmsg. But for TCP sockets it unconditionally adjusts ee_data
> > value:
> > 
> > 	if (sk_is_tcp(sk))
> > 		serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
> > 
> > It happens because of assumption that for TCP sockets shinfo::tskey will
> > have sequence number and the logic has to recalculate it back to the
> > bytes sent. The same logic exists in all TCP TX timestamping functions
> > (mentioned in the previous mail) and may trigger some unexpected
> > behavior. To fix the issue we have to provide some kind of signal that
> > tskey value is provided from user-space and shouldn't be changed. And we
> > have to have it somewhere in skb info. Again, tx_flags looks like the
> > best candidate, but it's impossible to use. I'm thinking of using
> > special flag in tcp_skb_cb - gonna test more, but open for other
> > suggestions.
> 
> Ai, that is tricky. tx_flags is full/scarce indeed.
> 
> CB does not persist as the skb transitions between layers.

Though specifically for TCP, it is possible to look up the fast
clone on the rtx queue, whose tcp_skb_cb will be unperturbed. But
the tcb currently does not have this data either.

