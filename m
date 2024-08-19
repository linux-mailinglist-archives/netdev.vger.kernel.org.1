Return-Path: <netdev+bounces-119686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E372956950
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FA01C211F0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707B15ADB1;
	Mon, 19 Aug 2024 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JiVSMqs/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106B1607A4
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067090; cv=none; b=FJlSg3TqXttqoRBlOJLIr69IMLKPR8xTFKrGZFvNSQQAHJjx/fDRyRMq2VWpUct/jcfkig2MuH1dI3kv+g+id5AIeo/7+GQ1s72+eZ3mHp8u0lI+cRnirdQvdgBax1K7l3wFmJsronlh34C5VGq7fmLt4S/ki3b0P86TvkIxlLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067090; c=relaxed/simple;
	bh=gQPjdtNwb1HLr7Awhkw66Y735dchEy2hNUQ5CLJ6lEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ktvBMu7jbFjhE0Kld/DrlsY8UqFLu8Iej3lYxyY6adPc63VjXAnVgXfYiiQQBu3t1Lzl33EKHZWAJJgMRlKPH1yLt5+YowCjehGGQyj4wbjhJ0hzLAmeQLrByEmzRWnGJ1W/ORicI1YySPUHDVhb6HyEDr425qfMe1iB0tp+X2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JiVSMqs/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5320d8155b4so5531339e87.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1724067085; x=1724671885; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOG2PhhRuxszLOK8NJF/+vJDFgCa2c6jSVZK8oxFKNc=;
        b=JiVSMqs/PfB/2LeGvLr8f5pT6jAPdjEFbUoCsUWdEiu3sdml8YUAOI2z1fLQbw5epO
         wLeYOjGw7vfoDUPYy6pg+CsNYFQQGO5RV1d83/8AHZX7xRDJoi6fAh4pXtLZdMVVnrIZ
         D3DztNJLiyT2imKLtV9rYJw+ehTG8Gxhj1mpTiie+BZIl2Nth84CSLKbKBFqS3i6TveF
         5bu7xW6bBbxA3F1+V55MjFDU0GQFZXJv6jHoM7XSww5ewwbLdTZIjkrcTePfarXt/hQr
         73TqApJIxZvaqg3YUocVU8USGr3rb7ThATfu9RzBJHNQLgQum6258uF5mwWlDhW+fniU
         h0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067085; x=1724671885;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOG2PhhRuxszLOK8NJF/+vJDFgCa2c6jSVZK8oxFKNc=;
        b=EBXH735534cX4IH5uIat3SbIwLqutHEyvn5igKMczrNcXGWwCs+l6Kxxe/1x8QOkQR
         kcWyR/KZUNlkcq3dBrcx5UKfmXziaCh/LJpn/KXu8FlDFhXeST0ccdxcodtHz13DX7Oe
         ehwFvX7W+XYkeZ02cPRqXMAQIUmFMfaFiZbYENnAvmlZLBn2rNKVy0ghS3HGbEJejnFq
         Qv7t27sME2iyoFqdA8Md6EFT1R3yGo4tZ73ZK5xIiqhv5kTOTuDSUPYDc8H9jx+a60S4
         AyUQpaqj0ZfrtJtQftSWuR7pB/hDBbbccCaq/3KXyMXY5Wm2XMA4Umbvt80JQApohS8z
         OWYQ==
X-Gm-Message-State: AOJu0YwztHQ+8J3V4qhRr8La4aieO/jLMDWSNCsDcqN4PK4iDe3qDm8G
	JVKtxsowPnONpthdLqC7dDIMPcxV1nT6ylAhdsq94tl0622f9SVJ6kR8FPKhNdc=
X-Google-Smtp-Source: AGHT+IGLPhdDO7pRt3bBLB/HTmhT6jn/PiAjDsJAdbXEEoMCh1K3Csdt1t+RiI4FscPM/06BAFaaDQ==
X-Received: by 2002:a05:6512:224e:b0:52e:9cc7:4461 with SMTP id 2adb3069b0e04-5331c6900a4mr6652939e87.5.1724067085168;
        Mon, 19 Aug 2024 04:31:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935807sm621926966b.134.2024.08.19.04.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:31:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 19 Aug 2024 13:31:02 +0200
Subject: [PATCH RFC net-next] tcp: Allow TIME-WAIT reuse after 1
 millisecond
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAPUsw2YC/42NSw6CMBRFt0Le2GdaPkodmZi4AKeGQS0PrUBL2
 oIYwt5tWIHDk3tzzgKenCYPp2QBR5P22poIfJeAeknzJNR1ZEhZmrOSF/iW7fjA1hkUTOBgFfa
 eFIYPBh9kPyArpKyLQ5bLYw5RMzhq9Lwl7nC7XhJDAQ3NAaq4vrQP1n23/sS3z/+piSNHKQpRK
 p4x0aiz6uxYN510tFe2h2pd1x+2qfcz4wAAAA==
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, kernel-team@cloudflare.com
X-Mailer: b4 0.14.1

