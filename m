Return-Path: <netdev+bounces-264672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB6FIDJgqmmxQQEAu9opvQ
	(envelope-from <netdev+bounces-264672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:03:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D0C21B9D3
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3E23027942
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 05:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BAC352C22;
	Fri,  6 Mar 2026 05:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XmJzkqhS"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9D1B6D08;
	Fri,  6 Mar 2026 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772773421; cv=none; b=Hc0469/Or+X2INsIRtR0810hlr1fMg4kC+wLooPxiRkFKXFAu2oDK3TRoXlN6ua8548K0Pp3DqZvjntGnplxAgRY5n9ZVGb3f1HEknNAdTrvt/ojSOoAJyqRAof2ZR9nkr4U7NKlLsXGJYav9r3Njrl0aAPouMkB4P5EAdbXP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772773421; c=relaxed/simple;
	bh=qUJeOEsw+vRKzQDz95vJjk1nAfCEPoWenvORmi/vglc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrW03ATZ2OLyzaIL3B6UPQd43n/ZhztmxX0FGu8QlUGmVch/5XfiGZX51NcHqPU4v7unYfqa2v+wYWqvs1xmtoaNcDusur+bqNGiALQR7I4L1RZl+Np3VMFA2b3v12vSAmoDvCS04CGpwRmPtI585P38RcUuZJGeaUKkEvhkmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XmJzkqhS; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=MZkqtGswibcF4EQ0oKUujrPCkLwNqRBJ1gUrWyQ6mq4=;
	b=XmJzkqhSif/KJmEzFj0D7/aItuzCRbLQe11TwIDquQKRBt5eJlTLFX0AMPYoiI
	/ONTvoaTFBvSamj3ZO6d7grlcYBxhk7kV4qmHOs+iaCt/Caxg7uxAuAojZ7xFpdH
	Tra1ZkKq1LRFu0JIJ+LKcygDWdhlSvsf/kGXR3iEygXF4=
Received: from [10.54.24.32] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC37PmmX6ppmnCsOA--.52670S2;
	Fri, 06 Mar 2026 13:01:28 +0800 (CST)
Message-ID: <2192e9ef-894f-4826-b296-4f90e973a31b@163.com>
Date: Fri, 6 Mar 2026 13:01:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 5/5] bpf, sockmap: Adapt for af_unix-specific lock
To: Michal Luczaj <mhal@rbox.co>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-5-2f0c7410c523@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC37PmmX6ppmnCsOA--.52670S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ar4xur18Jr18trWftr1UKFg_yoWxJr1rpF
	Z0kF4xGrWDJryxXr4fA3s2vrWkuanYg3W5Kas7XayrAFZFgr1fuw4DGFZ2vr90yrZFkF1U
	Jw17Kr4kA3yUJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyVbgUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbCwwkHrmmqX6ks5gAA3c
