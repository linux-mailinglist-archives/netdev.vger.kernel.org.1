Return-Path: <netdev+bounces-264190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DCeJM0kqWkL2gAAu9opvQ
	(envelope-from <netdev+bounces-264190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 07:38:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002720BB4E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 07:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45FFA301A692
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27A230595B;
	Thu,  5 Mar 2026 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nHbNSVCO"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F5306B08
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692678; cv=none; b=LOA2nywmb9hN3z9+1BnU9TqYG2JHXR5cvUVw2EqvFXB13FmWB7fjzdlkZcgD9PtobA3F9oSiRILvJ7ADMcxdgr8aMktoEm1p5oFA4TTq/uNINFGp2dcUbwlhcGpJoLI7yYlrDHMl1B4BiOjxkFR5xR0HZqlac2fZWk7mxPILOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692678; c=relaxed/simple;
	bh=2/dDEO6Okg4r6z3kT6lcNlrPgBgleKltpkjwonngJhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImAjt7d9MpDzLXSOYy1XBR5NHAynZgHz+Dsp13ONUMyAlfccEg4l4II+T6g88o/tqjobkvqBeuKaQD/5lJ1cp3Wi46EicEpAU7MaI3ykdGoHT+I0QdchHSzctFJZQKi2lU36MsA064jt+A50US0o01KXtxYbwaYO91QwfQwQluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nHbNSVCO; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 5 Mar 2026 14:37:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772692664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2S16QnK4rxQ0pZBOKtZvv7yodAZC9lYu1exEt4dOxzE=;
	b=nHbNSVCOaFCTs1ON86LqF5XUcEV/dNYlH82IX4io1DZL1IHqv7wsEuTnAoOgibkEc0TmSk
	T7HliUDKTJLT1aNwKPHeRxyJW8srzpW5d3umqVv9eGh+tIxH0oJI4nYMJgchW5M9rn2yii
	Goy4d91QR2VA/YVA0iK8ChQSpaD81y4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 bpf/net 6/6] sockmap: Fix broken memory accounting for
 UDP.
Message-ID: <r7csevb4yonphmfhfpkj7jpc4yvjkdwrp566zxhueaf6vgjfak@stnfyjkqid6o>
References: <20260221233234.3814768-1-kuniyu@google.com>
 <20260221233234.3814768-7-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221233234.3814768-7-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9002720BB4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264190-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,5b3b7e51dda1be027b7a];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 11:30:53PM +0800, Kuniyuki Iwashima wrote:
