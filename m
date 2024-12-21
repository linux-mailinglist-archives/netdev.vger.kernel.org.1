Return-Path: <netdev+bounces-153931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F89FA15E
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E844116953B
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCA81FBCBC;
	Sat, 21 Dec 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbDNDmjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0531BCA0F
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734794660; cv=none; b=VAq1Whl+0mgyOw7mbGc8lCwF0cuhCfzOkhk7W1Q3uOvHk4UEE7TUXjgcfVGiPtlD1hiVZlos9A8KQTo1NyF6FwAzNekzC7NYBHlDbZ1uwfQ133kE4JHZLWRqn4ZT/x2T+NAY0XKLh5qGCsHTnrjBoN4dhhggGwT07kb0QHwNnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734794660; c=relaxed/simple;
	bh=fVq98Xn/g2lgdwucnTysDoO8VZHg/EyhqEFe4DyjdYM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gqNMozCEyBti68naLqjUOeO+tswBVNgZPm17q0y1NqtdTwDYjORQ2aCctVhR4afDQ+z11+UTwyDr0BH5YsHEdommSw6vo7dFD8II4hHQHcPlEmqfJvM2jJ6R2aTlpBaYgRrO+9NzIrp7N3vGZ7Xt8joYmcqc80jE9xALrCQ/SOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbDNDmjr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d88cb85987so24276736d6.1
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 07:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734794657; x=1735399457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICQqz9tnXt4TYULJ2wTgFPVoym7zHc4ygjxL8mUFrf4=;
        b=SbDNDmjraIiPzPXSSPJMKDiV6KRKvTSXOFNf/wpKSQTe4vkFFDUdB+o1UoS/IU31Ly
         6ZTJJ8FGA3YJpnYrd1000t7UQsoVlQTwTwj9xeDqjFRZD3tE7NygKYmQlZKDP+E0xssX
         hyeHfqaYXZGXyzKP+H+7ou9ngSOeMei77QkPH9jdRPZ6nQva+bx+7YGNv7cFsop9VMhp
         EkAi0grTVQhFFJaWIGsoWuAMZLrd7+UyjF6BTjY/NPQpuxfsGe9cmhnRshPNrLR/ZflV
         WIupmGHmT95LiyCS/z0vjveoqfonMOXG3OljhkcD1vBu0A2tZ/yJMayyhXgwX7K+GxLS
         /mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734794657; x=1735399457;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ICQqz9tnXt4TYULJ2wTgFPVoym7zHc4ygjxL8mUFrf4=;
        b=nNkOefBaqavM0y8d6u+7dcecgmFMTic1oLUjVXaAIO+X57iB8fUJvd8FlBIxmGfI1Z
         4pauIjiYToss8bUgVv2bqKqxDJ+wLpE4lQf8cqgmh+I0nd/LkXMG5Ol518l4US9Ip5al
         DpozASOV7/rga+ZPpP4Hr1WjxAIqEVLZ6vfrLbyAMNyKVp6rJOIZ3OoR5LOy1GZw1Z4v
         BVNPQYNOOCH6RX4OeFXQGsIELmhYdzpFBb/qCNOnQuznDYe70TpqlmHZcKYCgmEzIqhk
         aWjqfnL9guNYnRch7kEQnQWEIc7oihyakK2Y1jLAgGiODGl6ySeNXQ2Di/4l5Xe7qks7
         AqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrRw4Ou+xxhtD/Y0qs5uRBYvcrs3SE/MkYGqB8zTzeCerrKtgMGRmZoYxyDxeDO4GY2/ExHU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtfdN+knPZMrejmjRAc9J2mVQvjBcRyA1xfDl1RP3L8FNUQ+3/
	3PRj2zg46HbmH5yvMeBfDwnlmYDpSd5RsdwIpjZ/8xodkEVq+3i1
X-Gm-Gg: ASbGncsle1RAXXdl7yo9GN83z3ybCrMj1sw1qWy8d45x2HXwTL2N95metTllj9RI8i1
	z9Id6aKXlCgPfvEWw0phvPtIj2z1ThokHAkr0ktrewR39R2flJZUs/kP1M/EN+PDwZd9iE3Snux
	zfIEJ5wFRjwymIQiQsnRyxJA0VHIxlGb5Hy+umsHSZpa0SSvvCEO+AS8tseqLjaW/qHYVOZIwyR
	JBzwKVfB6R0t9cXlQnpc/E+9MY5LN/bClkzNmafU+EQ6EoaCoO9zp2wVkIhU83lkwRNGcEp/nZs
	BlOEeAJR0yjnxNpiNwPZuD1i1d9RnXgjSQ==
X-Google-Smtp-Source: AGHT+IHe2spvxcP3llL/Wnw1fK+iGGd9rTMfBdNeB7s+IEfYgT41xfT50Ig7k/5EveOI/skFU1u0QA==
X-Received: by 2002:ad4:5bab:0:b0:6d8:ab3c:5d7 with SMTP id 6a1803df08f44-6dd23655202mr103573806d6.24.1734794657281;
        Sat, 21 Dec 2024 07:24:17 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5ab6sm26971896d6.119.2024.12.21.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 07:24:16 -0800 (PST)