X-Rspamd-Queue-Id: D9D0C21B9D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[rbox.co,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-264672-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrpre@163.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action


On 3/6/26 7:30 AM, Michal Luczaj wrote:
> unix_stream_connect() sets sk_state (`WRITE_ONCE(sk->sk_state,
> TCP_ESTABLISHED)`) _before_ it assigns a peer (`unix_peer(sk) = newsk`).
> sk_state == TCP_ESTABLISHED makes sock_map_sk_state_allowed() believe that
> socket is properly set up, which would include having a defined peer. IOW,
> there's a window when unix_stream_bpf_update_proto() can be called on
> socket which still has unix_peer(sk) == NULL.
>
>            T0 bpf                            T1 connect
>            ------                            ----------
>
>                                  WRITE_ONCE(sk->sk_state, TCP_ESTABLISHED)
> sock_map_sk_state_allowed(sk)
> ...
> sk_pair = unix_peer(sk)
> sock_hold(sk_pair)
>                                  sock_hold(newsk)
>                                  smp_mb__after_atomic()
>                                  unix_peer(sk) = newsk
>
> BUG: kernel NULL pointer dereference, address: 0000000000000080
> RIP: 0010:unix_stream_bpf_update_proto+0xa0/0x1b0
> Call Trace:
>    sock_map_link+0x564/0x8b0
>    sock_map_update_common+0x6e/0x340
>    sock_map_update_elem_sys+0x17d/0x240
>    __sys_bpf+0x26db/0x3250
>    __x64_sys_bpf+0x21/0x30
>    do_syscall_64+0x6b/0x3a0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Initial idea was to move peer assignment _before_ the sk_state update[1],
> but that involved an additional memory barrier, and changing the hot path
> was rejected. Then a check during proto update was considered[2], but a
> follow-up discussion[3] concluded the root cause is sockmap taking a wrong
> lock. Or, more specifically, an insufficient lock[4].
>
> Thus, teach sockmap about the af_unix-specific locking: af_unix protects
> critical sections under unix_state_lock() operating on unix_sock::lock.
>
> [1]: https://lore.kernel.org/netdev/ba5c50aa-1df4-40c2-ab33-a72022c5a32e@rbox.co/
> [2]: https://lore.kernel.org/netdev/20240610174906.32921-1-kuniyu@amazon.com/
> [3]: https://lore.kernel.org/netdev/7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev/
> [4]: https://lore.kernel.org/netdev/CAAVpQUA+8GL_j63CaKb8hbxoL21izD58yr1NvhOhU=j+35+3og@mail.gmail.com/
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>   net/core/sock_map.c | 35 +++++++++++++++++++++++++++++------
>   1 file changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 7ba6a7f24ccd..6109fbe6f99c 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -12,6 +12,7 @@
>   #include <linux/list.h>
>   #include <linux/jhash.h>
>   #include <linux/sock_diag.h>
> +#include <net/af_unix.h>
>   #include <net/udp.h>
>   
>   struct bpf_stab {
> @@ -115,19 +116,43 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
>   }
>   
>   static void sock_map_sk_acquire(struct sock *sk)
> -	__acquires(&sk->sk_lock.slock)
>   {
>   	lock_sock(sk);
> +
> +	if (sk_is_unix(sk))
> +		unix_state_lock(sk);
> +
>   	rcu_read_lock();
>   }
>   

This introduces a new ordering constraint: lock_sock() before
unix_state_lock(). Kuniyuki flagged in the v2 review that taking
lock_sock() inside unix_state_lock() in the future would create an
ABBA deadlock, which is exactly why the order was settled this way. However,
the thread did not reach a conclusion on whether that constraint should be
documented in the code.

Since there is nothing enforcing this ordering mechanically, a brief comment
at sock_map_sk_acquire() would help future readers avoid introducing the
inverse ordering.


>   static void sock_map_sk_release(struct sock *sk)
> -	__releases(&sk->sk_lock.slock)
>   {
>   	rcu_read_unlock();
> +
> +	if (sk_is_unix(sk))
> +		unix_state_unlock(sk);
> +
>   	release_sock(sk);
>   }
>   
> +static inline void sock_map_sk_acquire_fast(struct sock *sk)
> +{
> +	local_bh_disable();
> +	bh_lock_sock(sk);
> +
> +	if (sk_is_unix(sk))
> +		unix_state_lock(sk);
> +}
> +


v2 and v3 differ here in a way that deserves a closer look. In v2, AF_UNIX
sockets took only unix_state_lock() in the fast path, skipping
bh_lock_sock() entirely:

/* v2 */
if (sk_is_unix(sk))
   unix_state_lock(sk);
else
   bh_lock_sock(sk);

v3 takes both for AF_UNIX sockets.

bh_lock_sock() protects sock::sk_lock.slock, whereas the state that
actually needs protection here — sk_state and unix_peer() — lives under
unix_sock::lock. Since unix_state_lock() is already sufficient to close
the race against unix_stream_connect(), is bh_lock_sock() still doing
anything useful for AF_UNIX sockets in this path?

The v3 changelog attributes "Keep lock_sock() along with unix_state_lock()"
to Kuniyuki, but that comment appears to concern sock_map_sk_acquire()
(the slow path); the fast path behaviour change was not explicitly discussed
in the v2 thread.

If bh_lock_sock() is redundant for AF_UNIX here, reverting to the v2
approach would reduce unnecessary lock contention. If it is still needed,
a comment explaining what it protects for AF_UNIX sockets would help.

> +static inline void sock_map_sk_release_fast(struct sock *sk)
> +{
> +	if (sk_is_unix(sk))
> +		unix_state_unlock(sk);
> +
> +	bh_unlock_sock(sk);
> +	local_bh_enable();
> +}
> +
>   static void sock_map_add_link(struct sk_psock *psock,
>   			      struct sk_psock_link *link,
>   			      struct bpf_map *map, void *link_raw)
> @@ -604,16 +629,14 @@ static long sock_map_update_elem(struct bpf_map *map, void *key,
>   	if (!sock_map_sk_is_suitable(sk))
>   		return -EOPNOTSUPP;
>   
> -	local_bh_disable();
> -	bh_lock_sock(sk);
> +	sock_map_sk_acquire_fast(sk);
>   	if (!sock_map_sk_state_allowed(sk))
>   		ret = -EOPNOTSUPP;
>   	else if (map->map_type == BPF_MAP_TYPE_SOCKMAP)
>   		ret = sock_map_update_common(map, *(u32 *)key, sk, flags);
>   	else
>   		ret = sock_hash_update_common(map, key, sk, flags);
> -	bh_unlock_sock(sk);
> -	local_bh_enable();
> +	sock_map_sk_release_fast(sk);
>   	return ret;
>   }
>   
>


