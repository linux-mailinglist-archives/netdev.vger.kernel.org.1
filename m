Return-Path: <netdev+bounces-302390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bWniCvAIQWqjkQkAu9opvQ
	(envelope-from <netdev+bounces-302390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:43:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3436D3B7B
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 13:43:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302390-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302390-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E76DB300E26F
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D013A3E6F;
	Sun, 28 Jun 2026 11:43:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E42358363
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 11:43:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647020; cv=none; b=IghP6OxeixeDnG/CPBUb70A3igmK7MfEROn0t6Lwfr8udyF0alpyysGEFRf2wWUr4ZdAeQuWg/YMv2O1Kv+iaU7zx0qR3Cvj0NbrbgQ8y4+s6Ag9HjLIjiuQgayr5LbUZ+a3eGeo+bm2CI/2+q/YNzkN7vK3Ooeh9E2stHUJJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647020; c=relaxed/simple;
	bh=/RZp/VbP5x9HYjKdppt8+hhe6NNFjdGIU1EuOvf4d1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbMqIc3N2YsXr6K2y+nwYBloR8tpPprp3IT71sVJUyj3cS5FZc4kXnBM7m0O06I7jkCFHpEf/1NzZQcOFAnwGIcZf/rFSfr1gfVd1nSODiocXhCbwogjRFj7dKwRxAJwb9iybnFXg8R4xIM9M7HnCUKwnGB/+/RQ6YBIwq9paI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowACHIQnFCEFqUt07AA--.18814S3;
	Sun, 28 Jun 2026 19:43:18 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	chia-yu.chang@nokia-bell-labs.com,
	ij@kernel.org,
	bronzed_45_vested@icloud.com,
	yuuchihsu@gmail.com,
	idosch@nvidia.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	roxy520tt@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
Date: Sun, 28 Jun 2026 19:42:28 +0800
Message-ID: <02e24eb83639e9d7ecc623f000c60254bb5c40a5.1782643946.git.roxy520tt@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782643946.git.roxy520tt@gmail.com>
References: <cover.1782643946.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowACHIQnFCEFqUt07AA--.18814S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW5WrWDJFykuF1xWry3Jwb_yoWxXFW5pF
	WDK3yDJr1kuFy7tr40ya4DZF4fJw48A3y7WrnFgrZayan7Gr1fZFyUKrWavF42kFWv9F47
	XFWqgry5Cws8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUj4E_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0MCWpA2VUB9QAAsb
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302390-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:bronzed_45_vested@icloud.com,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,nokia-bell-labs.com,icloud.com,gmail.com,nvidia.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lzu.edu.cn:from_mime,lzu.edu.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A3436D3B7B

From: Zhiling Zou <roxy520tt@gmail.com>

tcp_synack_retries supplies the SYN-ACK retry limit used by request
socket timers. The same effective limit can also come from TCP_SYNCNT
through icsk_syn_retries, while TCP_DEFER_ACCEPT can keep an ACKed
request alive until rskq_defer_accept is reached.

The request socket timeout counter is incremented before it is used to
compute the next timeout. tcp_reqsk_timeout() and the Fast Open SYN-ACK
timer shift req->timeout by req->num_timeout. Excessive retry or
defer-accept limits can therefore drive these timer paths into invalid
shift counts before the request expires.

Limit tcp_synack_retries to the request socket timer range, clamp the
effective retry and defer-accept limits in the regular request socket
timer path, clamp the Fast Open retry limit, and make the request
socket timeout helper saturate before shifting.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 include/net/tcp.h               | 19 +++++++++++++++----
 net/ipv4/inet_connection_sock.c |  6 +++++-
 net/ipv4/sysctl_net_ipv4.c      |  2 ++
 net/ipv4/tcp_timer.c            | 11 ++++++++---
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6d376ea4d1c0..656f1bd0fa1a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -183,6 +183,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define MAX_TCP_KEEPINTVL	32767
 #define MAX_TCP_KEEPCNT		127
 #define MAX_TCP_SYNCNT		127
+#define MAX_TCP_SYNACK_RETRIES	63
 
 /* Ensure that TCP PAWS checks are relaxed after ~2147 seconds
  * to avoid overflows. This assumes a clock smaller than 1 Mhz.
@@ -882,12 +883,22 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+static inline unsigned long tcp_reqsk_timeout_sk(const struct sock *sk,
+						 struct request_sock *req)
 {
-	u64 timeout = (u64)req->timeout << req->num_timeout;
+	u64 timeout = req->timeout;
+	u32 rto_max = tcp_rto_max(sk);
+
+	if (req->num_timeout >= BITS_PER_TYPE(u64) ||
+	    timeout > U64_MAX >> req->num_timeout)
+		return rto_max;
+
+	return (unsigned long)min_t(u64, timeout << req->num_timeout, rto_max);
+}
 
-	return (unsigned long)min_t(u64, timeout,
-				    tcp_rto_max(req->rsk_listener));
+static inline unsigned long tcp_reqsk_timeout(struct request_sock *req)
+{
+	return tcp_reqsk_timeout_sk(req->rsk_listener, req);
 }
 
 u32 tcp_delack_max(const struct sock *sk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 56902bba5483..b74212bae3dd 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1056,6 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	net = sock_net(sk_listener);
 	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
+	max_syn_ack_retries = min_t(int, max_syn_ack_retries,
+				    MAX_TCP_SYNACK_RETRIES);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
 	 * If synack was not acknowledged for 1 second, it means
@@ -1086,7 +1088,9 @@ static void reqsk_timer_handler(struct timer_list *t)
 		}
 	}
 
-	syn_ack_recalc(req, max_syn_ack_retries, READ_ONCE(queue->rskq_defer_accept),
+	syn_ack_recalc(req, max_syn_ack_retries,
+		       min_t(u8, READ_ONCE(queue->rskq_defer_accept),
+			     MAX_TCP_SYNACK_RETRIES),
 		       &expire, &resend);
 	tcp_syn_ack_timeout(req);
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ca1180dba1de..f9d233b98bbc 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -35,6 +35,7 @@ static int ip_ttl_min = 1;
 static int ip_ttl_max = 255;
 static int tcp_syn_retries_min = 1;
 static int tcp_syn_retries_max = MAX_TCP_SYNCNT;
+static int tcp_synack_retries_max = MAX_TCP_SYNACK_RETRIES;
 static int tcp_syn_linear_timeouts_max = MAX_TCP_SYNCNT;
 static unsigned long ip_ping_group_range_min[] = { 0, 0 };
 static unsigned long ip_ping_group_range_max[] = { GID_T_MAX, GID_T_MAX };
@@ -1034,6 +1035,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.extra2		= &tcp_synack_retries_max
 	},
 #ifdef CONFIG_SYN_COOKIES
 	{
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bf171b5e1eb3..097e5f698c57 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -458,6 +458,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
+	struct net *net = sock_net(sk);
 	int max_retries;
 
 	tcp_syn_ack_timeout(req);
@@ -465,8 +466,12 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	/* Add one more retry for fastopen.
 	 * Paired with WRITE_ONCE() in tcp_sock_set_syncnt()
 	 */
-	max_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
-		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
+	max_retries = READ_ONCE(icsk->icsk_syn_retries);
+	if (!max_retries) {
+		max_retries = READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
+		max_retries++;
+	}
+	max_retries = min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);
 
 	if (req->num_timeout >= max_retries) {
 		tcp_write_err(sk);
@@ -488,7 +493,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	if (!tp->retrans_stamp)
 		tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-			  req->timeout << req->num_timeout, false);
+			     tcp_reqsk_timeout_sk(sk, req), false);
 }
 
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
-- 
2.43.0


