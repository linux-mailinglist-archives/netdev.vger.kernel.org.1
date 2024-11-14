Return-Path: <netdev+bounces-144840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55DB9C885A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BF21F2166C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCBF1F77B0;
	Thu, 14 Nov 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYOJ5vcl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C81DB52A
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582285; cv=none; b=dGD0D+gFory1CBLxJJ4esnSE42ZOCftxQ1a1ChNOwsdmeFQyPm8tJEdmWU3rfDPMzx8W8jhnm1h1s7HOrM76tva9ECfBHBF753yHI47by1fjBeH2gXW3U1eQLOYNhvdJNCBx2ACrvtVmFNJgEmOXiSGdAqKRBB/6UWUMYuIKIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582285; c=relaxed/simple;
	bh=dsNycSwZ11jiY/w3rji+v7NsTwO/i5EEUmQUvcRvkOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bp4sqR4kKxYSki+wBQXJl6R3bPtfhsJMf2UP9Drw8Mm9v8nkW1I0a+KK6hjfs996B0Iwir1JY9x9lGsxxbvlBQEdowRT+byxjF0mYJx3Xvx9uuIS0/9jJUNSQ/JspIztERk+bBcSKjiGzhLAZrGI/jaTxRQ22YObvk5+6jPPI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYOJ5vcl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731582282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQU3SOw/FXl5GE6vGiclPFYdhlYdRmUL7RxA8z+lmf0=;
	b=MYOJ5vclMwRcx28BnJgOYo9/fUqinl0IgXyIsXzePAk/WcodllhYostLXvWcYnd4LqfFyH
	SBXaE1SE2Dncs/ktGgP5WdfhkB5J4IeWrzGBECSm0Gqr9xv499dkq6nkq7Gt1SaOr611e9
	CJIPbtJCLu97dEHZc604+Yl6vEZIOwA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-cSa4HOhvNlmt82CPORjrKg-1; Thu, 14 Nov 2024 06:04:41 -0500
X-MC-Unique: cSa4HOhvNlmt82CPORjrKg-1
X-Mimecast-MFC-AGG-ID: cSa4HOhvNlmt82CPORjrKg
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460ba8f6a5aso7827621cf.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 03:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582281; x=1732187081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQU3SOw/FXl5GE6vGiclPFYdhlYdRmUL7RxA8z+lmf0=;
        b=Nn3KpR0DvcdebEytUbY2t1t2IK49iKqm/dDLwoVI1hAJY+S+cn+qR+fzAFCJfJlSbR
         eFY1CnCbeENPQYKzje4eF9jnBTDQl+TLkeJsLgDwnjPDJKCWr07VrQPvCFxWf7yQbEHA
         ONqkv/NzJpg+8MdfxVKh8N3P6r9SKbAQwYYHb+1cuUtsVRSR9CSNrnuZCHifhyGw6u/E
         21qHZYroI4YKQxlofEDZ3npzDwYIYQ+TTvLkpQcq70QTiFE4EQJ+11eDn/3+6qXr/a85
         k0B3TE/bbvZfNFi6qdEx2avnwf4dwVfRFMp9TBigFey9ky/8DsgmLQ1rzg7yqCgnXvcz
         NO3A==
X-Forwarded-Encrypted: i=1; AJvYcCXiGqvAiQLSSxuXjkez8YOd0uCRPo43ltbIRdX6f9qYklBcW1byhdasI3034VygkufUsztTRlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRfAkAdnCuu2e1O73FXVivmzNjTrUX/Bd6KGD9MF75tQpgVnS
	8Is9FMIChdgZ9YMS4rmePVrAh4+80JxhUNfXX/b6qgYDzasD+8VetvS0MzvYVcg9EwNB9plwQGP
	f7m29s9qcSIoUeVZAs0D8jsXILag7hh1aKr+499W3BsM2wgmxmMjykQ==
X-Received: by 2002:a05:622a:2986:b0:461:4467:14c9 with SMTP id d75a77b69052e-46358ef3db8mr17568671cf.11.1731582280731;
        Thu, 14 Nov 2024 03:04:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoQa3Ws29+G9YE3E/8YxMlwk8yLpsI+YDp7+l/NMj8VegTIwpP139UXlvMHu41ocdP+fd2UA==
X-Received: by 2002:a05:622a:2986:b0:461:4467:14c9 with SMTP id d75a77b69052e-46358ef3db8mr17568351cf.11.1731582280374;
        Thu, 14 Nov 2024 03:04:40 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9c7ca9sm4175091cf.7.2024.11.14.03.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:04:39 -0800 (PST)
