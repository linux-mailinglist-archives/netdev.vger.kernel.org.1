Return-Path: <netdev+bounces-306907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id km/jESXxUmp5VgMAu9opvQ
	(envelope-from <netdev+bounces-306907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:43:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A17436DB
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 03:43:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pj7GlVV9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LMRvrqVJ;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pj7GlVV9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LMRvrqVJ;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306907-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306907-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 229EA3042413
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9D821CA13;
	Sun, 12 Jul 2026 01:40:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0D22126C
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 01:40:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820454; cv=none; b=nhxuDefLaDbfveLt/FMFvZ2Ho7gESzTz80n0flGvMq6BPCUYaIzADoo23KMvurA5+NrWLR8+jwWbPvGx8+4NTiIo0bDqrettG2MLTNsNXyj1Wxf3idDLM1bs0ooT0j3gLBP3fNNd5ySzE3laixjHAMIA38HNq7I+m047HWJHkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820454; c=relaxed/simple;
	bh=a/6e+jqBC0gdgJnnn2It/VoP89g+aClO1nJQWcG6GT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHOkOabVfcRsDUOaZmSNd4PPZZqJrl4w2NG6wTeDjvQT3T0S/hXPduXxg0GZE7vCXwcjGIP1MBhUGL/zTFHjqjV8QDxgvs/vFpgYSSdd5o+bqZgLebRsfGVbMtdXWjfUehgvL0YEFRH/u3ovbtVYznoYz6x29KnUACjryr1qBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pj7GlVV9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LMRvrqVJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pj7GlVV9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LMRvrqVJ; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE1CE76DC1;
	Sun, 12 Jul 2026 01:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfQC2SYfKWUb22kl1d2+kw5/smQYoifo6rg519eJl2g=;
	b=pj7GlVV9vsm9JWBq1f6ggRLciGJKcgUoKLLedw5Ih+w3/GGDN8h1Vk34A27v6bEmNvfyqc
	7c4OqWsm5NxZ3rLp5gQQTlT4YEAQ5cwz5VrBYjf+YzJOaaamkc4V4aTkhdl8T4n56e6Hdb
	jw7nZeh2NUBYR2lyb/wgad+J2fZNQng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfQC2SYfKWUb22kl1d2+kw5/smQYoifo6rg519eJl2g=;
	b=LMRvrqVJF0sLCha9vDQlcBiDbdamAhx4WFR923YEzABLyiwGQvol+Uq+oVfr4vPLxjqCVN
	6nn/6zxBfCmld9DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783820441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfQC2SYfKWUb22kl1d2+kw5/smQYoifo6rg519eJl2g=;
	b=pj7GlVV9vsm9JWBq1f6ggRLciGJKcgUoKLLedw5Ih+w3/GGDN8h1Vk34A27v6bEmNvfyqc
	7c4OqWsm5NxZ3rLp5gQQTlT4YEAQ5cwz5VrBYjf+YzJOaaamkc4V4aTkhdl8T4n56e6Hdb
	jw7nZeh2NUBYR2lyb/wgad+J2fZNQng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783820441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfQC2SYfKWUb22kl1d2+kw5/smQYoifo6rg519eJl2g=;
	b=LMRvrqVJF0sLCha9vDQlcBiDbdamAhx4WFR923YEzABLyiwGQvol+Uq+oVfr4vPLxjqCVN
	6nn/6zxBfCmld9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F761779B5;
	Sun, 12 Jul 2026 01:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YPXoG5jwUmqRegAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 12 Jul 2026 01:40:40 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	idosch@nvidia.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Kees Cook <kees@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 04/13 RFC net-next] net: tcp: move protocol agnostic TCP functions out of tcp_ipv4.c
Date: Sun, 12 Jul 2026 03:39:02 +0200
Message-ID: <20260712013941.4570-5-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260712013941.4570-1-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,suse.de,gmail.com,cloudflare.com,linux.dev,queasysnail.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306907-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:fmancera@suse.de,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:willemb@google.com,m:kees@kernel.org,m:richardbgobert@gmail.com,m:sd@queasysnail.net,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:from_mime,suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 767A17436DB

As the tcp_ipv4.c file isn't compile anymore with CONFIG_IPV4=n, the
generic TCP function must be moved out of tcp_ipv4.c file and they
should be placed in tcp.c file.

As part of this migration, rename tcp_v4_destroy_sock() to
tcp_destroy_sock() to reflect its shared usage by IPv4 and IPv6.

In addition, guard IPv4 code around IPv6 TCP implementation. This
ensures that IPv4-mapped IPv6 sockects are rejected with a proper error
code when IPv4 stack is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 include/net/tcp.h               |   16 +-
 net/ipv4/af_inet.c              |    8 +
 net/ipv4/inet_connection_sock.c |    2 +-
 net/ipv4/proc.c                 |    2 +
 net/ipv4/tcp.c                  | 1291 ++++++++++++++++++++++++++++++
 net/ipv4/tcp_bpf.c              |    2 +
 net/ipv4/tcp_ipv4.c             | 1299 +------------------------------
 net/ipv6/ipv6_sockglue.c        |    5 +
 net/ipv6/tcp_ipv6.c             |   25 +-
 9 files changed, 1348 insertions(+), 1302 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d376ea4d1c0..5d4736aa6152 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2420,7 +2420,7 @@ struct tcp_iter_state {
 extern struct request_sock_ops tcp_request_sock_ops;
 extern struct request_sock_ops tcp6_request_sock_ops;
 
-void tcp_v4_destroy_sock(struct sock *sk);
+void tcp_destroy_sock(struct sock *sk);
 
 struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 				netdev_features_t features);
@@ -2838,6 +2838,20 @@ struct sk_psock;
 #ifdef CONFIG_BPF_SYSCALL
 int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
+
+union bpf_tcp_iter_batch_item {
+	struct sock *sk;
+	__u64 cookie;
+};
+
+struct bpf_tcp_iter_state {
+	struct tcp_iter_state state;
+	unsigned int cur_sk;
+	unsigned int end_sk;
+	unsigned int max_sk;
+	union bpf_tcp_iter_batch_item *batch;
+};
+
 #ifdef CONFIG_BPF_STREAM_PARSER
 struct strparser;
 int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index cd8e129394e4..863d00973eb5 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1955,6 +1955,7 @@ static int __init inet_init(void)
 #if IS_ENABLED(CONFIG_IPV4)
 	raw_hashinfo_init(&raw_v4_hashinfo);
 
+#if IS_ENABLED(CONFIG_IPV4)
 	rc = proto_register(&tcp_prot, 1);
 	if (rc)
 		goto out;
@@ -2002,6 +2003,7 @@ static int __init inet_init(void)
 	};
 	if (inet_add_protocol(&net_hotdata.tcp_protocol, IPPROTO_TCP) < 0)
 		pr_crit("%s: Cannot add TCP protocol\n", __func__);
+#endif
 #ifdef CONFIG_IP_MULTICAST
 	if (inet_add_protocol(&igmp_protocol, IPPROTO_IGMP) < 0)
 		pr_crit("%s: Cannot add IGMP protocol\n", __func__);
@@ -2075,7 +2077,9 @@ static int __init inet_init(void)
 out_unregister_udp_proto:
 	proto_unregister(&udp_prot);
 out_unregister_tcp_proto:
+#if IS_ENABLED(CONFIG_IPV4)
 	proto_unregister(&tcp_prot);
+#endif
 	goto out;
 #endif
 }
@@ -2092,8 +2096,10 @@ static int __init ipv4_proc_init(void)
 
 	if (raw_proc_init())
 		goto out_raw;
+#if IS_ENABLED(CONFIG_IPV4)
 	if (tcp4_proc_init())
 		goto out_tcp;
+#endif
 	if (udp4_proc_init())
 		goto out_udp;
 	if (ping_proc_init())
@@ -2107,8 +2113,10 @@ static int __init ipv4_proc_init(void)
 out_ping:
 	udp4_proc_exit();
 out_udp:
+#if IS_ENABLED(CONFIG_IPV4)
 	tcp4_proc_exit();
 out_tcp:
+#endif
 	raw_proc_exit();
 out_raw:
 	rc = -ENOMEM;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 56902bba5483..02a80c1cf1e3 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1371,7 +1371,7 @@ static void inet_child_forget(struct sock *sk, struct request_sock *req,
 		 * an inbound pkt destined for child is
 		 * blocked by sock lock in tcp_v4_rcv().
 		 * Also to satisfy an assertion in
-		 * tcp_v4_destroy_sock().
+		 * tcp_destroy_sock().
 		 */
 		RCU_INIT_POINTER(tcp_sk(child)->fastopen_rsk, NULL);
 	}
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index bfc06d1713ec..b7f4e5ecf64d 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -50,6 +50,7 @@
  */
 static int sockstat_seq_show(struct seq_file *seq, void *v)
 {
+#if IS_ENABLED(CONFIG_IPV4)
 	struct net *net = seq->private;
 	int orphans, sockets;
 
@@ -69,6 +70,7 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
 	seq_printf(seq,  "FRAG: inuse %u memory %lu\n",
 		   atomic_read(&net->ipv4.fqdir->rhashtable.nelems),
 		   frag_mem_limit(net->ipv4.fqdir));
+#endif
 	return 0;
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b694..088e5c368c2e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -267,6 +267,8 @@
 #include <linux/errqueue.h>
 #include <linux/static_key.h>
 #include <linux/btf.h>
+#include <linux/proc_fs.h>
+#include <linux/skbuff_ref.h>
 
 #include <net/icmp.h>
 #include <net/inet_common.h>
@@ -308,6 +310,10 @@ DEFINE_STATIC_KEY_FALSE(tcp_have_smc);
 EXPORT_SYMBOL(tcp_have_smc);
 #endif
 
+struct inet_hashinfo tcp_hashinfo;
+
+static DEFINE_MUTEX(tcp_exit_batch_mutex);
+
 /*
  * Current number of TCP sockets.
  */
@@ -1455,6 +1461,1107 @@ int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 }
 EXPORT_SYMBOL(tcp_sendmsg);
 
