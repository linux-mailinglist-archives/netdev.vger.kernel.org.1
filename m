Return-Path: <netdev+bounces-192608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAE8AC07E9
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FECA3A45DF
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B6287505;
	Thu, 22 May 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plt04XWp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD206287509
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904156; cv=none; b=P20Ev/SMzy3hM6vSFye+qw13PTezaN0S5rm7goPxmy6CODh9ntaoHLHGKMInFVQqw8VmM0vyvNwXNHGawILgfLUquOp3ayn7tlKk2jtIgw5/EbjE4gtAYJEoNJuyDGCDfqAMQcPgajvMBks7hkkEDztWZ0P563KBurWxaCledVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904156; c=relaxed/simple;
	bh=4ASId0JH+VWWZL3IFUBP1dU99/1eNzfiw9x3qfiCG40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVT1/yVRLlmINuwvXxJfjoxJtL+kgsRN/AkmJq8dV3PKh3bD+OVBGUfApcVGGdv2nqY/ha5D3HvSw8YE1m1fNMtxkL2mEihHWAmRQ+3wDr21JyI4vHhpoeWWiXdRVJcN6tbyikJeM1Bn4cz8d0cprPD5HknE6E7wEaVMe5AgHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Plt04XWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747904153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=;
	b=Plt04XWpD0bB8dXYd4QoNbQDF4AgWT6uIaeogpiXA9rEz52Hh5ep5OgQKVWcixMJ/+f/zW
	du/U3k/x5CODoR/41rwec+6SabIIeWnx/QMuATan/L+mZFg65/F4C33pizSenqVh7wewL8
	fFgU5gEOFQBoBZ8MMYY5JIZO146pjp8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-KnrS4QOQO_2pEfs9r5-Uiw-1; Thu, 22 May 2025 04:55:52 -0400
X-MC-Unique: KnrS4QOQO_2pEfs9r5-Uiw-1
X-Mimecast-MFC-AGG-ID: KnrS4QOQO_2pEfs9r5-Uiw_1747904151
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so41769225e9.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747904151; x=1748508951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pino5Ai5bwBqjPAZpAdwxhzTr0aiQB3uDnJ8famwHw=;
        b=V3VC2+pBuuawWQ0ouHIONGF+9Q8CaniZeWz9nnoTAmV6DcQJ+TETPCzixBl2Z/1zB3
         GZs7q7l6mybicCJhePdZpMTlitlNPAQ1WL3KkwJO/dtO/D5nKuiGqSuWYzc56Rg8ScfG
         SAM5knMuBfw+fg1BKcU9IXjsmEva3X0y4KjbQNx1xvWKKaqrCfaxIsE2kwzrnPiKF/HY
         JxHsuNpakr1ljdUma+4XtzM2ME3e0Uf4OZ3qXwV2KwH6/Yeta0h0buuWOCabAXfrQUWq
         aqOqhCd5pAo4XFrM+MN6zvd71jKFHD+0Of1NyY60BGx4Zh1gxI41pseitM1HbuApYNHf
         eZPg==
X-Forwarded-Encrypted: i=1; AJvYcCWMrkvyE1fxriDCj+3SlNCrK4IY7B7a8K5il3NMEJ1Xp2TmXIFRf0NnuOD0X9uRgIDTzxEwn8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJ93MbQDA2d2W9tTzyr7SD0LYK/YCBU8ykRkqx09YrDjgiPqS
	rgT6w5f4oY7zgOVutTYlLj0cEmuHDErt9MvavU7gaqLCy2QIad/CB7AoAOpmR+vV9EyHYCuBxzo
	kP3KAdSmFFwAmQ7PLV4INt1b11FR5XJLoTCUvKji1cClhsxNjSjKfmZ8R6g==
X-Gm-Gg: ASbGncsmBGn+cqq7Ts6JrSl2LDNoAn1V47uomume2G4Yi0wUEgiwrlrWLN0NgVybjC9
	KHYgF2WJ+6ka1+PB3pw29ZqXfvTXKEg3ikg37CLePQodr7QeiYcw12J0kjvWkaJWcC6snP9uyJH
	cgRobjlpo1aAyE9FB1KsgqN3adjRAY7iQcIhjP0g8g20iX9kX/39evr/96fER5VdUcxZbnrIihv
	ZiGkRVtuYoDaLOYoxA9PoQw8q1GnGayWxAuSVbPSeihgN7+LeTMZy4GhyTj8mcELDdHhe9KS1vZ
	Uki2V9tdEC7a4Rxh+EU=
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr174238785e9.13.1747904150767;
        Thu, 22 May 2025 01:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZZWLfHYdYPfwzdbwFycNAp7aliAoZubbXRRwKwS5IPvqLZEKoM1L6RvMRd6G8MB4cd63apg==
X-Received: by 2002:a05:600c:c1c8:10b0:441:d228:3a07 with SMTP id 5b1f17b1804b1-442f8524304mr174238455e9.13.1747904150355;
        Thu, 22 May 2025 01:55:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d3d6csm99616195e9.19.2025.05.22.01.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 01:55:49 -0700 (PDT)
Message-ID: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
Date: Thu, 22 May 2025 10:55:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket conversion
 except for net/rds/.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Matthieu Baerts <matttbe@kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20250517035120.55560-1-kuniyu@amazon.com>
 <20250517035120.55560-5-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250517035120.55560-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/25 5:50 AM, Kuniyuki Iwashima wrote:
> Since commit 26abe14379f8 ("net: Modify sk_alloc to not reference
> count the netns of kernel sockets."), TCP kernel socket has caused
> many UAF.
> 
> We have converted such sockets to hold netns refcnt, and we have
> the same pattern in cifs, mptcp, nvme, rds, smc, and sunrpc.
> 
>   __sock_create_kern(..., &sock);
>   sk_net_refcnt_upgrade(sock->sk);
> 
> Let's drop the conversion and use sock_create_kern() instead.
> 
> The changes for cifs, mptcp, nvme, and smc are straightforward.
> 
> For sunrpc, we call sock_create_net() for IPPROTO_TCP only and still
> call __sock_create_kern() for others.
> 
> For rds, we cannot drop sk_net_refcnt_upgrade() for accept()ed
> sockets.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

This LGTM, but is touching a few other subsystems, it would be great to
collect acks from the relevant maintainers: I'm adding a few CCs.

Direct link to the series:

https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t

> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index 37a2ba38f10e..c7b4f5a7cca1 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -3348,21 +3348,14 @@ generic_ip_connect(struct TCP_Server_Info *server)
>  		socket = server->ssocket;
>  	} else {
>  		struct net *net = cifs_net_ns(server);
> -		struct sock *sk;
>  
> -		rc = __sock_create_kern(net, sfamily, SOCK_STREAM,
> -					IPPROTO_TCP, &server->ssocket);
> +		rc = sock_create_kern(net, sfamily, SOCK_STREAM,
> +				      IPPROTO_TCP, &server->ssocket);
>  		if (rc < 0) {
>  			cifs_server_dbg(VFS, "Error %d creating socket\n", rc);
>  			return rc;
>  		}
>  
> -		sk = server->ssocket->sk;
> -		__netns_tracker_free(net, &sk->ns_tracker, false);
> -		sk->sk_net_refcnt = 1;
> -		get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
> -		sock_inuse_add(net, 1);

AFAICS the above implicitly adds a missing net_passive_dec(net), which
in turns looks like a separate bugfix. What about adding a separate
patch introducing that line? Could be in the same series to simplify the
processing.

Thanks,

Paolo


