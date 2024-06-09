Return-Path: <netdev+bounces-102083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886A59015F6
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA15281516
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A62D030;
	Sun,  9 Jun 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cL373MHo"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E83C08A
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717932552; cv=none; b=Q8cbaRtgZ3ftw8nScVJ/CG91WYWatWKvCBwHGjJ/zA6EdhiLmFjCsv4ob/kBHQCoKmI6H1PZODXsE8RhupuvXelURcKzFQHIq3qmKApE/DJgOI8Lb0PM5LGUGy8Yh2DzcmxSaTMGrg11KRmYnkXIGJeYKDgYVaVHkBI7ygw9EzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717932552; c=relaxed/simple;
	bh=64n82kJHnSe1dAAVHYhxKNQwMXDd4o7hsqHIky8hZSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuV2WvXwcnHjrJTaWNuBXcrq3vD4MnJpQyOzSkGa0lu89nHjPNc4Q9C6vPbG03a++4PmiNJWmCZEX5L9GvHdunGzy8u79MCWaJ/MSngQH9PRs4HpqhRXhOJ/mZtjpPOhsI5jxEs5kxgsUkA5zXCiu9CiDjhmQ1BEz2LNh+ZHKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cL373MHo; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sGGjF-0082jP-PH; Sun, 09 Jun 2024 13:28:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=0HXIpayi735m1jY+PNIhxE51hQbf92/H3KbdQ0s/YCs=; b=cL373MHoVnUiu+oeo7Slns/QNy
	l0B2CKU9js1ii9AwMiJFdvRYDJMKE0CHxdZrth9xahPqODfuMLnmL7Xk6UJTBydqbXvaqkbIoG765
	eKHZ6XysEU4w/ZUANLFOKwW0kHETYGOX+Z/M5dQJ+uP+n6unu1K0J3frM8uBdJyUgW9PGHSh5L5BH
	XODXGx19bs4W3NSQqSbFtYnbwh1GxwOOtIhrciQgGyPaU73cX2H+gQ0LnOt2n4Ss4dhT7/4fsrYgd
	lbc3e1NThAiTff52ql+XluOoPhcBNY/0QtcJrV7Ed+Ch7ylRNQnZ77fV+t37Y5mQqy1C3cuKUAOMA
	j1wqg9cw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sGGjE-0002vf-Mv; Sun, 09 Jun 2024 13:28:52 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sGGix-00BXde-5y; Sun, 09 Jun 2024 13:28:35 +0200
Message-ID: <ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co>
Date: Sun, 9 Jun 2024 13:28:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under
 unix_state_lock() for truly disconencted peer.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Cong Wang <cong.wang@bytedance.com>
References: <20240604165241.44758-1-kuniyu@amazon.com>
 <20240604165241.44758-2-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
Autocrypt: addr=regenrecht@o2.pl; keydata=
 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
In-Reply-To: <20240604165241.44758-2-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 18:52, Kuniyuki Iwashima wrote:
> When a SOCK_DGRAM socket connect()s to another socket, the both sockets'
> sk->sk_state are changed to TCP_ESTABLISHED so that we can register them
> to BPF SOCKMAP. (...)

Speaking of af_unix and sockmap, SOCK_STREAM has a tiny window for
bpf(BPF_MAP_UPDATE_ELEM) and unix_stream_connect() to race: when
sock_map_sk_state_allowed() passes (sk_state == TCP_ESTABLISHED), but
unix_peer(sk) in unix_stream_bpf_update_proto() _still_ returns NULL:

	T0 bpf				T1 connect
	======				==========

				WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
sock_map_sk_state_allowed(sk)
...
sk_pair = unix_peer(sk)
sock_hold(sk_pair)
				sock_hold(newsk)
				smp_mb__after_atomic()
				unix_peer(sk) = newsk
				unix_state_unlock(sk)

With mdelay(1) stuffed in unix_stream_connect():

[  902.277593] BUG: kernel NULL pointer dereference, address: 0000000000000080
[  902.277633] #PF: supervisor write access in kernel mode
[  902.277661] #PF: error_code(0x0002) - not-present page
[  902.277688] PGD 107191067 P4D 107191067 PUD 10f63c067 PMD 0
[  902.277716] Oops: Oops: 0002 [#23] PREEMPT SMP NOPTI
[  902.277742] CPU: 2 PID: 1505 Comm: a.out Tainted: G      D            6.10.0-rc1+ #130
[  902.277769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[  902.277793] RIP: 0010:unix_stream_bpf_update_proto+0xa1/0x150

Setting TCP_ESTABLISHED _after_ unix_peer() fixes the issue, so how about
something like

@@ -1631,12 +1631,13 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
        /* Set credentials */
        copy_peercred(sk, other);

-       sock->state     = SS_CONNECTED;
-       WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);
        sock_hold(newsk);
+       smp_mb__after_atomic(); /* sock_hold() does an atomic_inc() */
+       WRITE_ONCE(unix_peer(sk), newsk);
+       smp_wmb(); /* ensure peer is set before sk_state */

-       smp_mb__after_atomic(); /* sock_hold() does an atomic_inc() */
-       unix_peer(sk)   = newsk;
+       sock->state = SS_CONNECTED;
+       WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED);

        unix_state_unlock(sk);

@@ -180,7 +180,8 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
         * be a single matching destroy operation.
         */
        if (!psock->sk_pair) {
-               sk_pair = unix_peer(sk);
+               smp_rmb();
+               sk_pair = READ_ONCE(unix_peer(sk));
                sock_hold(sk_pair);
                psock->sk_pair = sk_pair;
        }

This should keep things ordered and lockless... I hope.

Alternatively, maybe it would be better just to make BPF respect the unix
state lock?

@@ -180,6 +180,8 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
 	 * be a single matching destroy operation.
 	 */
 	if (!psock->sk_pair) {
+               unix_state_lock(sk);
                sk_pair = unix_peer(sk);
+               unix_state_unlock(sk);
 		sock_hold(sk_pair);
 		psock->sk_pair = sk_pair;

What do you think?

Thanks,
Michal

