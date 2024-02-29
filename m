Return-Path: <netdev+bounces-76086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B3686C457
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F911F26E88
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B8D55C33;
	Thu, 29 Feb 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPn6qUtD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DCE55784
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197009; cv=none; b=L8Np+aoMGG/tfY/3FdCKpakBbW34yIjDp2u2sOcEGIR1TP4h5i8FIErL/CZVDfh89sMczZwVlcDQcOhnF+oq68dZ5HduARSSXQix7YYtOTSuuW+NF+mxXlnC49gc8lK1HQF843FlOlrAkoCZp5HXjJRK+4ucZhPf0v7iBT5YU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197009; c=relaxed/simple;
	bh=FdvC11/eZzAyMYzqpjDlpVutrqerXQdVb485CxOvM2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTDbECK67Cy4nabZbvZhxe6GIwgC2A4yjMBGEQPYTithNnp9M7LyD7PeqCPiJHnmNGDAfpccAm2kQ3PmoEzwzbPRK6TOQL3ULg18VUwUSq8DdGU6NCJBxcuO5vSmqDo01DMHevp+jLPjDBqLlvkrYb2bE089rKtSP+p2n9vENno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPn6qUtD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412b99eb5cfso4235845e9.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709197006; x=1709801806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yekv/ue92PhQqAhL8fJLvaV2e/lstaTHVjkMEd1iTb8=;
        b=UPn6qUtDki5SL92fk2VWHmD5R1lvTKj7vc3QyCVHRO6vE2n5JTgEAwFTWwqC6tfUCK
         cqx1c/ncJjKWpUW4hMMO3LuQ+qthZwOiPgLvquekeiAuXQ0uP9VsWhqWhk/VhCnFF36U
         Y3WScb+KH8gVL1qc6YNhuCoD3R1wDe7pVyedaViiqTYTDiyuy0/7KsFCIwnurn4f2SXj
         X+EGEPgfODbk2lluCnYdmemBUq+i7qUl2YoKGpr1YothvDnrCp7PjjUbMkb7/zCm4FKS
         iWrG1wcV3ou3ffx4Hemzhk5Vq6pwI0zvAklrElDleA7pCIFcGTpdMhfkppCw7dnaObIR
         dqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709197006; x=1709801806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yekv/ue92PhQqAhL8fJLvaV2e/lstaTHVjkMEd1iTb8=;
        b=srysA4GgnAANeZ6jmcK5Qaw98v22mueBwAYpwU0qDLxvDzgxB17EAOzbYPdK2Bfyw1
         TQA4qKVuROhKhP1tr0VhyZND17sd/w7mA17hk8xFzeXbnxiSkM4+Ux/LfTLcXa9D1fCS
         Wi741yuqvP71AFul36fQpV3EeNJN6NwT7SDBMYy0Q0GUMedPq147O1YBehx6MyNg7DN3
         +NBt0hApxDOy6OT17BZRXv407bIKGiKRxFDGFFwbS8ptIwh+Wsevo6fkWz6oVW0Ihspg
         2pRmL5L5kc+M0XYmlXDQZSW6KrHHT8d72HlgvYhZbj4f+CRW9vhP2jLPtzVfgi2PZlqr
         wlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1UcBtTiCZxczGj3b+zTNSQbYw20htfRX/VBI4Qfl2Qs8vQbU0alvdTmt8V6D1mfIyhxxmtUJy6UIUw658D0fT0j6Eb30m
X-Gm-Message-State: AOJu0YxdyVJYnkHQmk2ZAZk1xUPEATa95lxyYfU5huSaIOBha339iEJ5
	/mtNZw9IdsVSxow7u6cLvgHldhRviVQr4VEJt+gSyrsCojusKYOBA4BJ6LxS
X-Google-Smtp-Source: AGHT+IECzV5bqlZJv3jt7c+sOJdiVvsiXSaNamBEfzWl0SoedFzpmHzccSNGX9WvR+KL/MPsCsYIDw==
X-Received: by 2002:a05:600c:4f43:b0:412:bcc1:44cc with SMTP id m3-20020a05600c4f4300b00412bcc144ccmr867914wmq.3.1709197006219;
        Thu, 29 Feb 2024 00:56:46 -0800 (PST)
Received: from bzorp2 (92-249-182-64.pool.digikabel.hu. [92.249.182.64])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b004127ead18aasm1440607wmb.22.2024.02.29.00.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:56:45 -0800 (PST)
Date: Thu, 29 Feb 2024 09:56:43 +0100
From: Balazs Scheidler <bazsi77@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: balazs.scheidler@axoflow.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: udp: add IP/port data to the
 tracepoint udp/udp_fail_queue_rcv_skb
Message-ID: <ZeBGy0Wt2rmR0j74@bzorp2>
References: <cb07bca5faf1fe3c3d4f7629cb45dbf2adb520cb.1709191570.git.balazs.scheidler@axoflow.com>
 <20240229082711.82153-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229082711.82153-1-kuniyu@amazon.com>