+#ifdef CONFIG_PROC_FS
+/* Proc filesystem TCP sock list dumping. */
+
+static unsigned short seq_file_family(const struct seq_file *seq);
+
+static bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
+{
+	unsigned short family = seq_file_family(seq);
+
+	/* AF_UNSPEC is used as a match all */
+	return ((family == AF_UNSPEC || family == sk->sk_family) &&
+		net_eq(sock_net(sk), seq_file_net(seq)));
+}
+
+/* Find a non empty bucket (starting from st->bucket)
+ * and return the first sk from it.
+ */
+static void *listening_get_first(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct tcp_iter_state *st = seq->private;
+
+	st->offset = 0;
+	for (; st->bucket <= hinfo->lhash2_mask; st->bucket++) {
+		struct inet_listen_hashbucket *ilb2;
+		struct hlist_nulls_node *node;
+		struct sock *sk;
+
+		ilb2 = &hinfo->lhash2[st->bucket];
+		if (hlist_nulls_empty(&ilb2->nulls_head))
+			continue;
+
+		spin_lock(&ilb2->lock);
+		sk_nulls_for_each(sk, node, &ilb2->nulls_head) {
+			if (seq_sk_match(seq, sk))
+				return sk;
+		}
+		spin_unlock(&ilb2->lock);
+	}
+
+	return NULL;
+}
+
+/* Find the next sk of "cur" within the same bucket (i.e. st->bucket).
+ * If "cur" is the last one in the st->bucket,
+ * call listening_get_first() to return the first sk of the next
+ * non empty bucket.
+ */
+static void *listening_get_next(struct seq_file *seq, void *cur)
+{
+	struct tcp_iter_state *st = seq->private;
+	struct inet_listen_hashbucket *ilb2;
+	struct hlist_nulls_node *node;
+	struct inet_hashinfo *hinfo;
+	struct sock *sk = cur;
+
+	++st->num;
+	++st->offset;
+
+	sk = sk_nulls_next(sk);
+	sk_nulls_for_each_from(sk, node) {
+		if (seq_sk_match(seq, sk))
+			return sk;
+	}
+
+	hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	ilb2 = &hinfo->lhash2[st->bucket];
+	spin_unlock(&ilb2->lock);
+	++st->bucket;
+	return listening_get_first(seq);
+}
+
+static void *listening_get_idx(struct seq_file *seq, loff_t *pos)
+{
+	struct tcp_iter_state *st = seq->private;
+	void *rc;
+
+	st->bucket = 0;
+	st->offset = 0;
+	rc = listening_get_first(seq);
+
+	while (rc && *pos) {
+		rc = listening_get_next(seq, rc);
+		--*pos;
+	}
+	return rc;
+}
+
+static inline bool empty_bucket(struct inet_hashinfo *hinfo,
+				const struct tcp_iter_state *st)
+{
+	return hlist_nulls_empty(&hinfo->ehash[st->bucket].chain);
+}
+
+/*
+ * Get first established socket starting from bucket given in st->bucket.
+ * If st->bucket is zero, the very first socket in the hash is returned.
+ */
+static void *established_get_first(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct tcp_iter_state *st = seq->private;
+
+	st->offset = 0;
+	for (; st->bucket <= hinfo->ehash_mask; ++st->bucket) {
+		struct sock *sk;
+		struct hlist_nulls_node *node;
+		spinlock_t *lock = inet_ehash_lockp(hinfo, st->bucket);
+
+		cond_resched();
+
+		/* Lockless fast path for the common case of empty buckets */
+		if (empty_bucket(hinfo, st))
+			continue;
+
+		spin_lock_bh(lock);
+		sk_nulls_for_each(sk, node, &hinfo->ehash[st->bucket].chain) {
+			if (seq_sk_match(seq, sk))
+				return sk;
+		}
+		spin_unlock_bh(lock);
+	}
+
+	return NULL;
+}
+
+static void *established_get_next(struct seq_file *seq, void *cur)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct tcp_iter_state *st = seq->private;
+	struct hlist_nulls_node *node;
+	struct sock *sk = cur;
+
+	++st->num;
+	++st->offset;
+
+	sk = sk_nulls_next(sk);
+
+	sk_nulls_for_each_from(sk, node) {
+		if (seq_sk_match(seq, sk))
+			return sk;
+	}
+
+	spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+	++st->bucket;
+	return established_get_first(seq);
+}
+
+static void *established_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct tcp_iter_state *st = seq->private;
+	void *rc;
+
+	st->bucket = 0;
+	rc = established_get_first(seq);
+
+	while (rc && pos) {
+		rc = established_get_next(seq, rc);
+		--pos;
+	}
+	return rc;
+}
+
+static void *tcp_get_idx(struct seq_file *seq, loff_t pos)
+{
+	void *rc;
+	struct tcp_iter_state *st = seq->private;
+
+	st->state = TCP_SEQ_STATE_LISTENING;
+	rc	  = listening_get_idx(seq, &pos);
+
+	if (!rc) {
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		rc	  = established_get_idx(seq, pos);
+	}
+
+	return rc;
+}
+
+static void *tcp_seek_last_pos(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct tcp_iter_state *st = seq->private;
+	int bucket = st->bucket;
+	int offset = st->offset;
+	int orig_num = st->num;
+	void *rc = NULL;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+		if (st->bucket > hinfo->lhash2_mask)
+			break;
+		rc = listening_get_first(seq);
+		while (offset-- && rc && bucket == st->bucket)
+			rc = listening_get_next(seq, rc);
+		if (rc)
+			break;
+		st->bucket = 0;
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		fallthrough;
+	case TCP_SEQ_STATE_ESTABLISHED:
+		if (st->bucket > hinfo->ehash_mask)
+			break;
+		rc = established_get_first(seq);
+		while (offset-- && rc && bucket == st->bucket)
+			rc = established_get_next(seq, rc);
+	}
+
+	st->num = orig_num;
+
+	return rc;
+}
+
+void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	struct tcp_iter_state *st = seq->private;
+	void *rc;
+
+	if (*pos && *pos == st->last_pos) {
+		rc = tcp_seek_last_pos(seq);
+		if (rc)
+			goto out;
+	}
+
+	st->state = TCP_SEQ_STATE_LISTENING;
+	st->num = 0;
+	st->bucket = 0;
+	st->offset = 0;
+	rc = *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
+
+out:
+	st->last_pos = *pos;
+	return rc;
+}
+
+void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct tcp_iter_state *st = seq->private;
+	void *rc = NULL;
+
+	if (v == SEQ_START_TOKEN) {
+		rc = tcp_get_idx(seq, 0);
+		goto out;
+	}
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+		rc = listening_get_next(seq, v);
+		if (!rc) {
+			st->state = TCP_SEQ_STATE_ESTABLISHED;
+			st->bucket = 0;
+			st->offset = 0;
+			rc	  = established_get_first(seq);
+		}
+		break;
+	case TCP_SEQ_STATE_ESTABLISHED:
+		rc = established_get_next(seq, v);
+		break;
+	}
+out:
+	++*pos;
+	st->last_pos = *pos;
+	return rc;
+}
+
+void tcp_seq_stop(struct seq_file *seq, void *v)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct tcp_iter_state *st = seq->private;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+		if (v != SEQ_START_TOKEN)
+			spin_unlock(&hinfo->lhash2[st->bucket].lock);
+		break;
+	case TCP_SEQ_STATE_ESTABLISHED:
+		if (v)
+			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+		break;
+	}
+}
+
+#ifdef CONFIG_BPF_SYSCALL
+struct bpf_iter__tcp {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct sock_common *, sk_common);
+	uid_t uid __aligned(8);
+};
+
+static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
+			     struct sock_common *sk_common, uid_t uid)
+{
+	struct bpf_iter__tcp ctx;
+
+	meta->seq_num--;  /* skip SEQ_START_TOKEN */
+	ctx.meta = meta;
+	ctx.sk_common = sk_common;
+	ctx.uid = uid;
+	return bpf_iter_run_prog(prog, &ctx);
+}
+
+static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
+{
+	union bpf_tcp_iter_batch_item *item;
+	unsigned int cur_sk = iter->cur_sk;
+	__u64 cookie;
+
+	/* Remember the cookies of the sockets we haven't seen yet, so we can
+	 * pick up where we left off next time around.
+	 */
+	while (cur_sk < iter->end_sk) {
+		item = &iter->batch[cur_sk++];
+		cookie = sock_gen_cookie(item->sk);
+		sock_gen_put(item->sk);
+		item->cookie = cookie;
+	}
+}
+
+static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
+				      unsigned int new_batch_sz, gfp_t flags)
+{
+	union bpf_tcp_iter_batch_item *new_batch;
+
+	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
+			     flags | __GFP_NOWARN);
+	if (!new_batch)
+		return -ENOMEM;
+
+	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
+	kvfree(iter->batch);
+	iter->batch = new_batch;
+	iter->max_sk = new_batch_sz;
+
+	return 0;
+}
+
+static struct sock *bpf_iter_tcp_resume_bucket(struct sock *first_sk,
+					       union bpf_tcp_iter_batch_item *cookies,
+					       int n_cookies)
+{
+	struct hlist_nulls_node *node;
+	struct sock *sk;
+	int i;
+
+	for (i = 0; i < n_cookies; i++) {
+		sk = first_sk;
+		sk_nulls_for_each_from(sk, node)
+			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
+				return sk;
+	}
+
+	return NULL;
+}
+
+static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	unsigned int find_cookie = iter->cur_sk;
+	unsigned int end_cookie = iter->end_sk;
+	int resume_bucket = st->bucket;
+	struct sock *sk;
+
+	if (end_cookie && find_cookie == end_cookie)
+		++st->bucket;
+
+	sk = listening_get_first(seq);
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	if (sk && st->bucket == resume_bucket && end_cookie) {
+		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
+						end_cookie - find_cookie);
+		if (!sk) {
+			spin_unlock(&hinfo->lhash2[st->bucket].lock);
+			++st->bucket;
+			sk = listening_get_first(seq);
+		}
+	}
+
+	return sk;
+}
+
+static struct sock *bpf_iter_tcp_resume_established(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	unsigned int find_cookie = iter->cur_sk;
+	unsigned int end_cookie = iter->end_sk;
+	int resume_bucket = st->bucket;
+	struct sock *sk;
+
+	if (end_cookie && find_cookie == end_cookie)
+		++st->bucket;
+
+	sk = established_get_first(seq);
+	iter->cur_sk = 0;
+	iter->end_sk = 0;
+
+	if (sk && st->bucket == resume_bucket && end_cookie) {
+		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
+						end_cookie - find_cookie);
+		if (!sk) {
+			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+			++st->bucket;
+			sk = established_get_first(seq);
+		}
+	}
+
+	return sk;
+}
+
+static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	struct sock *sk = NULL;
+
+	switch (st->state) {
+	case TCP_SEQ_STATE_LISTENING:
+		sk = bpf_iter_tcp_resume_listening(seq);
+		if (sk)
+			break;
+		st->bucket = 0;
+		st->state = TCP_SEQ_STATE_ESTABLISHED;
+		fallthrough;
+	case TCP_SEQ_STATE_ESTABLISHED:
+		sk = bpf_iter_tcp_resume_established(seq);
+		break;
+	}
+
+	return sk;
+}
+
+static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
+						 struct sock **start_sk)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct hlist_nulls_node *node;
+	unsigned int expected = 1;
+	struct sock *sk;
+
+	sock_hold(*start_sk);
+	iter->batch[iter->end_sk++].sk = *start_sk;
+
+	sk = sk_nulls_next(*start_sk);
+	*start_sk = NULL;
+	sk_nulls_for_each_from(sk, node) {
+		if (seq_sk_match(seq, sk)) {
+			if (iter->end_sk < iter->max_sk) {
+				sock_hold(sk);
+				iter->batch[iter->end_sk++].sk = sk;
+			} else if (!*start_sk) {
+				/* Remember where we left off. */
+				*start_sk = sk;
+			}
+			expected++;
+		}
+	}
+
+	return expected;
+}
+
+static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
+						   struct sock **start_sk)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct hlist_nulls_node *node;
+	unsigned int expected = 1;
+	struct sock *sk;
+
+	sock_hold(*start_sk);
+	iter->batch[iter->end_sk++].sk = *start_sk;
+
+	sk = sk_nulls_next(*start_sk);
+	*start_sk = NULL;
+	sk_nulls_for_each_from(sk, node) {
+		if (seq_sk_match(seq, sk)) {
+			if (iter->end_sk < iter->max_sk) {
+				sock_hold(sk);
+				iter->batch[iter->end_sk++].sk = sk;
+			} else if (!*start_sk) {
+				/* Remember where we left off. */
+				*start_sk = sk;
+			}
+			expected++;
+		}
+	}
+
+	return expected;
+}
+
+static unsigned int bpf_iter_fill_batch(struct seq_file *seq,
+					struct sock **start_sk)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+
+	if (st->state == TCP_SEQ_STATE_LISTENING)
+		return bpf_iter_tcp_listening_batch(seq, start_sk);
+	else
+		return bpf_iter_tcp_established_batch(seq, start_sk);
+}
+
+static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
+{
+	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+
+	if (st->state == TCP_SEQ_STATE_LISTENING)
+		spin_unlock(&hinfo->lhash2[st->bucket].lock);
+	else
+		spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
+}
+
+static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	unsigned int expected;
+	struct sock *sk;
+	int err;
+
+	sk = bpf_iter_tcp_resume(seq);
+	if (!sk)
+		return NULL; /* Done */
+
+	expected = bpf_iter_fill_batch(seq, &sk);
+	if (likely(iter->end_sk == expected))
+		goto done;
+
+	/* Batch size was too small. */
+	bpf_iter_tcp_unlock_bucket(seq);
+	bpf_iter_tcp_put_batch(iter);
+	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+					 GFP_USER);
+	if (err)
+		return ERR_PTR(err);
+
+	sk = bpf_iter_tcp_resume(seq);
+	if (!sk)
+		return NULL; /* Done */
+
+	expected = bpf_iter_fill_batch(seq, &sk);
+	if (likely(iter->end_sk == expected))
+		goto done;
+
+	/* Batch size was still too small. Hold onto the lock while we try
+	 * again with a larger batch to make sure the current bucket's size
+	 * does not change in the meantime.
+	 */
+	err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
+	if (err) {
+		bpf_iter_tcp_unlock_bucket(seq);
+		return ERR_PTR(err);
+	}
+
+	expected = bpf_iter_fill_batch(seq, &sk);
+	WARN_ON_ONCE(iter->end_sk != expected);
+done:
+	bpf_iter_tcp_unlock_bucket(seq);
+	return iter->batch[0].sk;
+}
+
+static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	/* bpf iter does not support lseek, so it always
+	 * continue from where it was stop()-ped.
+	 */
+	if (*pos)
+		return bpf_iter_tcp_batch(seq);
+
+	return SEQ_START_TOKEN;
+}
+
+static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct tcp_iter_state *st = &iter->state;
+	struct sock *sk;
+
+	/* Whenever seq_next() is called, the iter->cur_sk is
+	 * done with seq_show(), so advance to the next sk in
+	 * the batch.
+	 */
+	if (iter->cur_sk < iter->end_sk) {
+		/* Keeping st->num consistent in tcp_iter_state.
+		 * bpf_iter_tcp does not use st->num.
+		 * meta.seq_num is used instead.
+		 */
+		st->num++;
+		sock_gen_put(iter->batch[iter->cur_sk++].sk);
+	}
+
+	if (iter->cur_sk < iter->end_sk)
+		sk = iter->batch[iter->cur_sk].sk;
+	else
+		sk = bpf_iter_tcp_batch(seq);
+
+	++*pos;
+	/* Keeping st->last_pos consistent in tcp_iter_state.
+	 * bpf iter does not do lseek, so st->last_pos always equals to *pos.
+	 */
+	st->last_pos = *pos;
+	return sk;
+}
+
+static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
+{
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+	struct sock *sk = v;
+	uid_t uid;
+	int ret;
+
+	if (v == SEQ_START_TOKEN)
+		return 0;
+
+	if (sk_fullsock(sk))
+		lock_sock(sk);
+
+	if (unlikely(sk_unhashed(sk))) {
+		ret = SEQ_SKIP;
+		goto unlock;
+	}
+
+	if (sk->sk_state == TCP_TIME_WAIT) {
+		uid = 0;
+	} else if (sk->sk_state == TCP_NEW_SYN_RECV) {
+		const struct request_sock *req = v;
+
+		uid = from_kuid_munged(seq_user_ns(seq),
+				       sk_uid(req->rsk_listener));
+	} else {
+		uid = from_kuid_munged(seq_user_ns(seq), sk_uid(sk));
+	}
+
+	meta.seq = seq;
+	prog = bpf_iter_get_info(&meta, false);
+	ret = tcp_prog_seq_show(prog, &meta, v, uid);
+
+unlock:
+	if (sk_fullsock(sk))
+		release_sock(sk);
+	return ret;
+}
+
+static void bpf_iter_tcp_seq_stop(struct seq_file *seq, void *v)
+{
+	struct bpf_tcp_iter_state *iter = seq->private;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+
+	if (!v) {
+		meta.seq = seq;
+		prog = bpf_iter_get_info(&meta, true);
+		if (prog)
+			(void)tcp_prog_seq_show(prog, &meta, v, 0);
+	}
+
+	if (iter->cur_sk < iter->end_sk)
+		bpf_iter_tcp_put_batch(iter);
+}
+
+static const struct seq_operations bpf_iter_tcp_seq_ops = {
+	.show		= bpf_iter_tcp_seq_show,
+	.start		= bpf_iter_tcp_seq_start,
+	.next		= bpf_iter_tcp_seq_next,
+	.stop		= bpf_iter_tcp_seq_stop,
+};
+#endif /* CONFIG_BPF_SYSCALL */
+
+static unsigned short seq_file_family(const struct seq_file *seq)
+{
+	const struct tcp_seq_afinfo *afinfo;
+
+#ifdef CONFIG_BPF_SYSCALL
+	/* Iterated from bpf_iter.  Let the bpf prog to filter instead. */
+	if (seq->op == &bpf_iter_tcp_seq_ops)
+		return AF_UNSPEC;
+#endif
+
+	/* Iterated from proc fs */
+	afinfo = pde_data(file_inode(seq->file));
+	return afinfo->family;
+}
+#endif /* CONFIG_PROC_FS */
+
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
+DEFINE_BPF_ITER_FUNC(tcp, struct bpf_iter_meta *meta,
+		     struct sock_common *sk_common, uid_t uid)
+
+#define INIT_BATCH_SZ 16
+
+static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	struct bpf_tcp_iter_state *iter = priv_data;
+	int err;
+
+	err = bpf_iter_init_seq_net(priv_data, aux);
+	if (err)
+		return err;
+
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
+	if (err) {
+		bpf_iter_fini_seq_net(priv_data);
+		return err;
+	}
+
+	return 0;
+}
+
+static void bpf_iter_fini_tcp(void *priv_data)
+{
+	struct bpf_tcp_iter_state *iter = priv_data;
+
+	bpf_iter_fini_seq_net(priv_data);
+	kvfree(iter->batch);
+}
+
+static const struct bpf_iter_seq_info tcp_seq_info = {
+	.seq_ops		= &bpf_iter_tcp_seq_ops,
+	.init_seq_private	= bpf_iter_init_tcp,
+	.fini_seq_private	= bpf_iter_fini_tcp,
+	.seq_priv_size		= sizeof(struct bpf_tcp_iter_state),
+};
+
+static const struct bpf_func_proto *
+bpf_iter_tcp_get_func_proto(enum bpf_func_id func_id,
+			    const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_setsockopt:
+		return &bpf_sk_setsockopt_proto;
+	case BPF_FUNC_getsockopt:
+		return &bpf_sk_getsockopt_proto;
+	default:
+		return NULL;
+	}
+}
+
+static struct bpf_iter_reg tcp_reg_info = {
+	.target			= "tcp",
+	.ctx_arg_info_size	= 1,
+	.ctx_arg_info		= {
+		{ offsetof(struct bpf_iter__tcp, sk_common),
+		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
+	},
+	.get_func_proto		= bpf_iter_tcp_get_func_proto,
+	.seq_info		= &tcp_seq_info,
+};
+
+static void __init bpf_iter_register(void)
+{
+	tcp_reg_info.ctx_arg_info[0].btf_id = btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON];
+	if (bpf_iter_reg_target(&tcp_reg_info))
+		pr_warn("Warning: could not register bpf iterator tcp\n");
+}
+
+#endif
+
+static void tcp_release_user_frags(struct sock *sk)
+{
+#ifdef CONFIG_PAGE_POOL
+	unsigned long index;
+	void *netmem;
+
+	xa_for_each(&sk->sk_user_frags, index, netmem)
+		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
+#endif
+}
+
+void tcp_destroy_sock(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	tcp_release_user_frags(sk);
+
+	xa_destroy(&sk->sk_user_frags);
+
+	trace_tcp_destroy_sock(sk);
+
+	tcp_clear_xmit_timers(sk);
+
+	tcp_cleanup_congestion_control(sk);
+
+	tcp_cleanup_ulp(sk);
+
+	/* Cleanup up the write buffer. */
+	tcp_write_queue_purge(sk);
+
+	/* Check if we want to disable active TFO */
+	tcp_fastopen_active_disable_ofo_check(sk);
+
+	/* Cleans up our, hopefully empty, out_of_order_queue. */
+	skb_rbtree_purge(&tp->out_of_order_queue);
+
+	/* Clean up a referenced TCP bind bucket. */
+	if (inet_csk(sk)->icsk_bind_hash)
+		inet_put_port(sk);
+
+	BUG_ON(rcu_access_pointer(tp->fastopen_rsk));
+
+	/* If socket is aborted during connect operation */
+	tcp_free_fastopen_req(tp);
+	tcp_fastopen_destroy_cipher(sk);
+	tcp_saved_syn_free(tp);
+
+	sk_sockets_allocated_dec(sk);
+}
+
+int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
+{
+	int reuse = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tw_reuse);
+	const struct inet_timewait_sock *tw = inet_twsk(sktw);
+	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
+	struct tcp_sock *tp = tcp_sk(sk);
+	int ts_recent_stamp;
+	u32 reuse_thresh;
+
+	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2)
+		reuse = 0;
+
+	if (reuse == 2) {
+		/* Still does not detect *everything* that goes through
+		 * lo, since we require a loopback src or dst address
+		 * or direct binding to 'lo' interface.
+		 */
+		bool loopback = false;
+
+		if (tw->tw_bound_dev_if == LOOPBACK_IFINDEX)
+			loopback = true;
+#if IS_ENABLED(CONFIG_IPV6)
+		if (tw->tw_family == AF_INET6) {
+			if (ipv6_addr_loopback(&tw->tw_v6_daddr) ||
+			    ipv6_addr_v4mapped_loopback(&tw->tw_v6_daddr) ||
+			    ipv6_addr_loopback(&tw->tw_v6_rcv_saddr) ||
+			    ipv6_addr_v4mapped_loopback(&tw->tw_v6_rcv_saddr))
+				loopback = true;
+		} else
+#endif
+		{
+			if (ipv4_is_loopback(tw->tw_daddr) ||
+			    ipv4_is_loopback(tw->tw_rcv_saddr))
+				loopback = true;
+		}
+		if (!loopback)
+			reuse = 0;
+	}
+
+	/* With PAWS, it is safe from the viewpoint
+	 * of data integrity. Even without PAWS it is safe provided sequence
+	 * spaces do not overlap i.e. at data rates <= 80Mbit/sec.
+	 *
+	 * Actually, the idea is close to VJ's one, only timestamp cache is
+	 * held not per host, but per port pair and TW bucket is used as state
+	 * holder.
+	 *
+	 * If TW bucket has been already destroyed we fall back to VJ's scheme
+	 * and use initial timestamp retrieved from peer table.
+	 */
+	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
+	reuse_thresh = READ_ONCE(tw->tw_entry_stamp) +
+		       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tw_reuse_delay);
+	if (ts_recent_stamp &&
+	    (!twp || (reuse && time_after32(tcp_clock_ms(), reuse_thresh)))) {
+		/* inet_twsk_hashdance_schedule() sets sk_refcnt after putting twsk
+		 * and releasing the bucket lock.
+		 */
+		if (unlikely(!refcount_inc_not_zero(&sktw->sk_refcnt)))
+			return 0;
+
+		/* In case of repair and re-using TIME-WAIT sockets we still
+		 * want to be sure that it is safe as above but honor the
+		 * sequence numbers and time stamps set as part of the repair
+		 * process.
+		 *
+		 * Without this check re-using a TIME-WAIT socket with TCP
+		 * repair would accumulate a -1 on the repair assigned
+		 * sequence number. The first time it is reused the sequence
+		 * is -1, the second time -2, etc. This fixes that issue
+		 * without appearing to create any others.
+		 */
+		if (likely(!tp->repair)) {
+			u32 seq = tcptw->tw_snd_nxt + 65535 + 2;
+
+			if (!seq)
+				seq = 1;
+			WRITE_ONCE(tp->write_seq, seq);
+			tp->rx_opt.ts_recent	   = READ_ONCE(tcptw->tw_ts_recent);
+			tp->rx_opt.ts_recent_stamp = ts_recent_stamp;
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
+enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
+{
+	u32 tail_gso_size, tail_gso_segs;
+	struct skb_shared_info *shinfo;
+	const struct tcphdr *th;
+	struct tcphdr *thtail;
+	struct sk_buff *tail;
+	unsigned int hdrlen;
+	bool fragstolen;
+	u32 gso_segs;
+	u32 gso_size;
+	u64 limit;
+	int delta;
+	int err;
+
+	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
+	 * we can fix skb->truesize to its real value to avoid future drops.
+	 * This is valid because skb is not yet charged to the socket.
+	 * It has been noticed pure SACK packets were sometimes dropped
+	 * (if cooked by drivers without copybreak feature).
+	 */
+	skb_condense(skb);
+
+	tcp_cleanup_skb(skb);
+
+	if (unlikely(tcp_checksum_complete(skb))) {
+		bh_unlock_sock(sk);
+		trace_tcp_bad_csum(skb);
+		__TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+		__TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
+		return SKB_DROP_REASON_TCP_CSUM;
+	}
+
+	/* Attempt coalescing to last skb in backlog, even if we are
+	 * above the limits.
+	 * This is okay because skb capacity is limited to MAX_SKB_FRAGS.
+	 */
+	th = (const struct tcphdr *)skb->data;
+	hdrlen = th->doff * 4;
+
+	tail = sk->sk_backlog.tail;
+	if (!tail)
+		goto no_coalesce;
+	thtail = (struct tcphdr *)tail->data;
+
+	if (TCP_SKB_CB(tail)->end_seq != TCP_SKB_CB(skb)->seq ||
+	    TCP_SKB_CB(tail)->ip_dsfield != TCP_SKB_CB(skb)->ip_dsfield ||
+	    ((TCP_SKB_CB(tail)->tcp_flags |
+	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_SYN | TCPHDR_RST | TCPHDR_URG)) ||
+	    !((TCP_SKB_CB(tail)->tcp_flags &
+	      TCP_SKB_CB(skb)->tcp_flags) & TCPHDR_ACK) ||
+	    ((TCP_SKB_CB(tail)->tcp_flags ^
+	      TCP_SKB_CB(skb)->tcp_flags) &
+	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
+	    !tcp_skb_can_collapse_rx(tail, skb) ||
+	    thtail->doff != th->doff ||
+	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
+	    /* prior to PSP Rx policy check, retain exact PSP metadata */
+	    psp_skb_coalesce_diff(tail, skb))
+		goto no_coalesce;
+
+	__skb_pull(skb, hdrlen);
+
+	shinfo = skb_shinfo(skb);
+	gso_size = shinfo->gso_size ?: skb->len;
+	gso_segs = shinfo->gso_segs ?: 1;
+
+	shinfo = skb_shinfo(tail);
+	tail_gso_size = shinfo->gso_size ?: (tail->len - hdrlen);
+	tail_gso_segs = shinfo->gso_segs ?: 1;
+
+	if (skb_try_coalesce(tail, skb, &fragstolen, &delta)) {
+		TCP_SKB_CB(tail)->end_seq = TCP_SKB_CB(skb)->end_seq;
+
+		if (likely(!before(TCP_SKB_CB(skb)->ack_seq, TCP_SKB_CB(tail)->ack_seq))) {
+			TCP_SKB_CB(tail)->ack_seq = TCP_SKB_CB(skb)->ack_seq;
+			thtail->window = th->window;
+		}
+
+		/* We have to update both TCP_SKB_CB(tail)->tcp_flags and
+		 * thtail->fin, so that the fast path in tcp_rcv_established()
+		 * is not entered if we append a packet with a FIN.
+		 * SYN, RST, URG are not present.
+		 * ACK is set on both packets.
+		 * PSH : we do not really care in TCP stack,
+		 *       at least for 'GRO' packets.
+		 */
+		thtail->fin |= th->fin;
+		TCP_SKB_CB(tail)->tcp_flags |= TCP_SKB_CB(skb)->tcp_flags;
+
+		if (TCP_SKB_CB(skb)->has_rxtstamp) {
+			TCP_SKB_CB(tail)->has_rxtstamp = true;
+			tail->tstamp = skb->tstamp;
+			skb_hwtstamps(tail)->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
+		}
+
+		/* Not as strict as GRO. We only need to carry mss max value */
+		shinfo->gso_size = max(gso_size, tail_gso_size);
+		shinfo->gso_segs = min_t(u32, gso_segs + tail_gso_segs, 0xFFFF);
+
+		sk->sk_backlog.len += delta;
+		__NET_INC_STATS(sock_net(sk),
+				LINUX_MIB_TCPBACKLOGCOALESCE);
+		kfree_skb_partial(skb, fragstolen);
+		return SKB_NOT_DROPPED_YET;
+	}
+	__skb_push(skb, hdrlen);
+
+no_coalesce:
+	/* sk->sk_backlog.len is reset only at the end of __release_sock().
+	 * Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
+	 * sk_rcvbuf in normal conditions.
+	 */
+	limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+
+	limit += ((u32)READ_ONCE(sk->sk_sndbuf)) >> 1;
+
+	/* Only socket owner can try to collapse/prune rx queues
+	 * to reduce memory overhead, so add a little headroom here.
+	 * Few sockets backlog are possibly concurrently non empty.
+	 */
+	limit += 64 * 1024;
+
+	limit = min_t(u64, limit, UINT_MAX);
+
+	err = sk_add_backlog(sk, skb, limit);
+	if (unlikely(err)) {
+		bh_unlock_sock(sk);
+		if (err == -ENOMEM) {
+			__NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
+			return SKB_DROP_REASON_PFMEMALLOC;
+		}
+		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
+		return SKB_DROP_REASON_SOCKET_BACKLOG;
+	}
+	return SKB_NOT_DROPPED_YET;
+}
+
+/* TCP-LD (RFC 6069) logic */
+void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct sk_buff *skb;
+	s32 remaining;
+	u32 delta_us;
+
+	if (sock_owned_by_user(sk))
+		return;
+
+	if (seq != tp->snd_una  || !icsk->icsk_retransmits ||
+	    !icsk->icsk_backoff)
+		return;
+
+	skb = tcp_rtx_queue_head(sk);
+	if (WARN_ON_ONCE(!skb))
+		return;
+
+	icsk->icsk_backoff--;
+	icsk->icsk_rto = tp->srtt_us ? __tcp_set_rto(tp) : TCP_TIMEOUT_INIT;
+	icsk->icsk_rto = inet_csk_rto_backoff(icsk, tcp_rto_max(sk));
+
+	tcp_mstamp_refresh(tp);
+	delta_us = (u32)(tp->tcp_mstamp - tcp_skb_timestamp_us(skb));
+	remaining = icsk->icsk_rto - usecs_to_jiffies(delta_us);
+
+	if (remaining > 0) {
+		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, remaining, false);
+	} else {
+		/* RTO revert clocked out retransmission.
+		 * Will retransmit now.
+		 */
+		tcp_retransmit_timer(sk);
+	}
+}
+
+/* handle ICMP messages on TCP_NEW_SYN_RECV request sockets */
+void tcp_req_err(struct sock *sk, u32 seq, bool abort)
+{
+	struct request_sock *req = inet_reqsk(sk);
+	struct net *net = sock_net(sk);
+
+	/* ICMPs are not backlogged, hence we cannot get
+	 * an established socket here.
+	 */
+	if (seq != tcp_rsk(req)->snt_isn) {
+		__NET_INC_STATS(net, LINUX_MIB_OUTOFWINDOWICMPS);
+	} else if (abort) {
+		/*
+		 * Still in SYN_RECV, just remove it silently.
+		 * There is no good way to pass the error to the newly
+		 * created socket, and POSIX does not want network
+		 * errors returned from accept().
+		 */
+		inet_csk_reqsk_queue_drop(req->rsk_listener, req);
+		tcp_listendrop(req->rsk_listener);
+	}
+	reqsk_put(req);
+}
+
 void tcp_splice_eof(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -5280,6 +6387,182 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
 }
 
+static void __net_exit tcp_sk_exit(struct net *net)
+{
+	if (net->ipv4.tcp_congestion_control)
+		bpf_module_put(net->ipv4.tcp_congestion_control,
+			       net->ipv4.tcp_congestion_control->owner);
+}
+
+static void __net_init tcp_set_hashinfo(struct net *net)
+{
+	struct inet_hashinfo *hinfo;
+	unsigned int ehash_entries;
+	struct net *old_net;
+
+	if (net_eq(net, &init_net))
+		goto fallback;
+
+	old_net = current->nsproxy->net_ns;
+	ehash_entries = READ_ONCE(old_net->ipv4.sysctl_tcp_child_ehash_entries);
+	if (!ehash_entries)
+		goto fallback;
+
+	ehash_entries = roundup_pow_of_two(ehash_entries);
+	hinfo = inet_pernet_hashinfo_alloc(&tcp_hashinfo, ehash_entries);
+	if (!hinfo) {
+		pr_warn("Failed to allocate TCP ehash (entries: %u) "
+			"for a netns, fallback to the global one\n",
+			ehash_entries);
+fallback:
+		hinfo = &tcp_hashinfo;
+		ehash_entries = tcp_hashinfo.ehash_mask + 1;
+	}
+
+	net->ipv4.tcp_death_row.hashinfo = hinfo;
+	net->ipv4.tcp_death_row.sysctl_max_tw_buckets = ehash_entries / 2;
+	net->ipv4.sysctl_max_syn_backlog = max(128U, ehash_entries / 128);
+}
+
+static int __net_init tcp_sk_init(struct net *net)
+{
+	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
+	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ACCECN_OPTION_BEACON;
+	net->ipv4.sysctl_tcp_ecn_fallback = 1;
+
+	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
+	net->ipv4.sysctl_tcp_min_snd_mss = TCP_MIN_SND_MSS;
+	net->ipv4.sysctl_tcp_probe_threshold = TCP_PROBE_THRESHOLD;
+	net->ipv4.sysctl_tcp_probe_interval = TCP_PROBE_INTERVAL;
+	net->ipv4.sysctl_tcp_mtu_probe_floor = TCP_MIN_SND_MSS;
+
+	net->ipv4.sysctl_tcp_keepalive_time = TCP_KEEPALIVE_TIME;
+	net->ipv4.sysctl_tcp_keepalive_probes = TCP_KEEPALIVE_PROBES;
+	net->ipv4.sysctl_tcp_keepalive_intvl = TCP_KEEPALIVE_INTVL;
+
+	net->ipv4.sysctl_tcp_syn_retries = TCP_SYN_RETRIES;
+	net->ipv4.sysctl_tcp_synack_retries = TCP_SYNACK_RETRIES;
+	net->ipv4.sysctl_tcp_syncookies = 1;
+	net->ipv4.sysctl_tcp_reordering = TCP_FASTRETRANS_THRESH;
+	net->ipv4.sysctl_tcp_retries1 = TCP_RETR1;
+	net->ipv4.sysctl_tcp_retries2 = TCP_RETR2;
+	net->ipv4.sysctl_tcp_orphan_retries = 0;
+	net->ipv4.sysctl_tcp_fin_timeout = TCP_FIN_TIMEOUT;
+	net->ipv4.sysctl_tcp_notsent_lowat = UINT_MAX;
+	net->ipv4.sysctl_tcp_tw_reuse = 2;
+	net->ipv4.sysctl_tcp_tw_reuse_delay = 1 * MSEC_PER_SEC;
+	net->ipv4.sysctl_tcp_no_ssthresh_metrics_save = 1;
+
+	refcount_set(&net->ipv4.tcp_death_row.tw_refcount, 1);
+	tcp_set_hashinfo(net);
+
+	net->ipv4.sysctl_tcp_sack = 1;
+	net->ipv4.sysctl_tcp_window_scaling = 1;
+	net->ipv4.sysctl_tcp_timestamps = 1;
+	net->ipv4.sysctl_tcp_early_retrans = 3;
+	net->ipv4.sysctl_tcp_recovery = TCP_RACK_LOSS_DETECTION;
+	net->ipv4.sysctl_tcp_slow_start_after_idle = 1; /* By default, RFC2861 behavior.  */
+	net->ipv4.sysctl_tcp_retrans_collapse = 1;
+	net->ipv4.sysctl_tcp_max_reordering = 300;
+	net->ipv4.sysctl_tcp_dsack = 1;
+	net->ipv4.sysctl_tcp_app_win = 31;
+	net->ipv4.sysctl_tcp_adv_win_scale = 1;
+	net->ipv4.sysctl_tcp_frto = 2;
+	net->ipv4.sysctl_tcp_moderate_rcvbuf = 1;
+	net->ipv4.sysctl_tcp_rcvbuf_low_rtt = USEC_PER_MSEC;
+	/* This limits the percentage of the congestion window which we
+	 * will allow a single TSO frame to consume.  Building TSO frames
+	 * which are too large can cause TCP streams to be bursty.
+	 */
+	net->ipv4.sysctl_tcp_tso_win_divisor = 3;
+	/* Default TSQ limit of 4 MB */
+	net->ipv4.sysctl_tcp_limit_output_bytes = 4 << 20;
+
+	/* rfc5961 challenge ack rate limiting, per net-ns, disabled by default. */
+	net->ipv4.sysctl_tcp_challenge_ack_limit = INT_MAX;
+
+	net->ipv4.sysctl_tcp_min_tso_segs = 2;
+	net->ipv4.sysctl_tcp_tso_rtt_log = 9;  /* 2^9 = 512 usec */
+	net->ipv4.sysctl_tcp_min_rtt_wlen = 300;
+	net->ipv4.sysctl_tcp_autocorking = 1;
+	net->ipv4.sysctl_tcp_invalid_ratelimit = HZ / 2;
+	net->ipv4.sysctl_tcp_pacing_ss_ratio = 200;
+	net->ipv4.sysctl_tcp_pacing_ca_ratio = 120;
+	if (net != &init_net) {
+		memcpy(net->ipv4.sysctl_tcp_rmem,
+		       init_net.ipv4.sysctl_tcp_rmem,
+		       sizeof(init_net.ipv4.sysctl_tcp_rmem));
+		memcpy(net->ipv4.sysctl_tcp_wmem,
+		       init_net.ipv4.sysctl_tcp_wmem,
+		       sizeof(init_net.ipv4.sysctl_tcp_wmem));
+	}
+	net->ipv4.sysctl_tcp_comp_sack_delay_ns = NSEC_PER_MSEC;
+	net->ipv4.sysctl_tcp_comp_sack_slack_ns = 10 * NSEC_PER_USEC;
+	net->ipv4.sysctl_tcp_comp_sack_nr = 44;
+	net->ipv4.sysctl_tcp_comp_sack_rtt_percent = 33;
+	net->ipv4.sysctl_tcp_backlog_ack_defer = 1;
+	net->ipv4.sysctl_tcp_fastopen = TFO_CLIENT_ENABLE;
+	net->ipv4.sysctl_tcp_fastopen_blackhole_timeout = 0;
+	atomic_set(&net->ipv4.tfo_active_disable_times, 0);
+
+	/* Set default values for PLB */
+	net->ipv4.sysctl_tcp_plb_enabled = 0; /* Disabled by default */
+	net->ipv4.sysctl_tcp_plb_idle_rehash_rounds = 3;
+	net->ipv4.sysctl_tcp_plb_rehash_rounds = 12;
+	net->ipv4.sysctl_tcp_plb_suspend_rto_sec = 60;
+	/* Default congestion threshold for PLB to mark a round is 50% */
+	net->ipv4.sysctl_tcp_plb_cong_thresh = (1 << TCP_PLB_SCALE) / 2;
+
+	/* Reno is always built in */
+	if (!net_eq(net, &init_net) &&
+	    bpf_try_module_get(init_net.ipv4.tcp_congestion_control,
+			       init_net.ipv4.tcp_congestion_control->owner))
+		net->ipv4.tcp_congestion_control = init_net.ipv4.tcp_congestion_control;
+	else
+		net->ipv4.tcp_congestion_control = &tcp_reno;
+
+	net->ipv4.sysctl_tcp_syn_linear_timeouts = 4;
+	net->ipv4.sysctl_tcp_shrink_window = 0;
+
+	net->ipv4.sysctl_tcp_pingpong_thresh = 1;
+	net->ipv4.sysctl_tcp_rto_min_us = jiffies_to_usecs(TCP_RTO_MIN);
+	net->ipv4.sysctl_tcp_rto_max_ms = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
+
+	return 0;
+}
+
+static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
+{
+	struct net *net;
+
+	/* make sure concurrent calls to tcp_sk_exit_batch from net_cleanup_work
+	 * and failed setup_net error unwinding path are serialized.
+	 *
+	 * tcp_twsk_purge() handles twsk in any dead netns, not just those in
+	 * net_exit_list, the thread that dismantles a particular twsk must
+	 * do so without other thread progressing to refcount_dec_and_test() of
+	 * tcp_death_row.tw_refcount.
+	 */
+	mutex_lock(&tcp_exit_batch_mutex);
+
+	tcp_twsk_purge(net_exit_list);
+
+	list_for_each_entry(net, net_exit_list, exit_list) {
+		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
+		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
+		tcp_fastopen_ctx_destroy(net);
+	}
+
+	mutex_unlock(&tcp_exit_batch_mutex);
+}
+
+static struct pernet_operations __net_initdata tcp_sk_ops = {
+	.init		= tcp_sk_init,
+	.exit		= tcp_sk_exit,
+	.exit_batch	= tcp_sk_exit_batch,
+};
+
 void __init tcp_init(void)
 {
 	int max_rshare, max_wshare, cnt;
@@ -5374,7 +6657,15 @@ void __init tcp_init(void)
 	pr_info("Hash tables configured (established %u bind %u)\n",
 		tcp_hashinfo.ehash_mask + 1, tcp_hashinfo.bhash_size);
 
+#if IS_ENABLED(CONFIG_IPV4)
 	tcp_v4_init();
+#endif
+	if (register_pernet_subsys(&tcp_sk_ops))
+		panic("Failed to create the TCP control socket.\n");
+
+#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
+	bpf_iter_register();
+#endif
 	tcp_metrics_init();
 	BUG_ON(tcp_register_congestion_control(&tcp_reno) != 0);
 	tcp_tsq_work_init();
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..d7eb2c38f343 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -652,12 +652,14 @@ static void tcp_bpf_check_v6_needs_rebuild(struct proto *ops)
 	}
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 static int __init tcp_bpf_v4_build_proto(void)
 {
 	tcp_bpf_rebuild_protos(tcp_bpf_prots[TCP_BPF_IPV4], &tcp_prot);
 	return 0;
 }
 late_initcall(tcp_bpf_v4_build_proto);
+#endif
 
 static int tcp_bpf_assert_proto_ops(struct proto *ops)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522508..27d53a711321 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -85,7 +85,6 @@
 #include <linux/seq_file.h>
 #include <linux/inetdevice.h>
 #include <linux/btf_ids.h>
-#include <linux/skbuff_ref.h>
 
 #include <crypto/md5.h>
 #include <crypto/utils.h>
@@ -97,14 +96,10 @@ static void tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key
 				__be32 daddr, __be32 saddr, const struct tcphdr *th);
 #endif
 