[...]
>  </TASK>
> 
> Fixes: d7f571188ecf ("udp: Implement ->read_sock() for sockmap")
> Reported-by: syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/698f84c6.a70a0220.2c38d7.00cb.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v4: Fix deadlock when requeued
> v2: Fix build failure when CONFIG_INET=n
> ---
>  include/net/udp.h |  9 +++++++++
>  net/core/skmsg.c  | 29 +++++++++++++++++++++++++----
>  net/ipv4/udp.c    |  9 +++++++++
>  3 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 700dbedcb15f..ae38a4da9388 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -455,6 +455,15 @@ struct sock *__udp6_lib_lookup(const struct net *net,
>  			       struct sk_buff *skb);
>  struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
>  				 __be16 sport, __be16 dport);
> +
> +#ifdef CONFIG_INET
> +void udp_sock_rfree(struct sk_buff *skb);
> +#else
> +static inline void udp_sock_rfree(struct sk_buff *skb)
> +{
> +}
> +#endif
> +
>  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
>  
>  /* UDP uses skb->dev_scratch to cache as much information as possible and avoid
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 96f43e0dbb17..dd9134a45663 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -7,6 +7,7 @@
>  
>  #include <net/sock.h>
>  #include <net/tcp.h>
> +#include <net/udp.h>
>  #include <net/tls.h>
>  #include <trace/events/sock.h>
>  
> @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>  				u32 off, u32 len, bool take_ref)
>  {
>  	struct sock *sk = psock->sk;
> +	bool is_udp = sk_is_udp(sk);
>  	struct sk_msg *msg;
>  	int err = -EAGAIN;
>  
> @@ -583,13 +585,20 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>  	if (!msg)
>  		goto out;
>  
> -	if (skb->sk != sk && take_ref) {
> +	if (is_udp) {
> +		if (unlikely(skb->destructor == udp_sock_rfree))
> +			goto enqueue;
> +
> +		spin_lock_bh(&sk->sk_receive_queue.lock);
> +	}
> +
> +	if (is_udp || (skb->sk != sk && take_ref)) {
>  		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> -			goto free;
> +			goto unlock;
>  
>  		if (!sk_rmem_schedule(sk, skb, skb->truesize))
> -			goto free;
> -	} else {
> +			goto unlock;
> +	} else if (skb->sk == sk || !take_ref) {
>  		/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
>  		 * data originates from the socket's own protocol stack. No need to
>  		 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
> @@ -604,11 +613,23 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>  	 * into user buffers.
>  	 */
>  	skb_set_owner_r(skb, sk);
> +
> +	if (is_udp) {
> +		spin_unlock_bh(&sk->sk_receive_queue.lock);
> +
> +		skb->destructor = udp_sock_rfree;
> +	}
> +
> +enqueue:
>  	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
>  	if (err < 0)
>  		goto free;
>  out:
>  	return err;
> +
> +unlock:
> +	if (is_udp)
> +		spin_unlock_bh(&sk->sk_receive_queue.lock);
>  free:
>  	kfree(msg);
>  	goto out;
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 422c96fea249..831d26748a90 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2039,6 +2039,15 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
>  }
>  EXPORT_SYMBOL(__skb_recv_udp);
>  
> +void udp_sock_rfree(struct sk_buff *skb)
> +{
> +	struct sock *sk = skb->sk;
> +
> +	spin_lock_bh(&sk->sk_receive_queue.lock);
> +	sock_rfree(skb);
> +	spin_unlock_bh(&sk->sk_receive_queue.lock);
> +}
> +
>  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
>  {
>  	struct sk_buff *skb;
> -- 
> 2.53.0.371.g1d285c8824-goog
>

There are too many protocol-specific checks in the generic skmsg code
here. This should be abstracted out.

Also TCP also has a similar issue with sk_forward_alloc concurrency
between the backlog charge and recvmsg uncharge paths so the abstraction
is necessary.

I've put together a simple diff based on your patch for reference. 
I haven't tested it thoroughly, but it at least handles TCP and UDP
separately through a callback, keeping the generic code clean.


diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 829b281d6c9c..d9a607e11cd1 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -80,6 +80,20 @@ struct sk_psock_work_state {
        u32                             off;
 };

+struct sk_psock;
+
+/*
+ * Callback for protocol-specific memory accounting on the ingress path.
+ * Each protocol uses different locks to protect sk->sk_forward_alloc:
+ *   TCP: psock->ingress_lock
+ *   UDP: sk->sk_receive_queue.lock
+ * This callback encapsulates the protocol-specific locking and charging.
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+typedef int (*psock_ingress_charge_t)(struct sk_psock *psock, struct sock *sk,
+                                    struct sk_buff *skb, struct sk_msg *msg);
+
 struct sk_psock {
        struct sock                     *sk;
        struct sock                     *sk_redir;
@@ -97,6 +111,7 @@ struct sk_psock {
        struct sk_buff_head             ingress_skb;
        struct list_head                ingress_msg;
        spinlock_t                      ingress_lock;
+       psock_ingress_charge_t          ingress_charge;
        /** @msg_tot_len: Total bytes queued in ingress_msg list. */
        u32                             msg_tot_len;
        unsigned long                   state;
@@ -411,10 +426,13 @@ static inline bool sk_psock_queue_empty(const struct sk_psock *psock)
        return psock ? list_empty(&psock->ingress_msg) : true;
 }

-static inline void kfree_sk_msg(struct sk_msg *msg)
+static inline void kfree_sk_msg(struct sk_psock *psock, struct sk_msg *msg)
 {
-       if (msg->skb)
+       if (msg->skb) {
+               spin_lock_bh(&psock->ingress_lock);
                consume_skb(msg->skb);
+               spin_unlock_bh(&psock->ingress_lock);
+       }
        kfree(msg);
 }

diff --git a/include/net/udp.h b/include/net/udp.h
index 700dbedcb15f..78229bc7424e 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -401,6 +401,7 @@ void udp_destruct_common(struct sock *sk);
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len);
 int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb);
 void udp_skb_destructor(struct sock *sk, struct sk_buff *skb);