On Thu, Feb 29, 2024 at 12:27:11AM -0800, Kuniyuki Iwashima wrote:
> From: Balazs Scheidler <bazsi77@gmail.com>
> Date: Thu, 29 Feb 2024 08:38:00 +0100
> > The udp_fail_queue_rcv_skb() tracepoint lacks any details on the source
> > and destination IP/port whereas this information can be critical in case
> > of UDP/syslog.
> > 
> > Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
> > ---
> >  include/trace/events/udp.h | 33 +++++++++++++++++++++++++++++----
> >  net/ipv4/udp.c             |  2 +-
> >  net/ipv6/udp.c             |  3 ++-
> >  3 files changed, 32 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/trace/events/udp.h b/include/trace/events/udp.h
> > index 336fe272889f..cd4ae5c2fad7 100644
> > --- a/include/trace/events/udp.h
> > +++ b/include/trace/events/udp.h
> > @@ -7,24 +7,49 @@
> >  
> >  #include <linux/udp.h>
> >  #include <linux/tracepoint.h>
> > +#include <trace/events/net_probe_common.h>
> >  
> >  TRACE_EVENT(udp_fail_queue_rcv_skb,
> >  
> > -	TP_PROTO(int rc, struct sock *sk),
> > +	TP_PROTO(int rc, struct sock *sk, struct sk_buff *skb),
> >  
> > -	TP_ARGS(rc, sk),
> > +	TP_ARGS(rc, sk, skb),
> >  
> >  	TP_STRUCT__entry(
> >  		__field(int, rc)
> >  		__field(__u16, lport)
> > +
> > +		__field(__u16, sport)
> > +		__field(__u16, dport)
> 
> duplicating lport just for reusing TP_STORE_ADDR_PORTS_SKB() ?
> Then, I think we should define udp-specific macro.

I left "lport" in for compatibility with the previous users of the same
tracepoint.

The sk->inet_num can be different from the dport in the packet, for instance when 
TPROXY style redirects are done. In that case the TPROXY rule would look up
a socket and queue the incoming packet there, even if their port numbers
differ.

If I was adding this tracepoint now, I would probably skip the "lport"
value, I agree this is redundant. But there are other issues as well:

* I think that the name "lport" is confusing, all other tracepoints have saddr/daddr sport/dport.
* Sometimes address information is stored stored as separate fields (e.g.
  family, saddr/daddr, sport/dport), in other cases they are stored as "struct sockaddr"
  that bundles family, address/port information.

With that said, I could either go ahead and:

1) break tracepoint compatibility by removing lport completely
2) change the interpretation of lport and store the dport in that field
  (still incompatible, but would not break stuff), this would leave the
  confusing lport name.
3) retain lport and add the redundant fields (compatible at a cost of an
   extra u16 field)

I've chosen number 3) above, as it fully retains compatibility and sometimes
the extra lport field can come handy in case someone is using TPROXY with
UDP.

> 
> 
> > +		__field(__u16, family)
> > +		__array(__u8, saddr, sizeof(struct sockaddr_in6))
> > +		__array(__u8, daddr, sizeof(struct sockaddr_in6))
> >  	),
> >  
> >  	TP_fast_assign(
> > +		const struct inet_sock *inet = inet_sk(sk);
> > +		const struct udphdr *uh = (const struct udphdr *)udp_hdr(skb);
> > +		__be32 *p32;
> > +
> >  		__entry->rc = rc;
> > -		__entry->lport = inet_sk(sk)->inet_num;
> > +		__entry->lport = inet->inet_num;
> > +
> > +		__entry->sport = ntohs(uh->source);
> > +		__entry->dport = ntohs(uh->dest);
> > +		__entry->family = sk->sk_family;
> > +
> > +		p32 = (__be32 *) __entry->saddr;
> > +		*p32 = inet->inet_saddr;
> > +
> > +		p32 = (__be32 *) __entry->daddr;
> > +		*p32 =  inet->inet_daddr;
> 
> nit: double space here.

Thanks, I fixed this.

> 
> 
> > +
> > +		TP_STORE_ADDR_PORTS_SKB(__entry, skb, uh);
> >  	),
> >  
> > -	TP_printk("rc=%d port=%hu", __entry->rc, __entry->lport)
> > +	TP_printk("rc=%d port=%hu family=%s src=%pISpc dest=%pISpc", __entry->rc, __entry->lport,
> > +		  show_family_name(__entry->family),
> > +		  __entry->saddr, __entry->daddr)
> >  );
> >  
> >  #endif /* _TRACE_UDP_H */
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index a8acea17b4e5..d21a85257367 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -2051,8 +2051,8 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
> >  			drop_reason = SKB_DROP_REASON_PROTO_MEM;
> >  		}
> >  		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
> > +		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
> >  		kfree_skb_reason(skb, drop_reason);
> > -		trace_udp_fail_queue_rcv_skb(rc, sk);
> >  		return -1;
> >  	}
> >  
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index 3f2249b4cd5f..e5a52c4c934c 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/indirect_call_wrapper.h>
> > +#include <trace/events/udp.h>
> >  
> >  #include <net/addrconf.h>
> >  #include <net/ndisc.h>
> > @@ -661,8 +662,8 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
> >  			drop_reason = SKB_DROP_REASON_PROTO_MEM;
> >  		}
> >  		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
> > +		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
> >  		kfree_skb_reason(skb, drop_reason);
> > -		trace_udp_fail_queue_rcv_skb(rc, sk);
> >  		return -1;
> >  	}
> >  
> > -- 
> > 2.40.1

