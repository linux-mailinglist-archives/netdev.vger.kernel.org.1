Return-Path: <netdev+bounces-103895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3C190A0D0
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 01:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBF51C20BB1
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F8473450;
	Sun, 16 Jun 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="gAFhGmu6"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7F73460
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718580563; cv=none; b=nHCy/HvKVZgGazVQjdJi1rEQlgy7qeGTXVqW+5SuD1uwF/FQBapZ5/petkmq1bVF6dKxFWeKSt7w6ghEObzcdSfIUFHU0vMTPO4ZBa7rgTfnHp2sodYw2Tlrd+U4uygL3N+jkNWtKhN7z0AJ794rAXit09typjCwn5UMkbM5MlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718580563; c=relaxed/simple;
	bh=gOciLYtchYd2XJ9QGH+XcZEjC0E1vrYvClZahq0KXiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNkxW8ZFKZhrlE8FDqPZRKKQj4mS2Xf5vsDHy+Vt7+09Crj1hENv8DkahSTHVuPQ913izD7V0/xTjNqP5whclCMzIFRnMyed9iB0PVNvbEClvQkHkgDv5IMm+xn+pTRtl4dp+CD/ZSgWoj124F+ZlscptaIvtUQtI35VfU18LOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=gAFhGmu6; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sIzJ2-00CPiT-EQ; Mon, 17 Jun 2024 01:29:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Qq9WoMHoRlLG4XhKk8QkKDshMMSQc1UcVZ8ivaMTrfY=; b=gAFhGmu68RS5nGxri0jHKnYEw7
	1GP4lau6M059rfRLtlWoKA8dXEAwyU4WD2V5qcDsMlhogXSZE3/8OCUp8cJnUQQqpOuBIQHEViSP9
	BlxeZ1ipTGuSlyvFaALmGRLVPryLKH/jgKH6/yIPP9T89TdtwKa/srq9gQE6v7e5W4fQeT9MYvEi6
	KzQWwG+ILM4DLBB2BJKJmxNz5avaK6PQeToBj5t5gUCfeZzBkj/LdyRMIH0W8/iQ4dbRcDCP8ai3G
	ncOQnZpBISgS7B6kYYV1A0q/20bcWg96T5tlRI/Kl+Dil9VikVTOFZL0tgMDTiIaHMB/8O4zX0fku
	VcNKDJIQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sIzJ1-0005GK-DM; Mon, 17 Jun 2024 01:29:03 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sIzIs-00423d-87; Mon, 17 Jun 2024 01:28:54 +0200
Message-ID: <4b894ffd-9fe2-4c15-a901-6765ab538a01@rbox.co>
Date: Mon, 17 Jun 2024 01:28:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under
 unix_state_lock() for truly disconencted peer.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <cc8a0165-f2e9-43a7-a1a2-28808929d27e@rbox.co>
 <20240610174906.32921-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240610174906.32921-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 19:49, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Mon, 10 Jun 2024 14:55:08 +0200
>> On 6/9/24 23:03, Kuniyuki Iwashima wrote:
>>> (...)
>>> Sorry, I think I was wrong and we can't use smp_store_release()
>>> and smp_load_acquire(), and smp_[rw]mb() is needed.
>>>
>>> Given we avoid adding code in the hotpath in the original fix
>>> 8866730aed510 [0], I prefer adding unix_state_lock() in the SOCKMAP
>>> path again.
>>>
>>> [0]: https://lore.kernel.org/bpf/6545bc9f7e443_3358c208ae@john.notmuch/
>>
>> You're saying smp_wmb() in connect() is too much for the hot path, do I
>> understand correctly?
> 
> Yes, and now I think WARN_ON_ONCE() would be enough because it's unlikely
> that the delay happens between the two store ops and concurrent bpf()
> is in progress.
> 
> If syzkaller was able to hit this on vanilla kernel, we can revisit.
> 
> Then, probably we could just do s/WARN_ON_ONCE/unlikely/ because users
> who call bpf() in such a way know that the state was TCP_CLOSE while
> calling bpf().
> 
> ---8<---
> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index bd84785bf8d6..46dc747349f2 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c
> @@ -181,6 +181,9 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
>  	 */
>  	if (!psock->sk_pair) {
>  		sk_pair = unix_peer(sk);
> +		if (WARN_ON_ONCE(!sk_pair))
> +			return -EINVAL;
> +
>  		sock_hold(sk_pair);
>  		psock->sk_pair = sk_pair;
>  	}
> ---8<---

Oh. That's a peculiar approach :) But, hey, it's your call.

Another AF_UNIX sockmap issue is with OOB. When OOB packet is sent, skb is
added to recv queue, but also u->oob_skb is set. Here's the problem: when
this skb goes through bpf_sk_redirect_map() and is moved between socks,
oob_skb remains set on the original sock.

[   23.688994] WARNING: CPU: 2 PID: 993 at net/unix/garbage.c:351 unix_collect_queue+0x6c/0xb0
[   23.689019] CPU: 2 PID: 993 Comm: kworker/u32:13 Not tainted 6.10.0-rc2+ #137
[   23.689021] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   23.689024] Workqueue: events_unbound __unix_gc
[   23.689027] RIP: 0010:unix_collect_queue+0x6c/0xb0

I wanted to write a patch, but then I realized I'm not sure what's the
expected behaviour. Should the oob_skb setting follow to the skb's new sock
or should it be dropped (similarly to what is happening today with
scm_fp_list, i.e. redirect strips inflights)?

