Return-Path: <netdev+bounces-149308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FEA9E5157
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8085D188026F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CEC190477;
	Thu,  5 Dec 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOMJBsWa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2E818DF81
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391022; cv=none; b=HzOGhp1JtfusxqF5lxPZS6dlwEhUk1FLNkQll+KGE7v+A+8mNW8lZA3xcMWMKZgjzAqOp4nvgqTvhcc4rJo3Ah3IkUQ6iC2LHSuu63AeMy2xlVpfPB9zh9Jax9kyNNQLLvo7XiUGOshNWztIieBd1catPGNoOOpH7PjpWgLyBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391022; c=relaxed/simple;
	bh=NR040Na4ElTzgAf6uqIRVtedzUiCNdGM13uTpTED+7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SaynymEVX9ulyv5g86l+KWNqhSKp3Cq545lkqrpYbecFzelQ8Oj6mFUiMO71U1A4wp26J9w1eOBk9BHYx4mIj1ikmlyN7E3E7Y1JDzAE6d+17U95m4mgaXzwlqCGpmcwayZwXLWOaTgf8jsHF1/zuFizDFwUJASxigxvO7Hk0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOMJBsWa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733391019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//g6HKkuHCsIKaelKXi4Hr4QHnjTryAbrxrjnf5EBhw=;
	b=SOMJBsWao48Oaq2fL9jJKDXdp3119NynnYGKWUfLAGXAyxfvhBsqlwtP6kq9A2iLdB/g5X
	xrWYC9jyGNta9SO/gnVCNpfTS9L8TpiB+2drJ1ijGSiYcrOyT2RRlikH8eRTBZkcSlo/u4
	gOPD813a9M9BCbqjDph81GJScaLh0a0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-2H4VOJ0rPeOVCBxK69v13Q-1; Thu, 05 Dec 2024 04:30:18 -0500
X-MC-Unique: 2H4VOJ0rPeOVCBxK69v13Q-1
X-Mimecast-MFC-AGG-ID: 2H4VOJ0rPeOVCBxK69v13Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dc37cb3eso430471f8f.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 01:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391017; x=1733995817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//g6HKkuHCsIKaelKXi4Hr4QHnjTryAbrxrjnf5EBhw=;
        b=Qr1AIITBJL0wYS7i2PGQB408B1csFZ6lM4k8hpbJJOTYJoUqUMaCEFyvKsOaPZtCIX
         TOIrfQ8tU77046wPgIhzYQybFjiqHIh+q1YKY20MUXwtTONNSsBUWC96CSqgMNF+eAXz
         ux/a61qXjd8af4Owm52xJ60JE8ekWjKilu/3lrGEzpD87+gCM6MtbO8wLlbZRYLgeIAz
         5kvQZXEN/CPLMJShtWg78IUHsNhdk4vsBx+7LnaEp7BQMGavAgd+BUWMia9oaSEaEzm7
         BI85ZxAbR/UTFFtuw64XMGy9ltD9U/x+dUiP7C4RMbcWuanLBHqcSnuWoDtxmvGA61FY
         eYDg==
X-Forwarded-Encrypted: i=1; AJvYcCW/zCFGwynTwK4ZiA9cw3cd+05qYz+SfvBpEeVKHT+m0mBESAuiK8ftk4vs9EuusOAxhjlxTZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9plBbEAlGGEK+Nr/8QrcbUh5yB7D+EeqmvT17V65HqjWr3Knk
	oY17BSdpX7go8ad8J2465sX1/tS9TLEp0oFHSQsKA55mSSIjPVrDSkyTW6J15dimbBspZYip+iZ
	S+h/HM77a05FjoMMv48vF+VblIiGQTD2rPGpnIa87+hRp2ZaY5+pwQvyK4ajFkA==