+void udp_sock_rfree(struct sk_buff *skb);
 struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags, int *off,
                               int *err);
 static inline struct sk_buff *skb_recv_udp(struct sock *sk, unsigned int flags,
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ddde93dd8bc6..df0f846c63bb 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -488,7 +488,7 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
                msg_rx->sg.start = i;
                if (!sge->length && (i == msg_rx->sg.end || sg_is_last(sge))) {
                        msg_rx = sk_psock_dequeue_msg(psock);
-                       kfree_sk_msg(msg_rx);
+                       kfree_sk_msg(psock, msg_rx);
                }
                msg_rx = sk_psock_peek_msg(psock);
        }
@@ -529,18 +529,6 @@ static struct sk_msg *alloc_sk_msg(gfp_t gfp)
        return msg;
 }

-static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
-                                                 struct sk_buff *skb)
-{
-       if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-               return NULL;
-
-       if (!sk_rmem_schedule(sk, skb, skb->truesize))
-               return NULL;
-
-       return alloc_sk_msg(GFP_KERNEL);
-}
-
 static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
                                        u32 off, u32 len,
                                        struct sk_psock *psock,
@@ -584,60 +572,51 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
        return copied;
 }

-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-                                    u32 off, u32 len, bool take_ref);
-
-static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-                               u32 off, u32 len)
+/* Default ingress charge for protocols that don't set a custom callback.
+ * Behaves like the original TCP logic: skip accounting for self-redirect.
+ */
+static int sk_psock_ingress_charge_default(struct sk_psock *psock,
+                                          struct sock *sk,
+                                          struct sk_buff *skb,
+                                          struct sk_msg *msg)
 {
-       struct sock *sk = psock->sk;
-       struct sk_msg *msg;
-       int err;
+       if (skb->sk == sk) {
+               skb_set_owner_r(skb, sk);
+               msg->sk = sk;
+               return 0;
+       }

-       /* If we are receiving on the same sock skb->sk is already assigned,
-        * skip memory accounting and owner transition seeing it already set
-        * correctly.
-        */
-       if (unlikely(skb->sk == sk))
-               return sk_psock_skb_ingress_self(psock, skb, off, len, true);
-       msg = sk_psock_create_ingress_msg(sk, skb);
-       if (!msg)
+       if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+               return -EAGAIN;
+
+       if (!sk_rmem_schedule(sk, skb, skb->truesize))
                return -EAGAIN;

-       /* This will transition ownership of the data from the socket where
-        * the BPF program was run initiating the redirect to the socket
-        * we will eventually receive this data on. The data will be released
-        * from skb_consume found in __tcp_bpf_recvmsg() after its been copied
-        * into user buffers.
-        */
        skb_set_owner_r(skb, sk);
-       err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
-       if (err < 0)
-               kfree(msg);
-       return err;
+       return 0;
 }

-/* Puts an skb on the ingress queue of the socket already assigned to the
- * skb. In this case we do not need to check memory limits or skb_set_owner_r
- * because the skb is already accounted for here.
- */
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-                                    u32 off, u32 len, bool take_ref)
+static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
+                               u32 off, u32 len, bool take_ref)
 {
-       struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
        struct sock *sk = psock->sk;
+       psock_ingress_charge_t charge_fn;
+       struct sk_msg *msg;
        int err;

-       if (unlikely(!msg))
+       msg = alloc_sk_msg(take_ref ? GFP_KERNEL : GFP_ATOMIC);
+       if (!msg)
                return -EAGAIN;
-       skb_set_owner_r(skb, sk);

-       /* This is used in tcp_bpf_recvmsg_parser() to determine whether the
-        * data originates from the socket's own protocol stack. No need to
-        * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
-        */
-       msg->sk = sk;
-       err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
+       charge_fn = psock->ingress_charge ?: sk_psock_ingress_charge_default;
+       err = charge_fn(psock, sk, skb, msg);
+       if (err < 0) {
+               kfree(msg);
+               return err;
+       }
+
+       err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg,
+                                          take_ref);
        if (err < 0)
                kfree(msg);
        return err;
@@ -652,7 +631,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
                return skb_send_sock(psock->sk, skb, off, len);
        }

-       return sk_psock_skb_ingress(psock, skb, off, len);
+       return sk_psock_skb_ingress(psock, skb, off, len, true);
 }

 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1059,7 +1038,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
                                off = stm->offset;
                                len = stm->full_len;
                        }