-struct inet_hashinfo tcp_hashinfo;
-
 static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) = {
 	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
 };
 
-static DEFINE_MUTEX(tcp_exit_batch_mutex);
-
 INDIRECT_CALLABLE_SCOPE union tcp_seq_and_ts_off
 tcp_v4_init_seq_and_ts_off(const struct net *net, const struct sk_buff *skb)
 {
@@ -115,93 +110,6 @@ tcp_v4_init_seq_and_ts_off(const struct net *net, const struct sk_buff *skb)
 					 tcp_hdr(skb)->source);
 }
 
-int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
-{
-	int reuse = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tw_reuse);
-	const struct inet_timewait_sock *tw = inet_twsk(sktw);
-	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
-	struct tcp_sock *tp = tcp_sk(sk);
-	int ts_recent_stamp;
-	u32 reuse_thresh;
-
-	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2)
-		reuse = 0;
-
-	if (reuse == 2) {
-		/* Still does not detect *everything* that goes through
-		 * lo, since we require a loopback src or dst address
-		 * or direct binding to 'lo' interface.
-		 */
-		bool loopback = false;
-		if (tw->tw_bound_dev_if == LOOPBACK_IFINDEX)
-			loopback = true;
-#if IS_ENABLED(CONFIG_IPV6)
-		if (tw->tw_family == AF_INET6) {
-			if (ipv6_addr_loopback(&tw->tw_v6_daddr) ||
-			    ipv6_addr_v4mapped_loopback(&tw->tw_v6_daddr) ||
-			    ipv6_addr_loopback(&tw->tw_v6_rcv_saddr) ||
-			    ipv6_addr_v4mapped_loopback(&tw->tw_v6_rcv_saddr))
-				loopback = true;
-		} else
-#endif
-		{
-			if (ipv4_is_loopback(tw->tw_daddr) ||
-			    ipv4_is_loopback(tw->tw_rcv_saddr))
-				loopback = true;
-		}
-		if (!loopback)
-			reuse = 0;
-	}
-
-	/* With PAWS, it is safe from the viewpoint
-	   of data integrity. Even without PAWS it is safe provided sequence
-	   spaces do not overlap i.e. at data rates <= 80Mbit/sec.
-
-	   Actually, the idea is close to VJ's one, only timestamp cache is
-	   held not per host, but per port pair and TW bucket is used as state
-	   holder.
-
-	   If TW bucket has been already destroyed we fall back to VJ's scheme
-	   and use initial timestamp retrieved from peer table.
-	 */
-	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
-	reuse_thresh = READ_ONCE(tw->tw_entry_stamp) +
-		       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tw_reuse_delay);
-	if (ts_recent_stamp &&
-	    (!twp || (reuse && time_after32(tcp_clock_ms(), reuse_thresh)))) {
-		/* inet_twsk_hashdance_schedule() sets sk_refcnt after putting twsk
-		 * and releasing the bucket lock.
-		 */
-		if (unlikely(!refcount_inc_not_zero(&sktw->sk_refcnt)))
-			return 0;
-
-		/* In case of repair and re-using TIME-WAIT sockets we still
-		 * want to be sure that it is safe as above but honor the
-		 * sequence numbers and time stamps set as part of the repair
-		 * process.
-		 *
-		 * Without this check re-using a TIME-WAIT socket with TCP
-		 * repair would accumulate a -1 on the repair assigned
-		 * sequence number. The first time it is reused the sequence
-		 * is -1, the second time -2, etc. This fixes that issue
-		 * without appearing to create any others.
-		 */
-		if (likely(!tp->repair)) {
-			u32 seq = tcptw->tw_snd_nxt + 65535 + 2;
-
-			if (!seq)
-				seq = 1;
-			WRITE_ONCE(tp->write_seq, seq);
-			tp->rx_opt.ts_recent	   = READ_ONCE(tcptw->tw_ts_recent);
-			tp->rx_opt.ts_recent_stamp = ts_recent_stamp;
-		}
-
-		return 1;
-	}
-
-	return 0;
-}
-
 static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			      int addr_len)
 {
@@ -409,69 +317,6 @@ static void do_redirect(struct sk_buff *skb, struct sock *sk)
 		dst->ops->redirect(dst, sk, skb);
 }
 