X-Gm-Gg: ASbGncsRu0airrBOavWdZBwHj2wY1jAefgjOqxGns78eEspJRX8tOAIA98mUWrXZkM1
	5Qp4mctYH0v7yXWhal6UEbKEW+VIXxUlOasqhpm9SclFW82lqJOrVLjQuVLSuB9mP/bN91T4vLl
	tbzVkL9nEKuy2bWeUWVTvawLJFP6/h2Q+6kCfMEVJ8D0MP8WiMLyDAHUO580UCS3y12xyV4CRBw
	j1hWqnf6oqgpzCZ6erONT7pybuseryv6P5Q1ayM465Yw0gR5mBudgf0Jas1dnkZd68PUcOL/5oy
X-Received: by 2002:a05:6000:1fa3:b0:385:ec8d:8ca9 with SMTP id ffacd0b85a97d-385fd42a6c4mr7386999f8f.42.1733391017142;
        Thu, 05 Dec 2024 01:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe3eLbz5no4mbmVLofc0xSyd1ztetEorUqecaSNgr3GHNqJyrjUC6+th6e5LadzZ4zGKjccA==
X-Received: by 2002:a05:6000:1fa3:b0:385:ec8d:8ca9 with SMTP id ffacd0b85a97d-385fd42a6c4mr7386980f8f.42.1733391016708;
        Thu, 05 Dec 2024 01:30:16 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119a58sm17438645e9.41.2024.12.05.01.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:30:16 -0800 (PST)
Message-ID: <fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
Date: Thu, 5 Dec 2024 10:30:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
To: Stefano Brivio <sbrivio@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Holzinger <pholzing@redhat.com>, Philo Lu <lulie@linux.alibaba.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Fred Chen <fred.cc@alibaba-inc.com>,
 Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
 <20241204221254.3537932-3-sbrivio@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241204221254.3537932-3-sbrivio@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/4/24 23:12, Stefano Brivio wrote:
> If a UDP socket changes its local address while it's receiving
> datagrams, as a result of connect(), there is a period during which
> a lookup operation might fail to find it, after the address is changed
> but before the secondary hash (port and address) and the four-tuple
> hash (local and remote ports and addresses) are updated.
> 
> Secondary hash chains were introduced by commit 30fff9231fad ("udp:
> bind() optimisation") and, as a result, a rehash operation became
> needed to make a bound socket reachable again after a connect().
> 
> This operation was introduced by commit 719f835853a9 ("udp: add
> rehash on connect()") which isn't however a complete fix: the
> socket will be found once the rehashing completes, but not while
> it's pending.
> 
> This is noticeable with a socat(1) server in UDP4-LISTEN mode, and a
> client sending datagrams to it. After the server receives the first
> datagram (cf. _xioopen_ipdgram_listen()), it issues a connect() to
> the address of the sender, in order to set up a directed flow.
> 
> Now, if the client, running on a different CPU thread, happens to
> send a (subsequent) datagram while the server's socket changes its
> address, but is not rehashed yet, this will result in a failed
> lookup and a port unreachable error delivered to the client, as
> apparent from the following reproducer:
> 
>   LEN=$(($(cat /proc/sys/net/core/wmem_default) / 4))
>   dd if=/dev/urandom bs=1 count=${LEN} of=tmp.in
> 
>   while :; do
>   	taskset -c 1 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc &
>   	sleep 0.1 || sleep 1
>   	taskset -c 2 socat OPEN:tmp.in UDP4:localhost:1337,shut-null
>   	wait
>   done
> 
> where the client will eventually get ECONNREFUSED on a write()
> (typically the second or third one of a given iteration):
> 
>   2024/11/13 21:28:23 socat[46901] E write(6, 0x556db2e3c000, 8192): Connection refused
> 
> This issue was first observed as a seldom failure in Podman's tests
> checking UDP functionality while using pasta(1) to connect the
> container's network namespace, which leads us to a reproducer with
> the lookup error resulting in an ICMP packet on a tap device:
> 
>   LOCAL_ADDR="$(ip -j -4 addr show|jq -rM '.[] | .addr_info[0] | select(.scope == "global").local')"
> 
>   while :; do
>   	./pasta --config-net -p pasta.pcap -u 1337 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc &
>   	sleep 0.2 || sleep 1
>   	socat OPEN:tmp.in UDP4:${LOCAL_ADDR}:1337,shut-null
>   	wait
>   	cmp tmp.in tmp.out
>   done
> 
> Once this fails:
> 
>   tmp.in tmp.out differ: char 8193, line 29
> 
> we can finally have a look at what's going on:
> 
>   $ tshark -r pasta.pcap
>       1   0.000000           :: ? ff02::16     ICMPv6 110 Multicast Listener Report Message v2
>       2   0.168690 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>       3   0.168767 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>       4   0.168806 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>       5   0.168827 c6:47:05:8d:dc:04 ? Broadcast    ARP 42 Who has 88.198.0.161? Tell 88.198.0.164
>       6   0.168851 9a:55:9a:55:9a:55 ? c6:47:05:8d:dc:04 ARP 42 88.198.0.161 is at 9a:55:9a:55:9a:55
>       7   0.168875 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>       8   0.168896 88.198.0.164 ? 88.198.0.161 ICMP 590 Destination unreachable (Port unreachable)
>       9   0.168926 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>      10   0.168959 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
>      11   0.168989 88.198.0.161 ? 88.198.0.164 UDP 4138 60260 ? 1337 Len=4096
>      12   0.169010 88.198.0.161 ? 88.198.0.164 UDP 42 60260 ? 1337 Len=0
> 
> On the third datagram received, the network namespace of the container
> initiates an ARP lookup to deliver the ICMP message.
> 
> In another variant of this reproducer, starting the client with:
> 
>   strace -f pasta --config-net -u 1337 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc 2>strace.log &
> 
> and connecting to the socat server using a loopback address:
> 
>   socat OPEN:tmp.in UDP4:localhost:1337,shut-null
> 
> we can more clearly observe a sendmmsg() call failing after the
> first datagram is delivered:
> 
>   [pid 278012] connect(173, 0x7fff96c95fc0, 16) = 0
>   [...]
>   [pid 278012] recvmmsg(173, 0x7fff96c96020, 1024, MSG_DONTWAIT, NULL) = -1 EAGAIN (Resource temporarily unavailable)
>   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) = 1
>   [...]
>   [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) = -1 ECONNREFUSED (Connection refused)
> 
> and, somewhat confusingly, after a connect() on the same socket
> succeeded.
> 
> To fix this, replace the rehash operation by a set_rcv_saddr()
> callback holding the spinlock on the primary hash chain, just like
> the rehash operation used to do, but also setting the address (via
> inet_update_saddr(), moved to headers) while holding the spinlock.
> 
> To make this atomic against the lookup operation, also acquire the
> spinlock on the primary chain there.

I'm sorry for the late feedback.

I'm concerned by the unconditional spinlock in __udp4_lib_lookup(). I
fear it could cause performance regressions in different workloads:
heavy UDP unicast flow, or even TCP over UDP tunnel when the NIC
supports RX offload for the relevant UDP tunnel protocol.

In the first case there will be an additional atomic operation per packet.

In the latter the spin_lock will be contended with multiple concurrent
TCP over UDP tunnel flows: the NIC with UDP tunnel offload can use the
inner header to compute the RX hash, and use different rx queues for
such flows.

The GRO stage will perform UDP tunnel socket lookup and will contend the
bucket lock.

> This results in some awkwardness at a caller site, specifically
> sock_bindtoindex_locked(), where we really just need to rehash the
> socket without changing its address. With the new operation, we now
> need to forcibly set the current address again.
> 
> On the other hand, this appears more elegant than alternatives such
> as fetching the spinlock reference in ip4_datagram_connect() and
> ip6_datagram_conect(), and keeping the rehash operation around for
> a single user also seems a tad overkill.

Would such option require the same additional lock at lookup time?

Thanks,

Paolo