-                       err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+                       err = sk_psock_skb_ingress(psock, skb, off, len, false);
                }
                if (err < 0) {
                        spin_lock_bh(&psock->ingress_lock);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index ca8a5cb8e569..d88b9516a470 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -706,6 +706,37 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
 }
 #endif /* CONFIG_BPF_STREAM_PARSER */

+static int tcp_psock_ingress_charge(struct sk_psock *psock, struct sock *sk,
+                                   struct sk_buff *skb, struct sk_msg *msg)
+{
+       /* TCP self-redirect: skb is already accounted by TCP stack, and
+        * lock_sock serializes the verdict path with recvmsg. Skip memory
+        * accounting but mark msg->sk for tcp_bpf_recvmsg_parser() to
+        * identify self-originated data.
+        */
+       if (skb->sk == sk) {
+               skb_set_owner_r(skb, sk);
+               msg->sk = sk;
+               return 0;
+       }
+
+       spin_lock_bh(&psock->ingress_lock);
+
+       if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+               goto err;
+
+       if (!sk_rmem_schedule(sk, skb, skb->truesize))
+               goto err;
+
+       skb_set_owner_r(skb, sk);
+       spin_unlock_bh(&psock->ingress_lock);
+       return 0;
+
+err:
+       spin_unlock_bh(&psock->ingress_lock);
+       return -EAGAIN;
+}
+
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
        int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
@@ -739,6 +770,7 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
                tcp_bpf_check_v6_needs_rebuild(psock->sk_proto);
        }

+       psock->ingress_charge = tcp_psock_ingress_charge;
        /* Pairs with lockless read in sk_clone_lock() */
        sock_replace_proto(sk, &tcp_bpf_prots[family][config]);
        return 0;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b96e47f1c8a2..8cefc3ed76c5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2039,6 +2039,19 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 }
 EXPORT_SYMBOL(__skb_recv_udp);

+/* skb destructor for sockmap-owned UDP skbs.
+ * sock_rfree modifies sk->sk_forward_alloc which must be protected
+ * by sk->sk_receive_queue.lock for UDP.
+ */
+void udp_sock_rfree(struct sk_buff *skb)
+{
+       struct sock *sk = skb->sk;
+
+       spin_lock_bh(&sk->sk_receive_queue.lock);
+       sock_rfree(skb);
+       spin_unlock_bh(&sk->sk_receive_queue.lock);
+}
+
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
        struct sk_buff *skb;
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 91233e37cd97..6b117711193e 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -153,6 +153,42 @@ static int __init udp_bpf_v4_build_proto(void)
 }
 late_initcall(udp_bpf_v4_build_proto);

+static int udp_psock_ingress_charge(struct sk_psock *psock, struct sock *sk,
+                                   struct sk_buff *skb, struct sk_msg *msg)
+{
+       /* When backlog retries a previously charged skb, the destructor
+        * is already set to udp_sock_rfree. Skip re-charging.
+        */
+       if (unlikely(skb->destructor == udp_sock_rfree))
+               return 0;
+
+       /* UDP must always do full memory accounting, even for self-redirect.
+        * Unlike TCP, udp_rmem_release() partially reclaims sk_forward_alloc
+        * during skb_recv_udp(), so the skb is no longer properly accounted
+        * when it reaches the sockmap ingress path.
+        *
+        * sk->sk_receive_queue.lock is required because that's the lock UDP
+        * uses internally to protect sk_forward_alloc.
+        */
+       spin_lock_bh(&sk->sk_receive_queue.lock);
+
+       if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+               goto err;
+
+       if (!sk_rmem_schedule(sk, skb, skb->truesize))
+               goto err;
+
+       skb_set_owner_r(skb, sk);
+       spin_unlock_bh(&sk->sk_receive_queue.lock);
+
+       skb->destructor = udp_sock_rfree;
+       return 0;
+
+err:
+       spin_unlock_bh(&sk->sk_receive_queue.lock);
+       return -EAGAIN;
+}
+
 int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 {
        int family = sk->sk_family == AF_INET ? UDP_BPF_IPV4 : UDP_BPF_IPV6;
@@ -166,6 +202,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
        if (sk->sk_family == AF_INET6)
                udp_bpf_check_v6_needs_rebuild(psock->sk_proto);

+       psock->ingress_charge = udp_psock_ingress_charge;
        sock_replace_proto(sk, &udp_bpf_prots[family]);
        return 0;
 } 

