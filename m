Return-Path: <netdev+bounces-307776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FvOPEoufV2pQYAAAu9opvQ
	(envelope-from <netdev+bounces-307776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:56:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C875FA5F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 16:56:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=daUlspi8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307776-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307776-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C797300D755
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB0432E9E;
	Wed, 15 Jul 2026 14:54:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCA399036
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 14:54:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127267; cv=none; b=n7k2E3R+qMCAVgGfwqjlT+ZBbi/rxPvNZ+COtSYX/jhNjvrSuIRLEGYsyhpNCoqGySAGU6N5YvhGzmFSLfom8eDw8fn/tbkShBiOvnAb24EuIMyHQy0apPSQ8vGHngfaBeEhRHBmXUny2G39ww8WzWPnKQvZi/mVzVaw4JeOOMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127267; c=relaxed/simple;
	bh=YyPEuMuyqMojfkauQ1cJlUP1yepRyWdPdGctS43UDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6b7gzyWiyWiVbR7q3tIXnJjOS2e3xpYxfGv3QjZ0mIXLBQrlN6cJb6N3K6Lpiy0GmMRJBijrf9D6Z3W5baO5Or+Y71M7cgP2zdsqYwifkq9GA8vJ1JcWSvPtFEQA/xlqzJq44ri5yXQbi0PGz/TcLeVEU6bWaQjbj8SZppPi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=daUlspi8; arc=none smtp.client-ip=91.218.175.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784127260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwZLS8o3i4sMyxo+i8ArT9POnhAqjleO4BkvUvWUla0=;
	b=daUlspi8tAUflgYybjOPKInf9VJHf2qWkYwQPKcpXc+ot9Tc5cLKt1VRH1Iz1S84q1AqkM
	eutn+riCgtZNoVMOALPYaQixlwo85wW/RDUtqJP7EiuaWl891pbO3k/19zOTEHjO1hruPu
	XgD29kthOoOccfZdEeZttqe/kFK1N6A=
From: Leon Hwang <leon.hwang@linux.dev>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Yung Chih Su <yuuchihsu@gmail.com>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next v2 1/2] tcp: Add net.ipv4.tcp_purge_receive_queue sysctl
Date: Wed, 15 Jul 2026 22:53:26 +0800
Message-ID: <20260715145328.54597-2-leon.hwang@linux.dev>
In-Reply-To: <20260715145328.54597-1-leon.hwang@linux.dev>
References: <20260715145328.54597-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,nvidia.com,linux.dev,nokia-bell-labs.com,gmail.com,icloud.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307776-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:ncardwell@google.com,m:kuniyu@google.com,m:idosch@nvidia.com,m:ij@kernel.org,m:leon.hwang@linux.dev,m:chia-yu.chang@nokia-bell-labs.com,m:yuuchihsu@gmail.com,m:bronzed_45_vested@icloud.com,m:kerneljasonxing@gmail.com,m:lance.yang@linux.dev,m:jiayuan.chen@linux.dev,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D24C875FA5F
X-Rspamd-Action: no action

Introduce a new sysctl knob, net.ipv4.tcp_purge_receive_queue, to
address an unreleased SKBs issue related to TCP sockets.

Issue:
When a TCP socket in the CLOSE_WAIT state receives a RST packet, the
current implementation does not clear the socket's receive queue. This
causes SKBs in the queue to remain allocated until the socket is
explicitly closed by the application. As a consequence:

1. The page pool pages held by these SKBs are not released.
2. The associated page pool cannot be freed.

RFC 9293 Section 3.10.7.4 specifies that when a RST is received in
CLOSE_WAIT state, "all segment queues should be flushed." However, the
current implementation does not flush the receive queue.

Solution:
Add a per-namespace sysctl (net.ipv4.tcp_purge_receive_queue) that,
when enabled, causes the kernel to purge the receive queue when a RST
packet is received in CLOSE_WAIT state. This allows immediate release
of SKBs and their associated memory resources.

