Return-Path: <netdev+bounces-158263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A72A11423
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B363A2D6A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617CF20F090;
	Tue, 14 Jan 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a95wM3jS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900632139AF
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893961; cv=none; b=GcgtGMUJ4HxH8MjzEo+PyVBxGympzA5dB/+ci+sLXMAd74DeGEKmys5MAcGnA33MnbxD+9CHQIfNKP9obM7MhU5lrYJ3yrrc0BGG8KVk0lq3ANWGDrSABiQNek7yjTSEvUZgzBwjj3JVO/Kwd3SQgudYSne3Ae//dc/nmsQho+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893961; c=relaxed/simple;
	bh=No1AcZLmMDHHDap7hoIvBaYgEv6potLO0+VvXeobTsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpK5+vKfHoqHx/ZLXPANqG38uVtp9O4sBREda13HA8vaTIIPvk3l6sAjwpYsuShVEtYfBqK99E23SP2Pj12ieHHOWWIBYpD98sEpvbiw8jlLrSSSGG6ZhAzFHBg+TiZlzDMTq5yyCEkAdemGh7buwAKtvIY1d0UaEBroubh8czo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a95wM3jS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736893958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXzL1vV65DpnrZV/iKoCOHsa84AKRcCUDSn/2FoDiIY=;
	b=a95wM3jSjZgeShX4RYw7onkumT8ZjKJswA8xoGGzdtLmAJ5d30Wk8eTrezbFR5p1iDOgWO
	BPOkhvaGKz4kNppxLzCmdaJcdjOX7reLAE2vC5DX/ZH6gHJJOQqqnpfruTLRrHYQoCB+n3
	USp2AqDkK0bu5zaLtTZiglnhbgOMokk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-uwJPwayOMUKmledNwlkXvw-1; Tue, 14 Jan 2025 17:32:37 -0500
X-MC-Unique: uwJPwayOMUKmledNwlkXvw-1
X-Mimecast-MFC-AGG-ID: uwJPwayOMUKmledNwlkXvw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e27c5949so3413112f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736893956; x=1737498756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXzL1vV65DpnrZV/iKoCOHsa84AKRcCUDSn/2FoDiIY=;
        b=GjrvOMFiJdQ0de/6z7HBTwwr+05JUqHNuHe1Vx2nAnf8dk9V19rBty3uFXWc5qLCrD
         +WQ2wlLzNHOmhoQmPstPd5pUXy79rl9tFouon1tAAXE8tzvk/jo+rXLWUt0Rr6lxJugP
         lKwSvZEI5nGdhaEHzihP6sNP4n36OwuQy12sUPk1ZvZOontAgJMgBzbvDssrRMttbqeN
         myCvBdXvcNp0lQ0KO4ne879Oh3geB4wp6ZqmKP5oUc+VjccIFU6/uh7NmUCrA01vzQC/
         ZbfTDuiftRewZf2pMVttbsmJTsDG/xsrrOQO5JfAir/EiDVoeOnVOlbcVkrFzK/+pZYa
         WPuA==
X-Forwarded-Encrypted: i=1; AJvYcCUNo1ZLR3sgVA1LxOFVbg4H4wwaZt7BfnSsjL+Kr4OdIVdKrTA5M+dbcmzc4afnOq3bNxlJLac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmG3i0hIv9oNnw6Y9tPzlLWc1Icbby8KcdqPtBIpWNa0a2hgcB
	8w7kOMzykwLk18WUTvHWJCLRJaSHs5b4OGCkeq+kZSKaqfFYF6vuCjpMjDsw7mfDDkz5WY25GzM
	IauXakVmCFQYNoh/95RmTjkxts7g8EWSUwKLyS4zQ+x60ckKvUvmSUw==
