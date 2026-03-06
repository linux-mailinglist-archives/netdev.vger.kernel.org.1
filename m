Return-Path: <netdev+bounces-264685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGneOJBuqmkPRQEAu9opvQ
	(envelope-from <netdev+bounces-264685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:05:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFF421BF1D
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2051303788C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C82836E464;
	Fri,  6 Mar 2026 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jg6FGjoK"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6836D9F4;
	Fri,  6 Mar 2026 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772777092; cv=none; b=KXE27YJHNjxUDiJ26GjELuLvSECv/PQP8bSEXEOTjg9V0BIl1xmXsA9kIWibSqNmfhZWHk0DWyuw7CT7ZaVX4fdZKF43oTJu/mDWceiGbeDD2iUGIcjCAjbRLqlD2ZwWkB03c6ZPGyDE+Jnk7r/hJZHOwf5q0vvCR7PyNfd8ato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772777092; c=relaxed/simple;
	bh=vWeu+rrJuKn1HkWhdpVCh461e+ugjTi9tY18/n63aBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfmHriGTPcOHbffrmOWv8AmXtRasJ1twsQG3TXe2qEC3gIX6P+elKuc3/v57V8InTFbuLn6nfe/HFlu0vSa5sVOOJDCYecB403sLVS+entV4YwZUlAUnnBTEm13qcQiywC1eZQSkqWPczFcs/Cd+/zFQs9/xQxLqtJ2H/DouzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jg6FGjoK; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2218c30-a704-4395-a67e-95c62b75586f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772777076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lha1WxEP+imAaOmc44xUnzff4mjB8gJAeNTzMUJkIRU=;
	b=Jg6FGjoK1PpSXKlligTbMsTDBRMhL/de2yK3tlsDKu2sxpMYtli5ImRDeZIg6MwAsnjUmF
	a0QOh6/N3x4yIg2UuELd1FVRhP/cE7IHjZT+I5QqUdXIsQgwZBxHusHK71Rt9lrQFUEsyj
	NF7WpdbM6vil13A0pzoVwjUupJo3jCs=
Date: Fri, 6 Mar 2026 14:04:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 3/5] bpf, sockmap: Fix af_unix iter deadlock
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
 <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5AFF421BF1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264685-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[rbox.co,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rbox.co:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action


On 3/6/26 7:30 AM, Michal Luczaj wrote:
> bpf_iter_unix_seq_show() may deadlock when lock_sock_fast() takes the fast
> path and the iter prog attempts to update a sockmap. Which ends up spinning
> at sock_map_update_elem()'s bh_lock_sock():
>
> WARNING: possible recursive locking detected
> test_progs/1393 is trying to acquire lock:
> ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: sock_map_update_elem+0xdb/0x1f0
>
> but task is already holding lock:
> ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0x37/0xe0
>
> other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(slock-AF_UNIX);
>    lock(slock-AF_UNIX);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
> 4 locks held by test_progs/1393:
>   #0: ffff88814b59c790 (&p->lock){+.+.}-{4:4}, at: bpf_seq_read+0x59/0x10d0
>   #1: ffff88811ec25fd8 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: bpf_seq_read+0x42c/0x10d0
>   #2: ffff88811ec25f58 (slock-AF_UNIX){+...}-{3:3}, at: __lock_sock_fast+0x37/0xe0
>   #3: ffffffff85a6a7c0 (rcu_read_lock){....}-{1:3}, at: bpf_iter_run_prog+0x51d/0xb00
>
> Call Trace:
>   dump_stack_lvl+0x5d/0x80
>   print_deadlock_bug.cold+0xc0/0xce
>   __lock_acquire+0x130f/0x2590
>   lock_acquire+0x14e/0x2b0
>   _raw_spin_lock+0x30/0x40
>   sock_map_update_elem+0xdb/0x1f0
>   bpf_prog_2d0075e5d9b721cd_dump_unix+0x55/0x4f4
>   bpf_iter_run_prog+0x5b9/0xb00
>   bpf_iter_unix_seq_show+0x1f7/0x2e0
>   bpf_seq_read+0x42c/0x10d0
>   vfs_read+0x171/0xb20
>   ksys_read+0xff/0x200
>   do_syscall_64+0x6b/0x3a0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domain socket.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>   net/unix/af_unix.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 3756a93dc63a..3d2cfb4ecbcd 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3729,15 +3729,14 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>   	struct bpf_prog *prog;
>   	struct sock *sk = v;
>   	uid_t uid;
> -	bool slow;
>   	int ret;
>   
>   	if (v == SEQ_START_TOKEN)
>   		return 0;
>   
> -	slow = lock_sock_fast(sk);
> +	lock_sock(sk);
>   
> -	if (unlikely(sk_unhashed(sk))) {
> +	if (unlikely(sock_flag(sk, SOCK_DEAD))) {
>   		ret = SEQ_SKIP;
>   		goto unlock;
>   	}


Switching to lock_sock() fixes the deadlock, but it does not provide mutual
exclusion with unix_release_sock(), which uses unix_state_lock() exclusively
and does not touch lock_sock() at all. So a dying socket can still reach the
BPF prog concurrently with unix_release_sock() running on another CPU.

Both SOCK_DEAD and the clearing of unix_peer(sk) happen under
unix_state_lock() in unix_release_sock(). Without taking unix_state_lock()
before the SOCK_DEAD check, there is a window:

iter unix_release_sock()
---  lock_sock(sk)
SOCK_DEAD == 0(check passes)
   unix_state_lock(sk)
                                                   unix_peer(sk) = NULL
   sock_set_flag(sk, SOCK_DEAD)
   unix_state_unlock(sk)
BPF prog runs
→ accesses unix_peer(sk) == NULL → crash

This was not raised in the v2 discussion.

The natural fix is to check SOCK_DEAD under unix_state_lock(). However,
holding unix_state_lock() throughout BPF prog execution would conflict with
patch 5: sock_map_sk_acquire_fast() also takes unix_state_lock() for AF_UNIX
sockets, resulting in a recursive spinlock deadlock.


Kuniyuki, Martin — what is the right approach here?

> @@ -3747,7 +3746,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>   	prog = bpf_iter_get_info(&meta, false);
>   	ret = unix_prog_seq_show(prog, &meta, v, uid);
>   unlock:
> -	unlock_sock_fast(sk, slow);
> +	release_sock(sk);
>   	return ret;
>   }
>   
>