Date: Sat, 21 Dec 2024 10:24:16 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stefano Brivio <sbrivio@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 netdev@vger.kernel.org, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Mike Manning <mvrmanning@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Paul Holzinger <pholzing@redhat.com>, 
 Philo Lu <lulie@linux.alibaba.com>, 
 Cambda Zhu <cambda@linux.alibaba.com>, 
 Fred Chen <fred.cc@alibaba-inc.com>, 
 Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>, 
 Peter Oskolkov <posk@google.com>
Message-ID: <6766dda06cf07_30013529434@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241218162116.681734-1-sbrivio@redhat.com>
References: <20241218162116.681734-1-sbrivio@redhat.com>
Subject: Re: [PATCH net-next v2] udp: Deal with race between UDP socket
 address change and rehash
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stefano Brivio wrote:
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
> Until commit 4cdeeee9252a ("net: udp: prefer listeners bound to an
> address"), the race between receive address change and lookup didn't
> actually cause visible issues, because, once the lookup based on the
> secondary hash chain failed, we would still attempt a lookup based on
> the primary hash (destination port only), and find the socket with the
> outdated secondary hash.
> 
> That change, however, dropped port-only lookups altogether, as side
> effect, making the race visible.
> 
> To fix this, while avoiding the need to make address changes and
> rehash atomic against lookups, reintroduce primary hash lookups as
> fallback, if lookups based on four-tuple and secondary hashes fail.
> 
> To this end, introduce a simplified lookup implementation, which
> doesn't take care of SO_REUSEPORT groups: if we have one, there are
> multiple sockets that would match the four-tuple or secondary hash,
> meaning that we can't run into this race at all.
> 
> v2:
>   - instead of synchronising lookup operations against address change
>     plus rehash, reintroduce a simplified version of the original
>     primary hash lookup as fallback
> 
> v1:
>   - fix build with CONFIG_IPV6=n: add ifdef around sk_v6_rcv_saddr
>     usage (Kuniyuki Iwashima)
>   - directly use sk_rcv_saddr for IPv4 receive addresses instead of
>     fetching inet_rcv_saddr (Kuniyuki Iwashima)
>   - move inet_update_saddr() to inet_hashtables.h and use that
>     to set IPv4/IPv6 addresses as suitable (Kuniyuki Iwashima)
>   - rebase onto net-next, update commit message accordingly
> 
> Reported-by: Ed Santiago <santiago@redhat.com>
> Link: https://github.com/containers/podman/issues/24147
> Analysed-by: David Gibson <david@gibson.dropbear.id.au>
> Fixes: 30fff9231fad ("udp: bind() optimisation")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

I suppose it's safe to walk the potentially longest hash chain again
because (1) this was the default pre 2009 too, and not a significant
DoS vector and more importantly (2) it is only reached when the
previous udp6_lib_lookup2 fails, which is only the case during the
rehash operation.

> +/**
> + * udp6_lib_lookup1() - Simplified lookup using primary hash (destination port)
> + * @net:	Network namespace
> + * @saddr:	Source address, network order
> + * @sport:	Source port, network order
> + * @daddr:	Destination address, network order
> + * @hnum:	Destination port, host order
> + * @dif:	Destination interface index
> + * @sdif:	Destination bridge port index, if relevant
> + * @udptable:	Set of UDP hash tables
> + *
> + * Simplified lookup to be used as fallback if no sockets are found due to a
> + * potential race between (receive) address change, and lookup happening before
> + * the rehash operation. This function ignores SO_REUSEPORT groups while scoring
> + * result sockets, because if we have one, we don't need the fallback at all.
> + *
> + * Called under rcu_read_lock().
> + *
> + * Return: socket with highest matching score if any, NULL if none
> + */
> +static struct sock *udp6_lib_lookup1(const struct net *net,
> +				     const struct in6_addr *saddr, __be16 sport,
> +				     const struct in6_addr *daddr,
> +				     unsigned int hnum, int dif, int sdif,
> +				     const struct udp_table *udptable)
> +{
> +	unsigned int slot = udp_hashfn(net, hnum, udptable->mask);
> +	struct udp_hslot *hslot = &udptable->hash[slot];
> +	struct sock *sk, *result = NULL;
> +	int score, badness = 0;
> +
> +	sk_for_each_rcu(sk, &hslot->head) {
> +		score = compute_score(sk, net,
> +				      saddr, sport, daddr, hnum, dif, sdif);
> +		if (score > badness) {
> +			result = sk;
> +			badness = score;
> +		}
> +	}
> +
> +	return result;
> +}
> +
>  /* called with rcu_read_lock() */
>  static struct sock *udp6_lib_lookup2(const struct net *net,
>  		const struct in6_addr *saddr, __be16 sport,
> @@ -347,6 +390,13 @@ struct sock *__udp6_lib_lookup(const struct net *net,
>  	result = udp6_lib_lookup2(net, saddr, sport,
>  				  &in6addr_any, hnum, dif, sdif,
>  				  hslot2, skb);
> +	if (!IS_ERR_OR_NULL(result))
> +		goto done;
> +

Not for this patch, but is appears errors are just treated as NULL.
If so we can update the few callees that return ERR_PTR to just
return NULL.

> +	/* Cover address change/lookup/rehash race: see __udp4_lib_lookup() */
> +	result = udp6_lib_lookup1(net, saddr, sport, daddr, hnum, dif, sdif,
> +				  udptable);
> +
>  done:
>  	if (IS_ERR(result))
>  		return NULL;
> -- 
> 2.40.1
> 