X-Gm-Gg: ASbGncuMXsZlQOknYRT3Rrboxa8yatiiwLr5ooOY6/EXWdk/PPPtJUiMVLAuJ2y+TZh
	SLSwOdvWzRZI4h68/KY5R/juSoq9HGJ1w6igmIu5JP6kbsHXMWSybku9UPD880hqoVAbPfS/j3A
	Lt4LT6QCZVaH79Sx04tuPWmiiDecXPKalj74R3q9naUL4T+dek5udE/qsUu4JraRzYHAY/GpTzH
	vp5EJD6gj7Vhj8bHPyrIK4CHKCOQG7DKpEEUFOvIwHRrtbUmyv7Q6+odCCZu2DFcl5cDgTVFwyA
	LvQ3KFvAk8dOGRjf5DGe+5KeqRj/Iu+LYTw=
X-Received: by 2002:a5d:64a3:0:b0:386:3e0f:944b with SMTP id ffacd0b85a97d-38a8730fbd5mr22356138f8f.37.1736893955991;
        Tue, 14 Jan 2025 14:32:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIoP1HwW0/t+OHdp8+LpDOPhCQg7yQw88zYxN5SmOWMYjCVPKr8ZggLKfsAsyhkm6mkTIw3g==
X-Received: by 2002:a5d:64a3:0:b0:386:3e0f:944b with SMTP id ffacd0b85a97d-38a8730fbd5mr22356124f8f.37.1736893955605;
        Tue, 14 Jan 2025 14:32:35 -0800 (PST)
Received: from debian (2a01cb058d23d60010f10d4cace4e3dd.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:10f1:d4c:ace4:e3dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383965sm16244784f8f.31.2025.01.14.14.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:32:35 -0800 (PST)
Date: Tue, 14 Jan 2025 23:32:33 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, dccp@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] dccp: Prepare dccp_v4_route_skb() to
 .flowi4_tos conversion.
Message-ID: <Z4bmAVVyf4Z9VyRc@debian>
References: <ed399406a6ffad5097fa618c3bc7a4ac59546c62.1736869543.git.gnault@redhat.com>
 <CANn89iJQus-pqLta39df06DJLES8KgytN5iaVz9xv_HAz3F6Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJQus-pqLta39df06DJLES8KgytN5iaVz9xv_HAz3F6Vw@mail.gmail.com>

On Tue, Jan 14, 2025 at 06:43:15PM +0100, Eric Dumazet wrote:
> On Tue, Jan 14, 2025 at 4:46 PM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > Use inet_sk_dscp() to get the socket DSCP value as dscp_t, instead of
> > ip_sock_rt_tos() which returns a __u8. This will ease the conversion
> > of fl4->flowi4_tos to dscp_t, as it will just require to drop the
> > inet_dscp_to_dsfield() call.
> >
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > ---
> >  net/dccp/ipv4.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> > index 5926159a6f20..9e64dbd38cd7 100644
> > --- a/net/dccp/ipv4.c
> > +++ b/net/dccp/ipv4.c
> > @@ -15,6 +15,7 @@
> >
> >  #include <net/icmp.h>
> >  #include <net/inet_common.h>
> > +#include <net/inet_dscp.h>
> >  #include <net/inet_hashtables.h>
> >  #include <net/inet_sock.h>
> >  #include <net/protocol.h>
> > @@ -473,7 +474,7 @@ static struct dst_entry* dccp_v4_route_skb(struct net *net, struct sock *sk,
> >                 .flowi4_oif = inet_iif(skb),
> >                 .daddr = iph->saddr,
> >                 .saddr = iph->daddr,
> > -               .flowi4_tos = ip_sock_rt_tos(sk),
> > +               .flowi4_tos = inet_dscp_to_dsfield(inet_sk_dscp((inet_sk(sk)))),
> 
> You probably can replace ((X)) with (X) ?
> ->
>  .flowi4_tos = inet_dscp_to_dsfield(inet_sk_dscp(inet_sk(sk))),

Indeed, I'll change that in v2.

> >                 .flowi4_scope = ip_sock_rt_scope(sk),
> >                 .flowi4_proto = sk->sk_protocol,
> >                 .fl4_sport = dccp_hdr(skb)->dccph_dport,
> > --
> > 2.39.2
> >
> 