[This patch needs a description. Please see the RFC cover letter below.]

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Can we shorten the TCP connection reincarnation period?

Situation
=========

Currently, we can reuse a TCP 4-tuple (source IP + port, destination IP + port)
in the TIME-WAIT state to establish a new outgoing TCP connection after a period
of 1 second. This period, during which the 4-tuple remains blocked from reuse,
is determined by the granularity of the ts_recent_stamp / tw_ts_recent_stamp
timestamp, which presently uses a 1 Hz clock (ktime_get_seconds).

The TIME-WAIT block is enforced by __{inet,inet6}_check_established ->
tcp_twsk_unique, where we check if the timestamp clock has ticked since the last
ts_recent_stamp update before allowing the 4-tuple to be reused.

This mechanism, introduced in 2002 by commit b8439924316d ("Allow to bind to an
already in use local port during connect") [1], protects the TCP receiver
against segments from an earlier incarnation of the same connection (FIN
retransmits), which could potentially corrupt the TCP stream, as described by
RFC 7323 [2, 3].

Problem
=======

The one-second reincarnation period has not posed a problem when we had a
sufficiently large pool of ephemeral ports (tens of thousands per host).
However, as we began sharing egress IPv4 addresses between hosts by partitioning
the available port range [4], the ephemeral port pool size has shrunk
significantly—down to hundreds of ports per host.

This reduction in port pool size has made it clear that a one-second connection
reincarnation period can lead to ephemeral port exhaustion. Short-lived TCP
connections, such as DNS queries, can complete in milliseconds, yet the TCP
4-tuple remains blocked for a period of time that is orders of magnitude longer.

Solution
========

We would like to propose to shorten the period during which the 4-tuple is tied
up. The intention is to enable TIME-WAIT reuse at least as quickly as it takes
nowadays to perform of a short-lived TCP connection, from setup to teardown.

The ts_recent_stamp protection is based on the same principle as PAWS but
extends it across TCP connections. As RFC 7323 outlines in Appendix B.2, point
(b):

    An additional mechanism could be added to the TCP, a per-host
    cache of the last timestamp received from any connection.  This
    value could then be used in the PAWS mechanism to reject old
    duplicate segments from earlier incarnations of the connection,
    if the timestamp clock can be guaranteed to have ticked at least
    once since the old connection was open.  This would require that
    the TIME-WAIT delay plus the RTT together must be at least one
    tick of the sender's timestamp clock.  Such an extension is not
    part of the proposal of this RFC.

Due to that, we would want to follow the same guidelines as the for TSval
timestamp clock, for which RFC 7323 recommends a frequency in the range of 1 ms
to 1 sec per tick [5], when reconsidering the default setting.

(Note that the Linux TCP stack has recently introduced even finer granularity
with microsecond TSval resolution in commit 614e8316aa4c "tcp: add support for
usec resolution in TCP TS values" [6] for use in private networks.)

A simple implementation could be to switch from a second to a millisecond clock,
as demonstrated by the following patch. However, this could also be a tunable
option to allow administrators to adjust it based on their specific needs and
risk tolerance.

A tunable also opens the door to letting users set the TIME-WAIT reuse period
beyond the RFC 7323 recommended range at their own risk.

Workaround
==========

Today, when an application has only a small ephemeral port pool available, we
work around the 1-second reincarnation period by manually selecting the local
port with an explicit bind().

This has been possible since the introduction of the ts_recent_stamp protection
mechanism [1]. However, it is unclear why this is allowed for egress
connections.

To guide readers to the relevant code: if the local port is selected by the
user, we do not pass a TIME-WAIT socket to the check_established helper from
__inet_hash_connect. This way we circumvent the timestamp check in
tcp_twsk_unique [7] (as twp is NULL).

However, relying on this workaround conflicts with our goal of delegating TCP
local port selection to the network stack, using the IP_BIND_ADDRESS_NO_PORT [8]
and IP_LOCAL_PORT_RANGE [9] socket options.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8439924316d5bcb266d165b93d632a4b4b859af
[2] https://datatracker.ietf.org/doc/html/rfc7323#section-5.8
[3] https://datatracker.ietf.org/doc/html/rfc7323#appendix-B
[4] https://lpc.events/event/16/contributions/1349/
[5] https://datatracker.ietf.org/doc/html/rfc7323#section-5.4
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=614e8316aa4cafba3e204cb8ee48bd12b92f3d93
[7] https://elixir.bootlin.com/linux/v6.10/source/net/ipv4/tcp_ipv4.c#L156
[8] https://manpages.debian.org/unstable/manpages/ip.7.en.html#IP_BIND_ADDRESS_NO_PORT
[9] https://manpages.debian.org/unstable/manpages/ip.7.en.html#IP_LOCAL_PORT_RANGE
---

---
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c | 2 +-
 include/linux/tcp.h                                         | 4 ++--
 net/ipv4/tcp_input.c                                        | 2 +-
 net/ipv4/tcp_ipv4.c                                         | 5 ++---
 net/ipv4/tcp_minisocks.c                                    | 9 ++++++---
 5 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 6f6525983130..b15b26db8902 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -1866,7 +1866,7 @@ static void chtls_timewait(struct sock *sk)
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	tp->rcv_nxt++;
-	tp->rx_opt.ts_recent_stamp = ktime_get_seconds();
+	tp->rx_opt.ts_recent_stamp = tcp_clock_ms();
 	tp->srtt_us = 0;
 	tcp_time_wait(sk, TCP_TIME_WAIT, 0);
 }
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..174257114ee4 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -110,7 +110,7 @@ struct tcp_sack_block {
 
 struct tcp_options_received {
 /*	PAWS/RTTM data	*/
-	int	ts_recent_stamp;/* Time we stored ts_recent (for aging) */
+	u32	ts_recent_stamp;/* Time we stored ts_recent (for aging) */
 	u32	ts_recent;	/* Time stamp to echo next		*/
 	u32	rcv_tsval;	/* Time stamp value             	*/
 	u32	rcv_tsecr;	/* Time stamp echo reply        	*/
@@ -543,7 +543,7 @@ struct tcp_timewait_sock {
 	/* The time we sent the last out-of-window ACK: */
 	u32			  tw_last_oow_ack_time;
 
-	int			  tw_ts_recent_stamp;
+	u32			  tw_ts_recent_stamp;
 	u32			  tw_tx_delay;
 #ifdef CONFIG_TCP_MD5SIG
 	struct tcp_md5sig_key	  *tw_md5_key;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e37488d3453f..873a1cbd6d14 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3778,7 +3778,7 @@ static void tcp_send_challenge_ack(struct sock *sk)
 static void tcp_store_ts_recent(struct tcp_sock *tp)
 {
 	tp->rx_opt.ts_recent = tp->rx_opt.rcv_tsval;
-	tp->rx_opt.ts_recent_stamp = ktime_get_seconds();
+	tp->rx_opt.ts_recent_stamp = tcp_clock_ms();
 }
 
 static void tcp_replace_ts_recent(struct tcp_sock *tp, u32 seq)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index fd17f25ff288..47e2dcda4eae 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -116,7 +116,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	const struct inet_timewait_sock *tw = inet_twsk(sktw);
 	const struct tcp_timewait_sock *tcptw = tcp_twsk(sktw);
 	struct tcp_sock *tp = tcp_sk(sk);
-	int ts_recent_stamp;
+	u32 ts_recent_stamp;
 
 	if (reuse == 2) {
 		/* Still does not detect *everything* that goes through
@@ -157,8 +157,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	 */
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
 	if (ts_recent_stamp &&
-	    (!twp || (reuse && time_after32(ktime_get_seconds(),
-					    ts_recent_stamp)))) {
+	    (!twp || (reuse && (u32)tcp_clock_ms() != ts_recent_stamp))) {
 		/* inet_twsk_hashdance_schedule() sets sk_refcnt after putting twsk
 		 * and releasing the bucket lock.
 		 */
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a19a9dbd3409..d2a62c88806f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -101,7 +101,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	struct tcp_options_received tmp_opt;
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 	bool paws_reject = false;
-	int ts_recent_stamp;
+	u32 ts_recent_stamp;
 
 	tmp_opt.saw_tstamp = 0;
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
@@ -576,7 +576,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	if (newtp->rx_opt.tstamp_ok) {
 		newtp->tcp_usec_ts = treq->req_usec_ts;
 		newtp->rx_opt.ts_recent = READ_ONCE(req->ts_recent);
-		newtp->rx_opt.ts_recent_stamp = ktime_get_seconds();
+		newtp->rx_opt.ts_recent_stamp = tcp_clock_ms();
 		newtp->tcp_header_len = sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
 	} else {
 		newtp->tcp_usec_ts = 0;
@@ -659,6 +659,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
 		if (tmp_opt.saw_tstamp) {
+			unsigned int rsk_timeout;
+
 			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
 			if (tmp_opt.rcv_tsecr)
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
@@ -666,7 +668,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			 * it can be estimated (approximately)
 			 * from another data.
 			 */
-			tmp_opt.ts_recent_stamp = ktime_get_seconds() - reqsk_timeout(req, TCP_RTO_MAX) / HZ;
+			rsk_timeout = jiffies_to_msecs(reqsk_timeout(req, TCP_RTO_MAX));
+			tmp_opt.ts_recent_stamp = tcp_clock_ms() - rsk_timeout;
 			paws_reject = tcp_paws_reject(&tmp_opt, th->rst);
 		}
 	}


