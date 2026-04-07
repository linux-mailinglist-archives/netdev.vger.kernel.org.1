Return-Path: <netdev+bounces-275867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KYQLaqU1GknvgcAu9opvQ
	(envelope-from <netdev+bounces-275867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 07:22:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAD93A9E5E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 07:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E092E300E3DC
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 05:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A987358391;
	Tue,  7 Apr 2026 05:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G4ajPxQE"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5D350A1B
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539368; cv=none; b=Kx96+Bf+9lSHmNXzhBm3OpZIlcNeRl8Dx+i0fIKHP9YeFvPqtFUvCb/zwSv5riJ+94QQaphZAXnwJmBwXCLuriwkcqs8nYWGMtKsihsNEdPv94gtoGtGQgvRpgAiMrvm9AWfF3vTPKMkPz0uJWFBOXLp3TPIaGLZ4eBmlbWVdEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539368; c=relaxed/simple;
	bh=QztiqD9I++b/oNhpP9Y0Ds5Ll+LSUm2+YZlKLb+saAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZydn/RS2olnFyfVqfqWKeKzRHpxbPixddlMo3Cpwal5HZ7lA3LVr1Ot2YvjVKQoyM+6Nm4YCRzESfOdDNON6HG8jJ2SKSPVXw0yrUORHAKky7xtOL5D8uUzVPEVLycJ7ugTAm7W7zd0S6wNJC+p6hQ2ZT2OSieXqmgWPtyeWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G4ajPxQE; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4820d99b-f2c4-4b24-b90f-87e6444284c4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775539364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/iXan8nV4kB8ZUCvJ2/9OpuNtxyrMdZk0L9YzN+q68=;
	b=G4ajPxQEucOJG0NhhTyg6AghI90e/9TuxZcxe7YuZslQ6dgREI5mBLTwXJX1Bq8SNUobIJ
	akZVcFogvNqt/t0AGSUyDY04M3MLgXgq3gDGz1DPH0htQPmJ9BIyKUHpNGhDjjGRx1Zlo2
	hk8cK3TG5bzRObplU4zHJpgylCfGQNg=
Date: Tue, 7 Apr 2026 13:22:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v6 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260403015851.148209-1-jiayuan.chen@linux.dev>
 <20260403015851.148209-2-jiayuan.chen@linux.dev>
 <20264619471.he8Q.martin.lau@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20264619471.he8Q.martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275867-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 2CAD93A9E5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/7/26 3:53 AM, Martin KaFai Lau wrote:
> On Fri, Apr 03, 2026 at 09:58:27AM +0800, Jiayuan Chen wrote:
>> bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does not
>> check the L4 protocol in the IP header. A BPF program can call this kfunc
>> on a UDP skb with a valid TCP listener socket, which will succeed and
>> attach a TCP reqsk to the UDP skb.
>>
>> When the UDP skb enters the UDP receive path, skb_steal_sock() returns
>> the TCP listener from the reqsk. The UDP code then passes this TCP socket
>> to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
>> it to udp_sock and accesses UDP-specific fields at invalid offsets,
>> causing a null pointer dereference and kernel panic:
>>
>>    BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
>>    Read of size 4 at addr 0000000000000008 by task test_progs/537
>>
>>    CPU: 1 UID: 0 PID: 537 Comm: test_progs Not tainted 7.0.0-rc4+ #46 PREEMPT
>>    Call Trace:
>>     <IRQ>
>>     dump_stack_lvl (lib/dump_stack.c:123)
>>     print_report (mm/kasan/report.c:487)
>>     kasan_report (mm/kasan/report.c:597)
>>     __kasan_check_read (mm/kasan/shadow.c:32)
>>     __udp_enqueue_schedule_skb (net/ipv4/udp.c:1719)
>>     udp_queue_rcv_one_skb (net/ipv4/udp.c:2370 net/ipv4/udp.c:2500)
>>     udp_queue_rcv_skb (net/ipv4/udp.c:2532)
>>     udp_unicast_rcv_skb (net/ipv4/udp.c:2684)
>>     __udp4_lib_rcv (net/ipv4/udp.c:2742)
>>     udp_rcv (net/ipv4/udp.c:2937)
>>     ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
>>     ip_local_deliver_finish (./include/linux/rcupdate.h:879 net/ipv4/ip_input.c:242)
>>     ip_local_deliver (net/ipv4/ip_input.c:265)
>>     __netif_receive_skb_one_core (net/core/dev.c:6164 (discriminator 4))
>>     __netif_receive_skb (net/core/dev.c:6280)
>>
>> Fix this by checking the IP header's protocol field in
>> bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.
>>
>> Note that for IPv6, the nexthdr check does not walk extension headers.
>> This is uncommon for TCP SYN packets in practice, and keeping it simple
>> was agreed upon by Kuniyuki Iwashima.
> sashiko has flagged a similar issue with larger scope.
> Please take a look. Thanks.
>
> https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%40linux.dev


Thanks a lot Martin, sashiko actually dug into a deeper issue here.

Eric and Kuniyuki,

I think the AI review has a point. Since BPF can modify skb fields, the
following sequence still bypasses the protocol check in 
bpf_sk_assign_tcp_reqsk():

    // for a UDP skb
    iph->protocol = TCP
    bpf_sk_assign_tcp_reqsk()
    iph->protocol = UDP

On top of that, bpf_sk_assign() already has the same problem — it doesn't
validate L4 protocol at all.

So I think we should add a check matching skb against sk in 
skb_steal_sock() instead of adding check in bpf helper.
(Also, we probably need some MIB counters for this.)



Below is my diff:

//The core reason for passing protocol as a parameter rather than 
reading it from
//the skb is that IPv6 extension headers make it non-trivial to get the 
actual nexthdr.
//It's much simpler to just let the caller tell us what protocol it expects.

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index c16de5b7963fd..c1032bb9ea864 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -104,12 +104,13 @@ static inline
  struct sock *inet6_steal_sock(struct net *net, struct sk_buff *skb, 
int doff,
                               const struct in6_addr *saddr, const 
__be16 sport,
                               const struct in6_addr *daddr, const 
__be16 dport,
-                             bool *refcounted, inet6_ehashfn_t *ehashfn)
+                             bool *refcounted, inet6_ehashfn_t *ehashfn,
+                             int protocol)
  {
         struct sock *sk, *reuse_sk;
         bool prefetched;

-       sk = skb_steal_sock(skb, refcounted, &prefetched);
+       sk = skb_steal_sock(skb, refcounted, &prefetched, protocol);
         if (!sk)
                 return NULL;

@@ -151,7 +152,7 @@ static inline struct sock *__inet6_lookup_skb(struct 
sk_buff *skb, int doff,
         struct sock *sk;

         sk = inet6_steal_sock(net, skb, doff, &ip6h->saddr, sport, 
&ip6h->daddr, dport,
-                             refcounted, inet6_ehashfn);
+                             refcounted, inet6_ehashfn, IPPROTO_TCP);
         if (IS_ERR(sk))
                 return NULL;
         if (sk)
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5a979dcab5383..0ad73135ece7d 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -433,12 +433,13 @@ static inline
  struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int 
doff,
                              const __be32 saddr, const __be16 sport,
                              const __be32 daddr, const __be16 dport,
-                            bool *refcounted, inet_ehashfn_t *ehashfn)
+                            bool *refcounted, inet_ehashfn_t *ehashfn,
+                            int protocol)
  {
         struct sock *sk, *reuse_sk;
         bool prefetched;

-       sk = skb_steal_sock(skb, refcounted, &prefetched);
+       sk = skb_steal_sock(skb, refcounted, &prefetched, protocol);
         if (!sk)
                 return NULL;

@@ -469,7 +470,7 @@ struct sock *inet_steal_sock(struct net *net, struct 
sk_buff *skb, int doff,
         return reuse_sk;
  }

-static inline struct sock *__inet_lookup_skb(struct sk_buff *skb,
+static inline struct sock *__tcp_lookup_skb(struct sk_buff *skb,
                                              int doff,
                                              const __be16 sport,
                                              const __be16 dport,
@@ -481,7 +482,7 @@ static inline struct sock *__inet_lookup_skb(struct 
sk_buff *skb,
         struct sock *sk;

         sk = inet_steal_sock(net, skb, doff, iph->saddr, sport, 
iph->daddr, dport,
-                            refcounted, inet_ehashfn);
+                            refcounted, inet_ehashfn, IPPROTO_TCP);
         if (IS_ERR(sk))
                 return NULL;
         if (sk)
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 5a9c826a7092d..80bd209b2323b 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -91,7 +91,8 @@ static inline struct sock *req_to_sk(struct 
request_sock *req)
   * @prefetched: is set to true if the socket was assigned from bpf
   */
  static inline struct sock *skb_steal_sock(struct sk_buff *skb,
-                                         bool *refcounted, bool 
*prefetched)
+                                         bool *refcounted, bool 
*prefetched,
+                                         int protocol)
  {
         struct sock *sk = skb->sk;

@@ -103,6 +104,24 @@ static inline struct sock *skb_steal_sock(struct 
sk_buff *skb,

         *prefetched = skb_sk_is_prefetched(skb);
         if (*prefetched) {
+               /* Validate that the stolen socket matches the expected L4
+                * protocol.  BPF (bpf_sk_assign) can mistakenly or 
maliciously
+                * assign a socket of the wrong type.  If the protocols 
don't
+                * match, clean up the assignment and return NULL so the 
caller
+                * falls through to the normal hash table lookup.
+                *
+                * For full sockets, check sk_protocol directly.
+                * For request sockets (only created by 
bpf_sk_assign_tcp_reqsk),
+                * sk_protocol is not in sock_common and cannot be accessed.
+                * Request sockets are always TCP, so assume IPPROTO_TCP.
+                */
+               if ((sk_fullsock(sk) ? sk->sk_protocol : IPPROTO_TCP) != 
protocol) {
+                       skb_orphan(skb);
+                       *prefetched = false;
+                       *refcounted = false;
+                       return NULL;
+               }
+
  #if IS_ENABLED(CONFIG_SYN_COOKIES)
                 if (sk->sk_state == TCP_NEW_SYN_RECV && 
inet_reqsk(sk)->syncookie) {
                         struct request_sock *req = inet_reqsk(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c7b2463c2e254..442a9379aefe6 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2188,7 +2188,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
         th = (const struct tcphdr *)skb->data;
         iph = ip_hdr(skb);
  lookup:
-       sk = __inet_lookup_skb(skb, __tcp_hdrlen(th), th->source,
+       sk = __tcp_lookup_skb(skb, __tcp_hdrlen(th), th->source,
                                th->dest, sdif, &refcounted);
         if (!sk)
                 goto no_tcp_socket;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b60fad393e182..61f7fbf5ffd9c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2728,7 +2728,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct 
udp_table *udptable,
                 goto csum_error;

         sk = inet_steal_sock(net, skb, sizeof(struct udphdr), saddr, 
uh->source, daddr, uh->dest,
-                            &refcounted, udp_ehashfn);
+                            &refcounted, udp_ehashfn, IPPROTO_UDP);
         if (IS_ERR(sk))
                 goto no_sk;

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 010b909275dd0..9c3c25c938ec8 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1115,7 +1115,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct 
udp_table *udptable,

         /* Check if the socket is already available, e.g. due to early 
demux */
         sk = inet6_steal_sock(net, skb, sizeof(struct udphdr), saddr, 
uh->source, daddr, uh->dest,
-                             &refcounted, udp6_ehashfn);
+                             &refcounted, udp6_ehashfn, IPPROTO_UDP);
         if (IS_ERR(sk))
                 goto no_sk;




---
This fix touches the net core path (skb_steal_sock / inet_steal_sock),
so it probably makes more sense to review it on the net side rather than 
the bpf side.


