Return-Path: <netdev+bounces-190491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA6AB7040
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488B51BA2116
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31F17A2F8;
	Wed, 14 May 2025 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXxpVItO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912EAD51
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237592; cv=none; b=mXAvYtptF/RRLfQ2hRCH491ICz8kgc+vgKCavQejVdv75c0zUla5H2d9g/gSlHINVqDJV4avbLpUnkibmpGPUlCPaafoCy7O1CfyJ0acd9GChsXZlgM26WCE3221+HPM4PS+50tJeu9UyhS8qZRlV6ToboKyRpfLJ+AJCOfOFFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237592; c=relaxed/simple;
	bh=MBFyB3CFWD2k/z2Jcfp1T75ryQzKNdPkoV1pbqMikeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvC0h2+sQP9AlL/hyCOFUVaxWJKt5SlHnqf4KeNd6oWdfj/TcDAnOMidEZjjkPqyExpSKxCqg4/XUGT2skWl8XGWAverZ0fXIOngZ0zByXycdqWsllRwyvV2CAyv4YfzU52Lbl2oGL1JNCYHnXONl6sg4WR0Y1bBNK8YW9yJp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXxpVItO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168D5C4CEED;
	Wed, 14 May 2025 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747237591;
	bh=MBFyB3CFWD2k/z2Jcfp1T75ryQzKNdPkoV1pbqMikeE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hXxpVItOLWcQi+S1Yvs2x19M57aiIGLKlciPn6ctklXbBc5qjk+d4KNriSx7u1VIj
	 UuoAeeIAfQ3G1BZwfCZNJje5n0LrxhXU9aB2rOyIbWcnF4z3Ty5zoJm/mQS06QGPRU
	 HxhWuRqgelzO0xQ1rwAxc4ainqxTtmDvIQGQy+vv+ztNQmiqo8KBW1aoFQo/nQg90q
	 +TTS2trHaCb/U7P61ISt/9bSLZ+TW20eVSukMLbzyDrGOpa8JCxu8rd4m/4K/Q0MOG
	 ncm5sL6ih1vXqtskVuc8aVCkUOoAu4ULzPKkAKr7H3Y3NnK2Cx7oDY8VEPyj/45yQh
	 RQ5yM9/GhB1og==
Message-ID: <a9ecd6a0-74da-4f68-81ec-5c2d5b937926@kernel.org>
Date: Wed, 14 May 2025 09:46:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/11] tcp: add tcp_rcvbuf_grow() tracepoint
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Rick Jones <jonesrick@google.com>,
 Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250513193919.1089692-1-edumazet@google.com>
 <20250513193919.1089692-2-edumazet@google.com>
 <51c7b462-500c-4c8b-92eb-d9ebae8bbe42@kernel.org>
 <CANn89iK3n=iCQ5z3ScMvSR5_J=oxaXhrS=JF2fzALuAfeZHoEA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iK3n=iCQ5z3ScMvSR5_J=oxaXhrS=JF2fzALuAfeZHoEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/14/25 9:38 AM, Eric Dumazet wrote:
> On Wed, May 14, 2025 at 8:30 AM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 5/13/25 1:39 PM, Eric Dumazet wrote:
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index a35018e2d0ba27b14d0b59d3728f7181b1a51161..88beb6d0f7b5981e65937a6727a1111fd341335b 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -769,6 +769,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
>>>       if (copied <= tp->rcvq_space.space)
>>>               goto new_measure;
>>>
>>> +     trace_tcp_rcvbuf_grow(sk, time);
>>
>> tracepoints typically take on the name of the function. Patch 2 moves a
>> lot of logic from tcp_rcv_space_adjust to tcp_rcvbuf_grow but does not
>> move this tracepoint into it. For sake of consistency, why not do that -
>> and add this patch after the code move?
> 
> Prior value is needed in the tracepoint, but in patch 2, I call
> tcp_rcvbuf_grow() after it is overwritten.
> 

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8ec92dec321a..6bfbe9005fdb 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -744,12 +744,16 @@ static inline void tcp_rcv_rtt_measure_ts(struct
sock *sk,
        }
 }

-static void tcp_rcvbuf_grow(struct sock *sk)
+static void tcp_rcvbuf_grow(struct sock *sk, int time, int copied)
 {
        const struct net *net = sock_net(sk);
        struct tcp_sock *tp = tcp_sk(sk);
        int rcvwin, rcvbuf, cap;

+       trace_tcp_rcvbuf_grow(sk, time);
+
+       tp->rcvq_space.space = copied;
+
        if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
            (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
                return;
@@ -794,11 +798,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
        if (copied <= tp->rcvq_space.space)
                goto new_measure;

-       trace_tcp_rcvbuf_grow(sk, time);
-
-       tp->rcvq_space.space = copied;
-
-       tcp_rcvbuf_grow(sk);
+       tcp_rcvbuf_grow(sk, time, copied);

 new_measure:
        tp->rcvq_space.seq = tp->copied_seq;