-
-/* handle ICMP messages on TCP_NEW_SYN_RECV request sockets */
-void tcp_req_err(struct sock *sk, u32 seq, bool abort)
-{
-	struct request_sock *req = inet_reqsk(sk);
-	struct net *net = sock_net(sk);
-
-	/* ICMPs are not backlogged, hence we cannot get
-	 * an established socket here.
-	 */
-	if (seq != tcp_rsk(req)->snt_isn) {
-		__NET_INC_STATS(net, LINUX_MIB_OUTOFWINDOWICMPS);
-	} else if (abort) {
-		/*
-		 * Still in SYN_RECV, just remove it silently.
-		 * There is no good way to pass the error to the newly
-		 * created socket, and POSIX does not want network
-		 * errors returned from accept().
-		 */
-		inet_csk_reqsk_queue_drop(req->rsk_listener, req);
-		tcp_listendrop(req->rsk_listener);
-	}
-	reqsk_put(req);
-}
-
-/* TCP-LD (RFC 6069) logic */
-void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
-{
-	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct tcp_sock *tp = tcp_sk(sk);
-	struct sk_buff *skb;
-	s32 remaining;
-	u32 delta_us;
-
-	if (sock_owned_by_user(sk))
-		return;
-
-	if (seq != tp->snd_una  || !icsk->icsk_retransmits ||
-	    !icsk->icsk_backoff)
-		return;
-
-	skb = tcp_rtx_queue_head(sk);
-	if (WARN_ON_ONCE(!skb))
-		return;
-
-	icsk->icsk_backoff--;
-	icsk->icsk_rto = tp->srtt_us ? __tcp_set_rto(tp) : TCP_TIMEOUT_INIT;
-	icsk->icsk_rto = inet_csk_rto_backoff(icsk, tcp_rto_max(sk));
-
-	tcp_mstamp_refresh(tp);
-	delta_us = (u32)(tp->tcp_mstamp - tcp_skb_timestamp_us(skb));
-	remaining = icsk->icsk_rto - usecs_to_jiffies(delta_us);
-
-	if (remaining > 0) {
-		tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS, remaining, false);
-	} else {
-		/* RTO revert clocked out retransmission.
-		 * Will retransmit now.
-		 */
-		tcp_retransmit_timer(sk);
-	}
-}
-
 /*
  * This routine is called by the ICMP module when it gets some
  * sort of error condition.  If err < 0 then the socket should
@@ -1895,144 +1740,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	goto discard;
 }
 
-enum skb_drop_reason tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
-{
-	u32 tail_gso_size, tail_gso_segs;
-	struct skb_shared_info *shinfo;
-	const struct tcphdr *th;
-	struct tcphdr *thtail;
-	struct sk_buff *tail;
-	unsigned int hdrlen;
-	bool fragstolen;
-	u32 gso_segs;
-	u32 gso_size;
-	u64 limit;
-	int delta;
-	int err;
-
-	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
-	 * we can fix skb->truesize to its real value to avoid future drops.
-	 * This is valid because skb is not yet charged to the socket.
-	 * It has been noticed pure SACK packets were sometimes dropped
-	 * (if cooked by drivers without copybreak feature).
-	 */
-	skb_condense(skb);
-
-	tcp_cleanup_skb(skb);
-
-	if (unlikely(tcp_checksum_complete(skb))) {
-		bh_unlock_sock(sk);
-		trace_tcp_bad_csum(skb);
-		__TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
-		__TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
-		return SKB_DROP_REASON_TCP_CSUM;
-	}
-
-	/* Attempt coalescing to last skb in backlog, even if we are
-	 * above the limits.
-	 * This is okay because skb capacity is limited to MAX_SKB_FRAGS.
-	 */
-	th = (const struct tcphdr *)skb->data;
-	hdrlen = th->doff * 4;
-
-	tail = sk->sk_backlog.tail;
-	if (!tail)
-		goto no_coalesce;
-	thtail = (struct tcphdr *)tail->data;
-
-	if (TCP_SKB_CB(tail)->end_seq != TCP_SKB_CB(skb)->seq ||
-	    TCP_SKB_CB(tail)->ip_dsfield != TCP_SKB_CB(skb)->ip_dsfield ||
-	    ((TCP_SKB_CB(tail)->tcp_flags |
-	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_SYN | TCPHDR_RST | TCPHDR_URG)) ||
-	    !((TCP_SKB_CB(tail)->tcp_flags &
-	      TCP_SKB_CB(skb)->tcp_flags) & TCPHDR_ACK) ||
-	    ((TCP_SKB_CB(tail)->tcp_flags ^
-	      TCP_SKB_CB(skb)->tcp_flags) &
-	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
-	    !tcp_skb_can_collapse_rx(tail, skb) ||
-	    thtail->doff != th->doff ||
-	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
-	    /* prior to PSP Rx policy check, retain exact PSP metadata */
-	    psp_skb_coalesce_diff(tail, skb))
-		goto no_coalesce;
-
-	__skb_pull(skb, hdrlen);
-
-	shinfo = skb_shinfo(skb);
-	gso_size = shinfo->gso_size ?: skb->len;
-	gso_segs = shinfo->gso_segs ?: 1;
-
-	shinfo = skb_shinfo(tail);
-	tail_gso_size = shinfo->gso_size ?: (tail->len - hdrlen);
-	tail_gso_segs = shinfo->gso_segs ?: 1;
-
-	if (skb_try_coalesce(tail, skb, &fragstolen, &delta)) {
-		TCP_SKB_CB(tail)->end_seq = TCP_SKB_CB(skb)->end_seq;
-
-		if (likely(!before(TCP_SKB_CB(skb)->ack_seq, TCP_SKB_CB(tail)->ack_seq))) {
-			TCP_SKB_CB(tail)->ack_seq = TCP_SKB_CB(skb)->ack_seq;
-			thtail->window = th->window;
-		}
-
-		/* We have to update both TCP_SKB_CB(tail)->tcp_flags and
-		 * thtail->fin, so that the fast path in tcp_rcv_established()
-		 * is not entered if we append a packet with a FIN.
-		 * SYN, RST, URG are not present.
-		 * ACK is set on both packets.
-		 * PSH : we do not really care in TCP stack,
-		 *       at least for 'GRO' packets.
-		 */
-		thtail->fin |= th->fin;
-		TCP_SKB_CB(tail)->tcp_flags |= TCP_SKB_CB(skb)->tcp_flags;
-
-		if (TCP_SKB_CB(skb)->has_rxtstamp) {
-			TCP_SKB_CB(tail)->has_rxtstamp = true;
-			tail->tstamp = skb->tstamp;
-			skb_hwtstamps(tail)->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
-		}
-
-		/* Not as strict as GRO. We only need to carry mss max value */
-		shinfo->gso_size = max(gso_size, tail_gso_size);
-		shinfo->gso_segs = min_t(u32, gso_segs + tail_gso_segs, 0xFFFF);
-
-		sk->sk_backlog.len += delta;
-		__NET_INC_STATS(sock_net(sk),
-				LINUX_MIB_TCPBACKLOGCOALESCE);
-		kfree_skb_partial(skb, fragstolen);
-		return SKB_NOT_DROPPED_YET;
-	}
-	__skb_push(skb, hdrlen);
-
-no_coalesce:
-	/* sk->sk_backlog.len is reset only at the end of __release_sock().
-	 * Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
-	 * sk_rcvbuf in normal conditions.
-	 */
-	limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
-
-	limit += ((u32)READ_ONCE(sk->sk_sndbuf)) >> 1;
-
-	/* Only socket owner can try to collapse/prune rx queues
-	 * to reduce memory overhead, so add a little headroom here.
-	 * Few sockets backlog are possibly concurrently non empty.
-	 */
-	limit += 64 * 1024;
-
-	limit = min_t(u64, limit, UINT_MAX);
-
-	err = sk_add_backlog(sk, skb, limit);
-	if (unlikely(err)) {
-		bh_unlock_sock(sk);
-		if (err == -ENOMEM) {
-			__NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
-			return SKB_DROP_REASON_PFMEMALLOC;
-		}
-		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
-		return SKB_DROP_REASON_SOCKET_BACKLOG;
-	}
-	return SKB_NOT_DROPPED_YET;
-}
-
 static void tcp_v4_restore_cb(struct sk_buff *skb)
 {
 	memmove(IPCB(skb), &TCP_SKB_CB(skb)->header.h4,
@@ -2404,338 +2111,9 @@ static int tcp_v4_init_sock(struct sock *sk)
 	return 0;
 }
 
-static void tcp_release_user_frags(struct sock *sk)
-{
-#ifdef CONFIG_PAGE_POOL
-	unsigned long index;
-	void *netmem;
-
-	xa_for_each(&sk->sk_user_frags, index, netmem)
-		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
-#endif
-}
-
-void tcp_v4_destroy_sock(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	tcp_release_user_frags(sk);
-
-	xa_destroy(&sk->sk_user_frags);
-
-	trace_tcp_destroy_sock(sk);
-
-	tcp_clear_xmit_timers(sk);
-
-	tcp_cleanup_congestion_control(sk);
-
-	tcp_cleanup_ulp(sk);
-
-	/* Cleanup up the write buffer. */
-	tcp_write_queue_purge(sk);
-
-	/* Check if we want to disable active TFO */
-	tcp_fastopen_active_disable_ofo_check(sk);
-
-	/* Cleans up our, hopefully empty, out_of_order_queue. */
-	skb_rbtree_purge(&tp->out_of_order_queue);
-
-	/* Clean up a referenced TCP bind bucket. */
-	if (inet_csk(sk)->icsk_bind_hash)
-		inet_put_port(sk);
-
-	BUG_ON(rcu_access_pointer(tp->fastopen_rsk));
-
-	/* If socket is aborted during connect operation */
-	tcp_free_fastopen_req(tp);
-	tcp_fastopen_destroy_cipher(sk);
-	tcp_saved_syn_free(tp);
-
-	sk_sockets_allocated_dec(sk);
-}
-
 #ifdef CONFIG_PROC_FS
 /* Proc filesystem TCP sock list dumping. */
 
-static unsigned short seq_file_family(const struct seq_file *seq);
-
-static bool seq_sk_match(struct seq_file *seq, const struct sock *sk)
-{
-	unsigned short family = seq_file_family(seq);
-
-	/* AF_UNSPEC is used as a match all */
-	return ((family == AF_UNSPEC || family == sk->sk_family) &&
-		net_eq(sock_net(sk), seq_file_net(seq)));
-}
-
-/* Find a non empty bucket (starting from st->bucket)
- * and return the first sk from it.
- */
-static void *listening_get_first(struct seq_file *seq)
-{
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	struct tcp_iter_state *st = seq->private;
-
-	st->offset = 0;
-	for (; st->bucket <= hinfo->lhash2_mask; st->bucket++) {
-		struct inet_listen_hashbucket *ilb2;
-		struct hlist_nulls_node *node;
-		struct sock *sk;
-
-		ilb2 = &hinfo->lhash2[st->bucket];
-		if (hlist_nulls_empty(&ilb2->nulls_head))
-			continue;
-
-		spin_lock(&ilb2->lock);
-		sk_nulls_for_each(sk, node, &ilb2->nulls_head) {
-			if (seq_sk_match(seq, sk))
-				return sk;
-		}
-		spin_unlock(&ilb2->lock);
-	}
-
-	return NULL;
-}
-
-/* Find the next sk of "cur" within the same bucket (i.e. st->bucket).
- * If "cur" is the last one in the st->bucket,
- * call listening_get_first() to return the first sk of the next
- * non empty bucket.
- */
-static void *listening_get_next(struct seq_file *seq, void *cur)
-{
-	struct tcp_iter_state *st = seq->private;
-	struct inet_listen_hashbucket *ilb2;
-	struct hlist_nulls_node *node;
-	struct inet_hashinfo *hinfo;
-	struct sock *sk = cur;
-
-	++st->num;
-	++st->offset;
-
-	sk = sk_nulls_next(sk);
-	sk_nulls_for_each_from(sk, node) {
-		if (seq_sk_match(seq, sk))
-			return sk;
-	}
-
-	hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	ilb2 = &hinfo->lhash2[st->bucket];
-	spin_unlock(&ilb2->lock);
-	++st->bucket;
-	return listening_get_first(seq);
-}
-
-static void *listening_get_idx(struct seq_file *seq, loff_t *pos)
-{
-	struct tcp_iter_state *st = seq->private;
-	void *rc;
-
-	st->bucket = 0;
-	st->offset = 0;
-	rc = listening_get_first(seq);
-
-	while (rc && *pos) {
-		rc = listening_get_next(seq, rc);
-		--*pos;
-	}
-	return rc;
-}
-
-static inline bool empty_bucket(struct inet_hashinfo *hinfo,
-				const struct tcp_iter_state *st)
-{
-	return hlist_nulls_empty(&hinfo->ehash[st->bucket].chain);
-}
-
-/*
- * Get first established socket starting from bucket given in st->bucket.
- * If st->bucket is zero, the very first socket in the hash is returned.
- */
-static void *established_get_first(struct seq_file *seq)
-{
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	struct tcp_iter_state *st = seq->private;
-
-	st->offset = 0;
-	for (; st->bucket <= hinfo->ehash_mask; ++st->bucket) {
-		struct sock *sk;
-		struct hlist_nulls_node *node;
-		spinlock_t *lock = inet_ehash_lockp(hinfo, st->bucket);
-
-		cond_resched();
-
-		/* Lockless fast path for the common case of empty buckets */
-		if (empty_bucket(hinfo, st))
-			continue;
-
-		spin_lock_bh(lock);
-		sk_nulls_for_each(sk, node, &hinfo->ehash[st->bucket].chain) {
-			if (seq_sk_match(seq, sk))
-				return sk;
-		}
-		spin_unlock_bh(lock);
-	}
-
-	return NULL;
-}
-
-static void *established_get_next(struct seq_file *seq, void *cur)
-{
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	struct tcp_iter_state *st = seq->private;
-	struct hlist_nulls_node *node;
-	struct sock *sk = cur;
-
-	++st->num;
-	++st->offset;
-
-	sk = sk_nulls_next(sk);
-
-	sk_nulls_for_each_from(sk, node) {
-		if (seq_sk_match(seq, sk))
-			return sk;
-	}
-
-	spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
-	++st->bucket;
-	return established_get_first(seq);
-}
-
-static void *established_get_idx(struct seq_file *seq, loff_t pos)
-{
-	struct tcp_iter_state *st = seq->private;
-	void *rc;
-
-	st->bucket = 0;
-	rc = established_get_first(seq);
-
-	while (rc && pos) {
-		rc = established_get_next(seq, rc);
-		--pos;
-	}
-	return rc;
-}
-
-static void *tcp_get_idx(struct seq_file *seq, loff_t pos)
-{
-	void *rc;
-	struct tcp_iter_state *st = seq->private;
-
-	st->state = TCP_SEQ_STATE_LISTENING;
-	rc	  = listening_get_idx(seq, &pos);
-
-	if (!rc) {
-		st->state = TCP_SEQ_STATE_ESTABLISHED;
-		rc	  = established_get_idx(seq, pos);
-	}
-
-	return rc;
-}
-
-static void *tcp_seek_last_pos(struct seq_file *seq)
-{
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	struct tcp_iter_state *st = seq->private;
-	int bucket = st->bucket;
-	int offset = st->offset;
-	int orig_num = st->num;
-	void *rc = NULL;
-
-	switch (st->state) {
-	case TCP_SEQ_STATE_LISTENING:
-		if (st->bucket > hinfo->lhash2_mask)
-			break;
-		rc = listening_get_first(seq);
-		while (offset-- && rc && bucket == st->bucket)
-			rc = listening_get_next(seq, rc);
-		if (rc)
-			break;
-		st->bucket = 0;
-		st->state = TCP_SEQ_STATE_ESTABLISHED;
-		fallthrough;
-	case TCP_SEQ_STATE_ESTABLISHED:
-		if (st->bucket > hinfo->ehash_mask)
-			break;
-		rc = established_get_first(seq);
-		while (offset-- && rc && bucket == st->bucket)
-			rc = established_get_next(seq, rc);
-	}
-
-	st->num = orig_num;
-
-	return rc;
-}
-
-void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	struct tcp_iter_state *st = seq->private;
-	void *rc;
-
-	if (*pos && *pos == st->last_pos) {
-		rc = tcp_seek_last_pos(seq);
-		if (rc)
-			goto out;
-	}
-
-	st->state = TCP_SEQ_STATE_LISTENING;
-	st->num = 0;
-	st->bucket = 0;
-	st->offset = 0;
-	rc = *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
-
-out:
-	st->last_pos = *pos;
-	return rc;
-}
-
-void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	struct tcp_iter_state *st = seq->private;
-	void *rc = NULL;
-
-	if (v == SEQ_START_TOKEN) {
-		rc = tcp_get_idx(seq, 0);
-		goto out;
-	}
-
-	switch (st->state) {
-	case TCP_SEQ_STATE_LISTENING:
-		rc = listening_get_next(seq, v);
-		if (!rc) {
-			st->state = TCP_SEQ_STATE_ESTABLISHED;
-			st->bucket = 0;
-			st->offset = 0;
-			rc	  = established_get_first(seq);
-		}
-		break;
-	case TCP_SEQ_STATE_ESTABLISHED:
-		rc = established_get_next(seq, v);
-		break;
-	}
-out:
-	++*pos;
-	st->last_pos = *pos;
-	return rc;
-}
-
-void tcp_seq_stop(struct seq_file *seq, void *v)
-{
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	struct tcp_iter_state *st = seq->private;
-
-	switch (st->state) {
-	case TCP_SEQ_STATE_LISTENING:
-		if (v != SEQ_START_TOKEN)
-			spin_unlock(&hinfo->lhash2[st->bucket].lock);
-		break;
-	case TCP_SEQ_STATE_ESTABLISHED:
-		if (v)
-			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
-		break;
-	}
-}
-
 static void get_openreq4(const struct request_sock *req,
 			 struct seq_file *f, int i)
 {
@@ -2872,426 +2250,6 @@ static int tcp4_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-#ifdef CONFIG_BPF_SYSCALL
-union bpf_tcp_iter_batch_item {
-	struct sock *sk;
-	__u64 cookie;
-};
-
-struct bpf_tcp_iter_state {
-	struct tcp_iter_state state;
-	unsigned int cur_sk;
-	unsigned int end_sk;
-	unsigned int max_sk;
-	union bpf_tcp_iter_batch_item *batch;
-};
-
-struct bpf_iter__tcp {
-	__bpf_md_ptr(struct bpf_iter_meta *, meta);
-	__bpf_md_ptr(struct sock_common *, sk_common);
-	uid_t uid __aligned(8);
-};
-
-static int tcp_prog_seq_show(struct bpf_prog *prog, struct bpf_iter_meta *meta,
-			     struct sock_common *sk_common, uid_t uid)
-{
-	struct bpf_iter__tcp ctx;
-
-	meta->seq_num--;  /* skip SEQ_START_TOKEN */
-	ctx.meta = meta;
-	ctx.sk_common = sk_common;
-	ctx.uid = uid;
-	return bpf_iter_run_prog(prog, &ctx);
-}
-
-static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
-{
-	union bpf_tcp_iter_batch_item *item;
-	unsigned int cur_sk = iter->cur_sk;
-	__u64 cookie;
-
-	/* Remember the cookies of the sockets we haven't seen yet, so we can
-	 * pick up where we left off next time around.
-	 */
-	while (cur_sk < iter->end_sk) {
-		item = &iter->batch[cur_sk++];
-		cookie = sock_gen_cookie(item->sk);
-		sock_gen_put(item->sk);
-		item->cookie = cookie;
-	}
-}
-
-static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz, gfp_t flags)
-{
-	union bpf_tcp_iter_batch_item *new_batch;
-
-	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     flags | __GFP_NOWARN);
-	if (!new_batch)
-		return -ENOMEM;
-
-	memcpy(new_batch, iter->batch, sizeof(*iter->batch) * iter->end_sk);
-	kvfree(iter->batch);
-	iter->batch = new_batch;
-	iter->max_sk = new_batch_sz;
-
-	return 0;
-}
-
-static struct sock *bpf_iter_tcp_resume_bucket(struct sock *first_sk,
-					       union bpf_tcp_iter_batch_item *cookies,
-					       int n_cookies)
-{
-	struct hlist_nulls_node *node;
-	struct sock *sk;
-	int i;
-
-	for (i = 0; i < n_cookies; i++) {
-		sk = first_sk;
-		sk_nulls_for_each_from(sk, node)
-			if (cookies[i].cookie == atomic64_read(&sk->sk_cookie))
-				return sk;
-	}
-
-	return NULL;
-}
-
-static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
-{
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
-	unsigned int find_cookie = iter->cur_sk;
-	unsigned int end_cookie = iter->end_sk;
-	int resume_bucket = st->bucket;
-	struct sock *sk;
-
-	if (end_cookie && find_cookie == end_cookie)
-		++st->bucket;
-
-	sk = listening_get_first(seq);
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
-	if (sk && st->bucket == resume_bucket && end_cookie) {
-		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
-						end_cookie - find_cookie);
-		if (!sk) {
-			spin_unlock(&hinfo->lhash2[st->bucket].lock);
-			++st->bucket;
-			sk = listening_get_first(seq);
-		}
-	}
-
-	return sk;
-}
-
-static struct sock *bpf_iter_tcp_resume_established(struct seq_file *seq)
-{
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
-	unsigned int find_cookie = iter->cur_sk;
-	unsigned int end_cookie = iter->end_sk;
-	int resume_bucket = st->bucket;
-	struct sock *sk;
-
-	if (end_cookie && find_cookie == end_cookie)
-		++st->bucket;
-
-	sk = established_get_first(seq);
-	iter->cur_sk = 0;
-	iter->end_sk = 0;
-
-	if (sk && st->bucket == resume_bucket && end_cookie) {
-		sk = bpf_iter_tcp_resume_bucket(sk, &iter->batch[find_cookie],
-						end_cookie - find_cookie);
-		if (!sk) {
-			spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
-			++st->bucket;
-			sk = established_get_first(seq);
-		}
-	}
-
-	return sk;
-}
-
-static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
-{
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
-	struct sock *sk = NULL;
-
-	switch (st->state) {
-	case TCP_SEQ_STATE_LISTENING:
-		sk = bpf_iter_tcp_resume_listening(seq);
-		if (sk)
-			break;
-		st->bucket = 0;
-		st->state = TCP_SEQ_STATE_ESTABLISHED;
-		fallthrough;
-	case TCP_SEQ_STATE_ESTABLISHED:
-		sk = bpf_iter_tcp_resume_established(seq);
-		break;
-	}
-
-	return sk;
-}
-
-static unsigned int bpf_iter_tcp_listening_batch(struct seq_file *seq,
-						 struct sock **start_sk)
-{
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct hlist_nulls_node *node;
-	unsigned int expected = 1;
-	struct sock *sk;
-
-	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++].sk = *start_sk;
-
-	sk = sk_nulls_next(*start_sk);
-	*start_sk = NULL;
-	sk_nulls_for_each_from(sk, node) {
-		if (seq_sk_match(seq, sk)) {
-			if (iter->end_sk < iter->max_sk) {
-				sock_hold(sk);
-				iter->batch[iter->end_sk++].sk = sk;
-			} else if (!*start_sk) {
-				/* Remember where we left off. */
-				*start_sk = sk;
-			}
-			expected++;
-		}
-	}
-
-	return expected;
-}
-
-static unsigned int bpf_iter_tcp_established_batch(struct seq_file *seq,
-						   struct sock **start_sk)
-{
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct hlist_nulls_node *node;
-	unsigned int expected = 1;
-	struct sock *sk;
-
-	sock_hold(*start_sk);
-	iter->batch[iter->end_sk++].sk = *start_sk;
-
-	sk = sk_nulls_next(*start_sk);
-	*start_sk = NULL;
-	sk_nulls_for_each_from(sk, node) {
-		if (seq_sk_match(seq, sk)) {
-			if (iter->end_sk < iter->max_sk) {
-				sock_hold(sk);
-				iter->batch[iter->end_sk++].sk = sk;
-			} else if (!*start_sk) {
-				/* Remember where we left off. */
-				*start_sk = sk;
-			}
-			expected++;
-		}
-	}
-
-	return expected;
-}
-
-static unsigned int bpf_iter_fill_batch(struct seq_file *seq,
-					struct sock **start_sk)
-{
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
-
-	if (st->state == TCP_SEQ_STATE_LISTENING)
-		return bpf_iter_tcp_listening_batch(seq, start_sk);
-	else
-		return bpf_iter_tcp_established_batch(seq, start_sk);
-}
-
-static void bpf_iter_tcp_unlock_bucket(struct seq_file *seq)
-{
-	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
-
-	if (st->state == TCP_SEQ_STATE_LISTENING)
-		spin_unlock(&hinfo->lhash2[st->bucket].lock);
-	else
-		spin_unlock_bh(inet_ehash_lockp(hinfo, st->bucket));
-}
-
-static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
-{
-	struct bpf_tcp_iter_state *iter = seq->private;
-	unsigned int expected;
-	struct sock *sk;
-	int err;
-
-	sk = bpf_iter_tcp_resume(seq);
-	if (!sk)
-		return NULL; /* Done */
-
-	expected = bpf_iter_fill_batch(seq, &sk);
-	if (likely(iter->end_sk == expected))
-		goto done;
-
-	/* Batch size was too small. */
-	bpf_iter_tcp_unlock_bucket(seq);
-	bpf_iter_tcp_put_batch(iter);
-	err = bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
-					 GFP_USER);
-	if (err)
-		return ERR_PTR(err);
-
-	sk = bpf_iter_tcp_resume(seq);
-	if (!sk)
-		return NULL; /* Done */
-
-	expected = bpf_iter_fill_batch(seq, &sk);
-	if (likely(iter->end_sk == expected))
-		goto done;
-
-	/* Batch size was still too small. Hold onto the lock while we try
-	 * again with a larger batch to make sure the current bucket's size
-	 * does not change in the meantime.
-	 */
-	err = bpf_iter_tcp_realloc_batch(iter, expected, GFP_NOWAIT);
-	if (err) {
-		bpf_iter_tcp_unlock_bucket(seq);
-		return ERR_PTR(err);
-	}
-
-	expected = bpf_iter_fill_batch(seq, &sk);
-	WARN_ON_ONCE(iter->end_sk != expected);
-done:
-	bpf_iter_tcp_unlock_bucket(seq);
-	return iter->batch[0].sk;
-}
-
-static void *bpf_iter_tcp_seq_start(struct seq_file *seq, loff_t *pos)
-{
-	/* bpf iter does not support lseek, so it always
-	 * continue from where it was stop()-ped.
-	 */
-	if (*pos)
-		return bpf_iter_tcp_batch(seq);
-
-	return SEQ_START_TOKEN;
-}
-
-static void *bpf_iter_tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
-{
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct tcp_iter_state *st = &iter->state;
-	struct sock *sk;
-
-	/* Whenever seq_next() is called, the iter->cur_sk is
-	 * done with seq_show(), so advance to the next sk in
-	 * the batch.
-	 */
-	if (iter->cur_sk < iter->end_sk) {
-		/* Keeping st->num consistent in tcp_iter_state.
-		 * bpf_iter_tcp does not use st->num.
-		 * meta.seq_num is used instead.
-		 */
-		st->num++;
-		sock_gen_put(iter->batch[iter->cur_sk++].sk);
-	}
-
-	if (iter->cur_sk < iter->end_sk)
-		sk = iter->batch[iter->cur_sk].sk;
-	else
-		sk = bpf_iter_tcp_batch(seq);
-
-	++*pos;
-	/* Keeping st->last_pos consistent in tcp_iter_state.
-	 * bpf iter does not do lseek, so st->last_pos always equals to *pos.
-	 */
-	st->last_pos = *pos;
-	return sk;
-}
-
-static int bpf_iter_tcp_seq_show(struct seq_file *seq, void *v)
-{
-	struct bpf_iter_meta meta;
-	struct bpf_prog *prog;
-	struct sock *sk = v;
-	uid_t uid;
-	int ret;
-
-	if (v == SEQ_START_TOKEN)
-		return 0;
-
-	if (sk_fullsock(sk))
-		lock_sock(sk);
-
-	if (unlikely(sk_unhashed(sk))) {
-		ret = SEQ_SKIP;
-		goto unlock;
-	}
-
-	if (sk->sk_state == TCP_TIME_WAIT) {
-		uid = 0;
-	} else if (sk->sk_state == TCP_NEW_SYN_RECV) {
-		const struct request_sock *req = v;
-
-		uid = from_kuid_munged(seq_user_ns(seq),
-				       sk_uid(req->rsk_listener));
-	} else {
-		uid = from_kuid_munged(seq_user_ns(seq), sk_uid(sk));
-	}
-
-	meta.seq = seq;
-	prog = bpf_iter_get_info(&meta, false);
-	ret = tcp_prog_seq_show(prog, &meta, v, uid);
-
-unlock:
-	if (sk_fullsock(sk))
-		release_sock(sk);
-	return ret;
-
-}
-
-static void bpf_iter_tcp_seq_stop(struct seq_file *seq, void *v)
-{
-	struct bpf_tcp_iter_state *iter = seq->private;
-	struct bpf_iter_meta meta;
-	struct bpf_prog *prog;
-
-	if (!v) {
-		meta.seq = seq;
-		prog = bpf_iter_get_info(&meta, true);
-		if (prog)
-			(void)tcp_prog_seq_show(prog, &meta, v, 0);
-	}
-
-	if (iter->cur_sk < iter->end_sk)
-		bpf_iter_tcp_put_batch(iter);
-}
-
-static const struct seq_operations bpf_iter_tcp_seq_ops = {
-	.show		= bpf_iter_tcp_seq_show,
-	.start		= bpf_iter_tcp_seq_start,
-	.next		= bpf_iter_tcp_seq_next,
-	.stop		= bpf_iter_tcp_seq_stop,
-};
-#endif
-static unsigned short seq_file_family(const struct seq_file *seq)
-{
-	const struct tcp_seq_afinfo *afinfo;
-
-#ifdef CONFIG_BPF_SYSCALL
-	/* Iterated from bpf_iter.  Let the bpf prog to filter instead. */
-	if (seq->op == &bpf_iter_tcp_seq_ops)
-		return AF_UNSPEC;
-#endif
-
-	/* Iterated from proc fs */
-	afinfo = pde_data(file_inode(seq->file));
-	return afinfo->family;
-}
-
 static const struct seq_operations tcp4_seq_ops = {
 	.show		= tcp4_seq_show,
 	.start		= tcp_seq_start,
@@ -3342,7 +2300,7 @@ struct proto tcp_prot = {
 	.accept			= inet_csk_accept,
 	.ioctl			= tcp_ioctl,
 	.init			= tcp_v4_init_sock,
-	.destroy		= tcp_v4_destroy_sock,
+	.destroy		= tcp_destroy_sock,
 	.shutdown		= tcp_shutdown,
 	.setsockopt		= tcp_setsockopt,
 	.getsockopt		= tcp_getsockopt,
@@ -3385,255 +2343,6 @@ struct proto tcp_prot = {
 };
 EXPORT_SYMBOL(tcp_prot);
 
-static void __net_exit tcp_sk_exit(struct net *net)
-{
-	if (net->ipv4.tcp_congestion_control)
-		bpf_module_put(net->ipv4.tcp_congestion_control,
-			       net->ipv4.tcp_congestion_control->owner);
-}
-
-static void __net_init tcp_set_hashinfo(struct net *net)
-{
-	struct inet_hashinfo *hinfo;
-	unsigned int ehash_entries;
-	struct net *old_net;
-
-	if (net_eq(net, &init_net))
-		goto fallback;
-
-	old_net = current->nsproxy->net_ns;
-	ehash_entries = READ_ONCE(old_net->ipv4.sysctl_tcp_child_ehash_entries);
-	if (!ehash_entries)
-		goto fallback;
-
-	ehash_entries = roundup_pow_of_two(ehash_entries);
-	hinfo = inet_pernet_hashinfo_alloc(&tcp_hashinfo, ehash_entries);
-	if (!hinfo) {
-		pr_warn("Failed to allocate TCP ehash (entries: %u) "
-			"for a netns, fallback to the global one\n",
-			ehash_entries);
-fallback:
-		hinfo = &tcp_hashinfo;
-		ehash_entries = tcp_hashinfo.ehash_mask + 1;
-	}
-
-	net->ipv4.tcp_death_row.hashinfo = hinfo;
-	net->ipv4.tcp_death_row.sysctl_max_tw_buckets = ehash_entries / 2;
-	net->ipv4.sysctl_max_syn_backlog = max(128U, ehash_entries / 128);
-}
-
-static int __net_init tcp_sk_init(struct net *net)
-{
-	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
-	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
-	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ACCECN_OPTION_BEACON;
-	net->ipv4.sysctl_tcp_ecn_fallback = 1;
-
-	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
-	net->ipv4.sysctl_tcp_min_snd_mss = TCP_MIN_SND_MSS;
-	net->ipv4.sysctl_tcp_probe_threshold = TCP_PROBE_THRESHOLD;
-	net->ipv4.sysctl_tcp_probe_interval = TCP_PROBE_INTERVAL;
-	net->ipv4.sysctl_tcp_mtu_probe_floor = TCP_MIN_SND_MSS;
-
-	net->ipv4.sysctl_tcp_keepalive_time = TCP_KEEPALIVE_TIME;
-	net->ipv4.sysctl_tcp_keepalive_probes = TCP_KEEPALIVE_PROBES;
-	net->ipv4.sysctl_tcp_keepalive_intvl = TCP_KEEPALIVE_INTVL;
-
-	net->ipv4.sysctl_tcp_syn_retries = TCP_SYN_RETRIES;
-	net->ipv4.sysctl_tcp_synack_retries = TCP_SYNACK_RETRIES;
-	net->ipv4.sysctl_tcp_syncookies = 1;
-	net->ipv4.sysctl_tcp_reordering = TCP_FASTRETRANS_THRESH;
-	net->ipv4.sysctl_tcp_retries1 = TCP_RETR1;
-	net->ipv4.sysctl_tcp_retries2 = TCP_RETR2;
-	net->ipv4.sysctl_tcp_orphan_retries = 0;
-	net->ipv4.sysctl_tcp_fin_timeout = TCP_FIN_TIMEOUT;
-	net->ipv4.sysctl_tcp_notsent_lowat = UINT_MAX;
-	net->ipv4.sysctl_tcp_tw_reuse = 2;
-	net->ipv4.sysctl_tcp_tw_reuse_delay = 1 * MSEC_PER_SEC;
-	net->ipv4.sysctl_tcp_no_ssthresh_metrics_save = 1;
-
-	refcount_set(&net->ipv4.tcp_death_row.tw_refcount, 1);
-	tcp_set_hashinfo(net);
-
-	net->ipv4.sysctl_tcp_sack = 1;
-	net->ipv4.sysctl_tcp_window_scaling = 1;
-	net->ipv4.sysctl_tcp_timestamps = 1;
-	net->ipv4.sysctl_tcp_early_retrans = 3;
-	net->ipv4.sysctl_tcp_recovery = TCP_RACK_LOSS_DETECTION;
-	net->ipv4.sysctl_tcp_slow_start_after_idle = 1; /* By default, RFC2861 behavior.  */
-	net->ipv4.sysctl_tcp_retrans_collapse = 1;
-	net->ipv4.sysctl_tcp_max_reordering = 300;
-	net->ipv4.sysctl_tcp_dsack = 1;
-	net->ipv4.sysctl_tcp_app_win = 31;
-	net->ipv4.sysctl_tcp_adv_win_scale = 1;
-	net->ipv4.sysctl_tcp_frto = 2;
-	net->ipv4.sysctl_tcp_moderate_rcvbuf = 1;
-	net->ipv4.sysctl_tcp_rcvbuf_low_rtt = USEC_PER_MSEC;
-	/* This limits the percentage of the congestion window which we
-	 * will allow a single TSO frame to consume.  Building TSO frames
-	 * which are too large can cause TCP streams to be bursty.
-	 */
-	net->ipv4.sysctl_tcp_tso_win_divisor = 3;
-	/* Default TSQ limit of 4 MB */
-	net->ipv4.sysctl_tcp_limit_output_bytes = 4 << 20;
-
-	/* rfc5961 challenge ack rate limiting, per net-ns, disabled by default. */
-	net->ipv4.sysctl_tcp_challenge_ack_limit = INT_MAX;
-
-	net->ipv4.sysctl_tcp_min_tso_segs = 2;
-	net->ipv4.sysctl_tcp_tso_rtt_log = 9;  /* 2^9 = 512 usec */
-	net->ipv4.sysctl_tcp_min_rtt_wlen = 300;
-	net->ipv4.sysctl_tcp_autocorking = 1;
-	net->ipv4.sysctl_tcp_invalid_ratelimit = HZ/2;
-	net->ipv4.sysctl_tcp_pacing_ss_ratio = 200;
-	net->ipv4.sysctl_tcp_pacing_ca_ratio = 120;
-	if (net != &init_net) {
-		memcpy(net->ipv4.sysctl_tcp_rmem,
-		       init_net.ipv4.sysctl_tcp_rmem,
-		       sizeof(init_net.ipv4.sysctl_tcp_rmem));
-		memcpy(net->ipv4.sysctl_tcp_wmem,
-		       init_net.ipv4.sysctl_tcp_wmem,
-		       sizeof(init_net.ipv4.sysctl_tcp_wmem));
-	}
-	net->ipv4.sysctl_tcp_comp_sack_delay_ns = NSEC_PER_MSEC;
-	net->ipv4.sysctl_tcp_comp_sack_slack_ns = 10 * NSEC_PER_USEC;
-	net->ipv4.sysctl_tcp_comp_sack_nr = 44;
-	net->ipv4.sysctl_tcp_comp_sack_rtt_percent = 33;
-	net->ipv4.sysctl_tcp_backlog_ack_defer = 1;
-	net->ipv4.sysctl_tcp_fastopen = TFO_CLIENT_ENABLE;
-	net->ipv4.sysctl_tcp_fastopen_blackhole_timeout = 0;
-	atomic_set(&net->ipv4.tfo_active_disable_times, 0);
-
-	/* Set default values for PLB */
-	net->ipv4.sysctl_tcp_plb_enabled = 0; /* Disabled by default */
-	net->ipv4.sysctl_tcp_plb_idle_rehash_rounds = 3;
-	net->ipv4.sysctl_tcp_plb_rehash_rounds = 12;
-	net->ipv4.sysctl_tcp_plb_suspend_rto_sec = 60;
-	/* Default congestion threshold for PLB to mark a round is 50% */
-	net->ipv4.sysctl_tcp_plb_cong_thresh = (1 << TCP_PLB_SCALE) / 2;
-
-	/* Reno is always built in */
-	if (!net_eq(net, &init_net) &&
-	    bpf_try_module_get(init_net.ipv4.tcp_congestion_control,
-			       init_net.ipv4.tcp_congestion_control->owner))
-		net->ipv4.tcp_congestion_control = init_net.ipv4.tcp_congestion_control;
-	else
-		net->ipv4.tcp_congestion_control = &tcp_reno;
-
-	net->ipv4.sysctl_tcp_syn_linear_timeouts = 4;
-	net->ipv4.sysctl_tcp_shrink_window = 0;
-
-	net->ipv4.sysctl_tcp_pingpong_thresh = 1;
-	net->ipv4.sysctl_tcp_rto_min_us = jiffies_to_usecs(TCP_RTO_MIN);
-	net->ipv4.sysctl_tcp_rto_max_ms = TCP_RTO_MAX_SEC * MSEC_PER_SEC;
-
-	return 0;
-}
-
-static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
-{
-	struct net *net;
-
-	/* make sure concurrent calls to tcp_sk_exit_batch from net_cleanup_work
-	 * and failed setup_net error unwinding path are serialized.
-	 *
-	 * tcp_twsk_purge() handles twsk in any dead netns, not just those in
-	 * net_exit_list, the thread that dismantles a particular twsk must
-	 * do so without other thread progressing to refcount_dec_and_test() of
-	 * tcp_death_row.tw_refcount.
-	 */
-	mutex_lock(&tcp_exit_batch_mutex);
-
-	tcp_twsk_purge(net_exit_list);
-
-	list_for_each_entry(net, net_exit_list, exit_list) {
-		inet_pernet_hashinfo_free(net->ipv4.tcp_death_row.hashinfo);
-		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
-		tcp_fastopen_ctx_destroy(net);
-	}
-
-	mutex_unlock(&tcp_exit_batch_mutex);
-}
-
-static struct pernet_operations __net_initdata tcp_sk_ops = {
-       .init	   = tcp_sk_init,
-       .exit	   = tcp_sk_exit,
-       .exit_batch = tcp_sk_exit_batch,
-};
-
-#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
-DEFINE_BPF_ITER_FUNC(tcp, struct bpf_iter_meta *meta,
-		     struct sock_common *sk_common, uid_t uid)
-
-#define INIT_BATCH_SZ 16
-
-static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
-{
-	struct bpf_tcp_iter_state *iter = priv_data;
-	int err;
-
-	err = bpf_iter_init_seq_net(priv_data, aux);
-	if (err)
-		return err;
-
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
-	if (err) {
-		bpf_iter_fini_seq_net(priv_data);
-		return err;
-	}
-
-	return 0;
-}
-
-static void bpf_iter_fini_tcp(void *priv_data)
-{
-	struct bpf_tcp_iter_state *iter = priv_data;
-
-	bpf_iter_fini_seq_net(priv_data);
-	kvfree(iter->batch);
-}
-
-static const struct bpf_iter_seq_info tcp_seq_info = {
-	.seq_ops		= &bpf_iter_tcp_seq_ops,
-	.init_seq_private	= bpf_iter_init_tcp,
-	.fini_seq_private	= bpf_iter_fini_tcp,
-	.seq_priv_size		= sizeof(struct bpf_tcp_iter_state),
-};
-
-static const struct bpf_func_proto *
-bpf_iter_tcp_get_func_proto(enum bpf_func_id func_id,
-			    const struct bpf_prog *prog)
-{
-	switch (func_id) {
-	case BPF_FUNC_setsockopt:
-		return &bpf_sk_setsockopt_proto;
-	case BPF_FUNC_getsockopt:
-		return &bpf_sk_getsockopt_proto;
-	default:
-		return NULL;
-	}
-}
-
-static struct bpf_iter_reg tcp_reg_info = {
-	.target			= "tcp",
-	.ctx_arg_info_size	= 1,
-	.ctx_arg_info		= {
-		{ offsetof(struct bpf_iter__tcp, sk_common),
-		  PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
-	},
-	.get_func_proto		= bpf_iter_tcp_get_func_proto,
-	.seq_info		= &tcp_seq_info,
-};
-
-static void __init bpf_iter_register(void)
-{
-	tcp_reg_info.ctx_arg_info[0].btf_id = btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON];
-	if (bpf_iter_reg_target(&tcp_reg_info))
-		pr_warn("Warning: could not register bpf iterator tcp\n");
-}
-
-#endif
-
 void __init tcp_v4_init(void)
 {
 	int cpu, res;
@@ -3656,10 +2365,4 @@ void __init tcp_v4_init(void)
 
 		per_cpu(ipv4_tcp_sk.sock, cpu) = sk;
 	}
-	if (register_pernet_subsys(&tcp_sk_ops))
-		panic("Failed to create the TCP control socket.\n");
-
-#if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
-	bpf_iter_register();
-#endif
 }
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e..8bb6b50e0094 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -559,6 +559,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		if (optlen < sizeof(int))
 			goto e_inval;
 		if (val == PF_INET) {
+#if IS_ENABLED(CONFIG_IPV4)
 			if (sk->sk_type == SOCK_RAW)
 				break;
 
@@ -624,6 +625,10 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			module_put(THIS_MODULE);
 			retv = 0;
 			break;
+#else
+			retv = -EAFNOSUPPORT;
+			break;
+#endif
 		}
 		goto e_inval;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ebe161d72fbd..7f2ec3dfd2f0 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -217,6 +217,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	 */
 
 	if (addr_type & IPV6_ADDR_MAPPED) {
+#if IS_ENABLED(CONFIG_IPV4)
 		u32 exthdrlen = icsk->icsk_ext_hdr_len;
 		struct sockaddr_in sin;
 
@@ -253,6 +254,9 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 		np->saddr = sk->sk_v6_rcv_saddr;
 
 		return err;
+#else
+		return -ENETUNREACH;
+#endif
 	}
 
 	if (!ipv6_addr_any(&sk->sk_v6_rcv_saddr))
@@ -1314,7 +1318,11 @@ u16 tcp_v6_get_syncookie(struct sock *sk, struct ipv6hdr *iph,
 static int tcp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
 	if (skb->protocol == htons(ETH_P_IP))
+#if IS_ENABLED(CONFIG_IPV4)
 		return tcp_v4_conn_request(sk, skb);
+#else
+		goto drop;
+#endif
 
 	if (!ipv6_unicast_destination(skb))
 		goto drop;
@@ -1342,6 +1350,7 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
 		sizeof(struct inet6_skb_parm));
 }
 