Message-ID: <9813fd57-1f0b-427f-aa47-e0486e6244fd@redhat.com>
Date: Thu, 14 Nov 2024 12:04:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/ipv6: release expired exception dst cached in
 socket
To: Jiri Wiesner <jwiesner@suse.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 yousaf.kaukab@suse.com, andreas.taschner@suse.com
References: <20241113105611.GA6723@incl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241113105611.GA6723@incl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 11:56, Jiri Wiesner wrote:
> Dst objects get leaked in ip6_negative_advice() when this function is
> executed for an expired IPv6 route located in the exception table. There
> are several conditions that must be fulfilled for the leak to occur:
> * an ICMPv6 packet indicating a change of the MTU for the path is received
> * a TCP connection that uses the exception dst for routing packets must
>   start timing out so that TCP begins retransmissions
> * after the exception dst expires, the FIB6 garbage collector must not run
>   before TCP executes ip6_negative_advice() for the expired exception dst
> 
> The following steps reproduce the issue:
> 
> ip link add veth1 mtu 65535 type veth peer veth0 mtu 65535
> ip netns add ns0
> ip link set veth1 netns ns0
> ip addr add fd00::1/24 dev veth0
> ip -n ns0 addr add fd00::2/24 dev veth1
> ip link set up dev veth0
> ip -n ns0 link set up dev lo
> ip -n ns0 link set up dev veth1
> ip -n ns0 route add default via fd00::1 dev veth1
> 
> ip link add veth3 mtu 65535 type veth peer veth2 mtu 65535
> ip netns add ns2
> ip link set veth3 netns ns2
> ip addr add fd02::1/24 dev veth2
> ip -n ns2 addr add fd02::2/24 dev veth3
> ip link set up dev veth2
> ip -n ns2 link set up dev lo
> ip -n ns2 link set up dev veth3
> ip -n ns2 route add default via fd02::1 dev veth3
> 
> ip netns exec ns0 bash -c "echo 6 > /proc/sys/net/ipv6/route/mtu_expires"
> ip netns exec ns0 bash -c "echo 900 > /proc/sys/net/ipv6/route/gc_interval"
> sleep 30
> 
> ip6tables -A FORWARD -i veth0 -d fd02::/24 -j ACCEPT
> ip6tables -A FORWARD -i veth2 -d fd00::/24 -j ACCEPT
> echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
> 
> (ip netns exec ns2 netcat -6 -l -s fd02::2 -p 1234 &> /dev/null) & serv=$!
> sleep 1
> dd if=/dev/zero bs=1M | ip netns exec ns0 netcat -6 fd02::2 1234 & clnt=$!
> sleep 1
> ip link set veth2 mtu 2000
> sleep 1
> ip6tables -D FORWARD -i veth2 -d fd00::/24 -j ACCEPT
> ip6tables -A FORWARD -i veth2 -d fd00::/24 -j DROP
> 
> sleep 10
> kill $clnt $serv
> wait $serv
> 
> ip6tables -D FORWARD -i veth0 -d fd02::/24 -j ACCEPT
> ip6tables -D FORWARD -i veth2 -d fd00::/24 -j DROP
> 
> ip -n ns0 link set down dev lo
> ip -n ns0 link set down dev veth1
> ip -n ns0 link delete dev veth1
> ip netns delete ns0
> 
> ip -n ns2 link set down dev lo
> ip -n ns2 link set down dev veth3
> ip -n ns2 link delete dev veth3
> ip netns delete ns2
> 
> This trace has been created with kprobes under kernel 6.12-rc7. Upon
> receiving an ICMPv6 packet indicating an MTU change, exception dst
> 0xff3027eec766c100 is created and inserted into the IPv6 exception table:
> 3651.126884: rt6_insert_exception: (rt6_insert_exception+0x0/0x2b0) dst=0xff3027eec766c100 rcuref=0
> 3651.126889: <stack trace>
>  => rt6_insert_exception+0x5/0x2b0
>  => __ip6_rt_update_pmtu+0x1ef/0x380
>  => inet6_csk_update_pmtu+0x4b/0x90
>  => tcp_v6_mtu_reduced.part.22+0x34/0xc0
> The exception dst is used to route packets:
> 3651.126902: inet6_csk_route_socket: (inet6_csk_update_pmtu+0x58/0x90 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> At this point, the connection has been severed and TCP starts retransmissions:
> 3652.349466: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> 3652.349497: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> 3652.769469: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> 3652.769495: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> 3653.596135: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> 3653.596156: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> 3655.249465: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> 3655.249490: inet6_csk_route_socket: (inet6_csk_xmit+0x56/0x130 <- inet6_csk_route_socket) dst=0xff3027eec766c100
> 3658.689463: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80
> When ip6_negative_advice() is executed the refcount is 2 - the increment
> made by dst_init() and the increment made by the socket:
> 3658.689475: ip6_negative_advice: (ip6_negative_advice+0x0/0xa0) net=0xff3027ef4a0f3780 sk=0xff3027eeeb1f3d80 dst=0xff3027eec766c100 rcuref=1
> This is the result of dst_hold() and sk_dst_reset() in ip6_negative_advice():
> 3658.689477: dst_release: (dst_release+0x0/0x80) dst=0xff3027eec766c100 rcuref=2
> 3658.689498: rt6_remove_exception_rt: (rt6_remove_exception_rt+0x0/0xa0) dst=0xff3027eec766c100 rcuref=1
> 3658.689501: rt6_remove_exception: (rt6_remove_exception.part.58+0x0/0xe0) dst=0xff3027eec766c100 rcuref=1
> The refcount of dst 0xff3027eec766c100 is decremented by 1 as a result of
> removing the exception from the exception table with
> rt6_remove_exception_rt():
> 3658.689505: dst_release: (dst_release+0x0/0x80) dst=0xff3027eec766c100 rcuref=1
> The retransmissions continue without the exception dst being used for
> routing packets:
> 3662.352796: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef00cab780 sk=0xff3027eeeb1f0000
> 3662.769470: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef00cab780 sk=0xff3027eeeb1f0000
> 3663.596132: tcp_retransmit_timer: (tcp_retransmit_timer+0x0/0xba0) net=0xff3027ef00cab780 sk=0xff3027eeeb1f0000
> 
> The ip6_dst_destroy() function was instrumented but there was no entry for
> dst 0xff3027eec766c100 in the trace even long after the ns0 and ns2 net
> namespaces had been destroyed. The refcount made by the socket was never
> released. The refcount of the dst is decremented in sk_dst_reset() but
> that decrement is counteracted by a dst_hold() intentionally placed just
> before the sk_dst_reset() in ip6_negative_advice(). The probem is that
> sockets that keep a reference to a dst in the sk_dst_cache member
> increment the refcount of the dst by 1. This is apparent in the following
> code paths:
> * When ip6_route_output_flags() finds a dst that is then stored in
>   sk->sk_dst_cache by ip6_dst_store() called from inet6_csk_route_socket()
> * When inet_sock_destruct() calls dst_release() for sk->sk_dst_cache
> Provided the dst is not kept in the sk_dst_cache member of another socket,
> there is no other object tied to the dst (the socket lost its reference
> and the dst is no longer in the exception table) and the dst becomes a
> leaked object after ip6_negative_advice() has finished.
> 
> As a result of this dst leak, an unbalanced refcount is reported for the
> loopback device of a net namespace being destroyed under kernels that do
> not contain e5f80fcf869a ("ipv6: give an IPv6 dev to blackhole_netdev"):
> unregister_netdevice: waiting for lo to become free. Usage count = 2
> 
> Fix the dst leak by removing the dst_hold() in ip6_negative_advice(). The
> patch that introduced the dst_hold() in ip6_negative_advice() was
> 92f1655aa2b22 ("net: fix __dst_negative_advice() race"). But 92f1655aa2b22
> merely refactored the code with regards to the dst refcount so the issue
> was present even before 92f1655aa2b22. The bug was introduced in
> 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually
> expired.") where the expired cached route is deleted, the sk_dst_cache
> member of the socket is set to NULL by calling dst_negative_advice() but
> the refcount belonging to the socket is left unbalanced.
> 
> The IPv4 version - ipv4_negative_advice() - is not affected by this bug. A
> nexthop exception is created and the dst associated with the socket fails
> a check after the ICMPv6 packet indicating an MTU change has been
> received. When the TCP connection times out ipv4_negative_advice() merely
> resets the sk_dst_cache of the socket while decrementing the refcount of
> the exception dst. Then, the expired nexthop exception is deleted along
> with its routes in find_exception() while TCP tries to retransmit the same
> packet again.
> 
> Fixes: 92f1655aa2b22 ("net: fix __dst_negative_advice() race")
> Fixes: 54c1a859efd9f ("ipv6: Don't drop cache route entry unless timer actually expired.")
> 
> Signed-off-by: Jiri Wiesner <jwiesner@suse.de>

The patch makes sense to me, but the changelog is very hard to follow,
please:
- move the testing code to a new, specific self-tests (possibly tuning
the timeouts to a [much] shorter runtime)
- clearly separate the probe logs from the describing commenting text
- try to be slightly a bit less verbose

Additionally please solve a formal problem above: there should be no
white lines in the tag area between the Fixes and SoB tags.

Thanks,

Paolo


