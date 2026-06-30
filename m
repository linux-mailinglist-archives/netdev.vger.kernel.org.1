Return-Path: <netdev+bounces-302938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7nHuHz09Q2ocWAoAu9opvQ
	(envelope-from <netdev+bounces-302938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:51:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE056E024D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 05:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302938-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302938-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C05343008CB8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221742D6E72;
	Tue, 30 Jun 2026 03:51:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D01233954
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:51:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782791478; cv=none; b=ZTTDaLj917ripoZgMjViW22jSazOusOu77JGegmGTCtGqh1hAsLQemQfZL6oB+Pb4VTobfjhlxXfmCqmuToPZgHjkUPcal/CX3aodXvBv4K7r9XCv3GXS8zltvYJL0+Xs/g7FYQUUNfqybmI2wMAylJnxZI3aLBiE5J66lS8F7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782791478; c=relaxed/simple;
	bh=SSNT3ldLaOMS3C1XODvfcdb15RrBUT90VSI1aYjpG6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wm9Tw85HIkDvQHMZXeHzh3PVpfv5qmUwfF6KI2JoTooISzCwQQf4rwjrBUNFbT6BGGV1sIRpdjK6WoL3QnzQL+0ZIPo0WZOMSPgSe6v9hHPyyL21eN2ZCooXLahZXvLYG0CFgetDf9IPRaaG+OnNAiy3hxP5FOxY1Pm5bjbNtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Received: from enjou-Legion-Y7000P-2019 (unknown [124.127.26.47])
	by app1 (Coremail) with SMTP id ygmowABXdb8MPUNqPcbHAA--.56102S2;
	Tue, 30 Jun 2026 11:50:39 +0800 (CST)
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
	fmancera@suse.de,
	idosch@nvidia.com,
	yuuchihsu@gmail.com,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	roxy520tt@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net v2 1/1] tcp: bound SYN-ACK timers to reqsk timeout range
Date: Tue, 30 Jun 2026 11:49:41 +0800
Message-ID: <20260630035009.55201-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowABXdb8MPUNqPcbHAA--.56102S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFW5WrWDJFykZw17Ary3XFb_yoWxJrWkpF
	WDK3yDtr1vkFy7tr4IvFyDZF4xAw4rArW7WrnFgrZavFsrJr1fXFWUKrWavF42yFWvkF47
	XF4vgF98Can8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7
	Cv6cx26r4rMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sR_dgAUUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQENCWpCKtUGGQAPsD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302938-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,nokia-bell-labs.com,icloud.com,suse.de,nvidia.com,gmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:bronzed_45_vested@icloud.com,m:fmancera@suse.de,m:idosch@nvidia.com,m:yuuchihsu@gmail.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lzu.edu.cn:email,lzu.edu.cn:mid,lzu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCE056E024D

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
Changes in v2:
  - Keep the existing max_retries calculation in tcp_fastopen_synack_timer()
    and only add the clamp, avoiding code churn.
  - v1 Link: https://lore.kernel.org/all/02e24eb83639e9d7ecc623f000c60254bb5c40a5.1782643946.git.roxy520tt@gmail.com/

 include/net/tcp.h               | 19 +++++++++++++++----
 net/ipv4/inet_connection_sock.c |  6 +++++-
 net/ipv4/sysctl_net_ipv4.c      |  2 ++
 net/ipv4/tcp_timer.c            |  3 ++-
 4 files changed, 24 insertions(+), 6 deletions(-)

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
index bf171b5e1eb3..bbedf2b9e1bc 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -467,6 +467,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 */
 	max_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
+	max_retries = min_t(int, max_retries, MAX_TCP_SYNACK_RETRIES);
 
 	if (req->num_timeout >= max_retries) {
 		tcp_write_err(sk);
@@ -488,7 +489,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	if (!tp->retrans_stamp)
 		tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
-			  req->timeout << req->num_timeout, false);
+			     tcp_reqsk_timeout_sk(sk, req), false);
 }
 
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
-- 
2.43.0


