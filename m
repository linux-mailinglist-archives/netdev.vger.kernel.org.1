Return-Path: <netdev+bounces-125625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C6796DFF3
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7341C23316
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0266A1428F3;
	Thu,  5 Sep 2024 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd+GIhf6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77D17BD6
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554366; cv=none; b=Mv5qg4f91p6g/lMlwqkWY6xiDjr4wNj9PnIfer8ZZZlB1c/sQLZ6TTjmlEH4vBIrwkQBYuM/ytRXTxKOgzCl+4v47FUJD5NOC+0aOd/vVEhRvA4aZb9p+jCDbVwCDKSEwksgogmD1ZNE9j2Hgn89pWJi3hBPl1NDh9ZDDM0tkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554366; c=relaxed/simple;
	bh=8RBBkLoM+CcMz6UirzJP9tdj75tg5CxIYm5wWYO69Ic=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=k2smV3gxmSLPl+cmSWSJg44hdKVZjFJu6PldPEslfpSoFawhh0jb0Ywfat1OjcyJu5tMbzPK0z6kh9RJXH7iktTAf/HQzMMmJu+A8tv4O6P6bDALbvIv4CQ44QYbiOlTsSwgz9GSINZjbyvP+oDyKBESYOsbr7emhzeBeFXIpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd+GIhf6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a81309072dso70525485a.0
        for <netdev@vger.kernel.org>; Thu, 05 Sep 2024 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725554364; x=1726159164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Igqmm4acymidaqOyMk4EbR+Za/uRj/PTHpqyEoY7jmI=;
        b=Wd+GIhf6PAvqgYjM84u7MQog7hsfbsHzi/XsOBXDn/J/6XzT7cybKovDFVBx4+SEdy
         wGK6BwP4koIq2+aEQUHk5jFzFPfjaaBVVnL1n2OkV32xat2MC5V1TSMAus4E65NIaVj4
         6NqPcEkKMYR0TEEBHEq1Zg3SS3CSqcK8Uu6h9Un1dz50uzz/HleqG+VM/5TyqN7zvgMa
         2gZA+l6I3jRVbAmq9DCdotA4Tbmxboq0UHfpe8YcmXbyBh0hT0+dQj3CLy4T85fv2FBZ
         Y+aLqxnsqv+xkDOUIV4BS9OaWf/o1cRnXD3VbdTqptDHXpBvMomzQDDYNtgx7Z/8NKxN
         HAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554364; x=1726159164;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Igqmm4acymidaqOyMk4EbR+Za/uRj/PTHpqyEoY7jmI=;
        b=iWMjYgbr+ZnlMcby/EP5Qlybqt3uhuloHLDeavXdnoa5pbvIIXWHZoiN45JC7P2QsX
         NwSiry5vkmF8isRbmowxpGZHS649+BkXjg1lJE0X4+NlltInnSv8N2StP6e6PUDuSgbT
         PapE3gTgKEouFoTApL4k/QbRthlCP+cM7XG8awjUndWZDqYm+cS2CcYPQtc1VrTd5Wzk
         NYzeFSrHTQ1J30EQ8/duuqkDJDWvFa48mWu4XyJOiCDVeCd8ksP+jIsDfUftyJm1r60N
         7zFHoJcvvSQCZxTKo9A8yoq6ch+pecbk953ZWK7DSbmTM5pSyXGzHe89C5S0TzNYtkbo
         KQ5Q==
X-Gm-Message-State: AOJu0Yy/3Srr149WGnK8afnNsbU7v3VOCKmz92kfr8XObgTX3a8GssMl
	WF/wClWdfkiHJegzrFglIs6lwZAVnPFyTqS0mTgR7kzUAYj5+vI1
X-Google-Smtp-Source: AGHT+IEL6zDzdfnRCgB5U94hiwUqxEiQTkF4ILXBFS57xMsXCMapZhKC5ItIpEecC0VMUA0vgL3bzA==
X-Received: by 2002:a05:620a:370c:b0:79e:f878:2640 with SMTP id af79cd13be357-7a8f6b75dddmr1959302885a.7.1725554364227;
        Thu, 05 Sep 2024 09:39:24 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98ef3a9b5sm88590285a.48.2024.09.05.09.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:39:23 -0700 (PDT)
Date: Thu, 05 Sep 2024 12:39:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <66d9debb2d2ea_1eae1a2943d@willemb.c.googlers.com.notmuch>
In-Reply-To: <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
References: <20240904113153.2196238-1-vadfed@meta.com>
 <20240904113153.2196238-3-vadfed@meta.com>
 <3e4add99-6b57-4fe1-9ee1-519c80cf7cf5@linux.dev>
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
> On 04/09/2024 12:31, Vadim Fedorenko wrote:
> > TCP sockets have different flow for providing timestamp OPT_ID value.
> > Adjust the code to support SCM_TS_OPT_ID option for TCP sockets.
> > 
> > Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> > ---
> >   net/ipv4/tcp.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 8a5680b4e786..5553a8aeee80 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -474,9 +474,10 @@ void tcp_init_sock(struct sock *sk)
> >   }
> >   EXPORT_SYMBOL(tcp_init_sock);
> >   
> > -static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> > +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
> >   {
> >   	struct sk_buff *skb = tcp_write_queue_tail(sk);
> > +	u32 tsflags = sockc->tsflags;
> >   
> >   	if (tsflags && skb) {
> >   		struct skb_shared_info *shinfo = skb_shinfo(skb);
> > @@ -485,8 +486,12 @@ static void tcp_tx_timestamp(struct sock *sk, u16 tsflags)
> >   		sock_tx_timestamp(sk, tsflags, &shinfo->tx_flags);
> >   		if (tsflags & SOF_TIMESTAMPING_TX_ACK)
> >   			tcb->txstamp_ack = 1;
> > -		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
> > -			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> > +		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK) {
> > +			if (tsflags & SOCKCM_FLAG_TS_OPT_ID)
> > +				shinfo->tskey = sockc->ts_opt_id;
> > +			else
> > +				shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
> > +		}
> >   	}
> >   }
> >   
> > @@ -1318,7 +1323,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
> >   
> >   out:
> >   	if (copied) {
> > -		tcp_tx_timestamp(sk, sockc.tsflags);
> > +		tcp_tx_timestamp(sk, &sockc);
> >   		tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
> >   	}
> >   out_nopush:
> 
> Hi Willem,
> 
> Unfortunately, these changes are not enough to enable custom OPT_ID for
> TCP sockets. There are some functions which rewrite shinfo->tskey in TCP
> flow:
> 
> tcp_skb_collapse_tstamp()
> tcp_fragment_tstamp()
> tcp_gso_tstamp()
> 
> I believe the last one breaks tests, but the problem is that there is no
> easy way to provide the flag of constant tskey to it. Only
> shinfo::tx_flags are available at the caller side and we have already
> discussed that we shouldn't use the last bit of this field.
> 
> So, how should we deal with the problem? Or is it better to postpone
> support for TCP sockets in this case?

Are you sure that this is a problem. These functions pass on the
skb_shinfo(skb)->ts_key from one skb to another.

As long as tcp_tx_timestamp sets the skb_shinfo(skb)->ts_key of the
original skb correctly, either from the cmsg or sk_tskey, then I don't
immediate see how this passing on from one skb to another would break
the intent.