The feature is disabled by default to maintain backward compatibility
with existing behavior.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 Documentation/networking/ip-sysctl.rst        | 18 +++++++++++++++
 .../net_cachelines/netns_ipv4_sysctl.rst      |  1 +
 include/net/netns/ipv4.h                      |  1 +
 net/ipv4/sysctl_net_ipv4.c                    |  9 ++++++++
 net/ipv4/tcp_input.c                          | 22 +++++++++++++++++++
 5 files changed, 51 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 208f46967ee5..abbee0326f15 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1448,6 +1448,24 @@ tcp_rto_max_ms - INTEGER
 
 	Default: 120,000
 
+tcp_purge_receive_queue - BOOLEAN
+	When a socket in the TCP_CLOSE_WAIT state receives a RST packet, the
+	default behavior is to not clear its receive queue.  As a result,
+	any SKBs in the queue are not freed until the socket is closed.
+	Consequently, the pages held by these SKBs are not released, which
+	can also prevent the associated page pool from being freed.
+
+	If enabled, the receive queue is purged upon receiving the RST,
+	allowing the SKBs and their associated memory to be released
+	promptly.
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 0 (disabled)
+
 UDP variables
 =============
 
diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 3dc03bff739e..2945de40ad78 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -126,6 +126,7 @@ unsigned_long                   sysctl_tcp_comp_sack_delay_ns
 unsigned_long                   sysctl_tcp_comp_sack_slack_ns                                                        __tcp_ack_snd_check
 int                             sysctl_max_syn_backlog
 int                             sysctl_tcp_fastopen
+u8                              sysctl_tcp_purge_receive_queue
 struct_tcp_congestion_ops       tcp_congestion_control                                                               init_cc
 struct_tcp_fastopen_context     tcp_fastopen_ctx
 unsigned_int                    sysctl_tcp_fastopen_blackhole_timeout
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index cb7f8bf15671..ab9b92807d9f 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -222,6 +222,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_nometrics_save;
 	u8 sysctl_tcp_no_ssthresh_metrics_save;
 	u8 sysctl_tcp_workaround_signed_windows;
+	u8 sysctl_tcp_purge_receive_queue;
 	int sysctl_tcp_challenge_ack_limit;
 	u8 sysctl_tcp_min_tso_segs;
 	u8 sysctl_tcp_reflect_tos;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ca1180dba1de..82412fd98e0e 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1652,6 +1652,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ONE_THOUSAND,
 		.extra2		= &tcp_rto_max_max,
 	},
+	{
+		.procname       = "tcp_purge_receive_queue",
+		.data           = &init_net.ipv4.sysctl_tcp_purge_receive_queue,
+		.maxlen         = sizeof(u8),
+		.mode           = 0644,
+		.proc_handler   = proc_dou8vec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 };
 
 static __net_init int ipv4_sysctl_init_net(struct net *net)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 61045a8886e4..4f1027173e95 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4853,6 +4853,7 @@ void tcp_done_with_error(struct sock *sk, int err)
 /* When we get a reset we do this. */
 void tcp_reset(struct sock *sk, struct sk_buff *skb)
 {
+	const struct net *net = sock_net(sk);
 	int err;
 
 	trace_tcp_receive_reset(sk);
@@ -4869,6 +4870,27 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb)
 		err = ECONNREFUSED;
 		break;
 	case TCP_CLOSE_WAIT:
+		/* RFC9293 3.10.7.4. Other States
+		 *   Second, check the RST bit:
+		 *     CLOSE-WAIT STATE
+		 *
+		 * If the RST bit is set, then any outstanding RECEIVEs and
+		 * SEND should receive "reset" responses.  All segment queues
+		 * should be flushed.  Users should also receive an unsolicited
+		 * general "connection reset" signal.  Enter the CLOSED state,
+		 * delete the TCB, and return.
+		 *
+		 * If net.ipv4.tcp_purge_receive_queue is enabled,
+		 * sk_receive_queue will be flushed too.
+		 */
+		if (unlikely(READ_ONCE(net->ipv4.sysctl_tcp_purge_receive_queue))) {
+			struct tcp_sock *tp = tcp_sk(sk);
+
+			skb_queue_purge(&sk->sk_receive_queue);
+			WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
+			WRITE_ONCE(tp->urg_data, 0);
+			sk_set_peek_off(sk, -1);
+		}
 		err = EPIPE;
 		break;
 	case TCP_CLOSE:
-- 
2.55.0