+#if IS_ENABLED(CONFIG_IPV4)
 /* Called from tcp_v4_syn_recv_sock() for v6_mapped children. */
 static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
 {
@@ -1376,6 +1385,7 @@ static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
 	if (inet6_test_bit(REPFLOW, sk))
 		newnp->flow_label = 0;
 }
+#endif
 
 static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 					 struct request_sock *req,
@@ -1400,9 +1410,14 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	struct flowi6 fl6;
 
 	if (skb->protocol == htons(ETH_P_IP))
+#if IS_ENABLED(CONFIG_IPV4)
 		return tcp_v4_syn_recv_sock(sk, skb, req, dst,
 					    req_unhash, own_req,
 					    tcp_v6_mapped_child_init);
+#else
+		return NULL;
+#endif
+
 	ireq = inet_rsk(req);
 
 	if (sk_acceptq_is_full(sk))
@@ -1577,8 +1592,14 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   tcp_v6_hnd_req and tcp_v6_send_reset().   --ANK
 	 */
 
-	if (skb->protocol == htons(ETH_P_IP))
+	if (skb->protocol == htons(ETH_P_IP)) {
+#if IS_ENABLED(CONFIG_IPV4)
 		return tcp_v4_do_rcv(sk, skb);
+#else
+		kfree_skb(skb);
+		return 0;
+#endif
+	}
 
 	reason = psp_sk_rx_policy_check(sk, skb);
 	if (reason)
@@ -2279,7 +2300,7 @@ struct proto tcpv6_prot = {
 	.accept			= inet_csk_accept,
 	.ioctl			= tcp_ioctl,
 	.init			= tcp_v6_init_sock,
-	.destroy		= tcp_v4_destroy_sock,
+	.destroy		= tcp_destroy_sock,
 	.shutdown		= tcp_shutdown,
 	.setsockopt		= tcp_setsockopt,
 	.getsockopt		= tcp_getsockopt,
-- 
2.54.0


