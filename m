Return-Path: <netdev+bounces-215919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AEB30E70
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC4EAA7AA6
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CB52E040F;
	Fri, 22 Aug 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UnVg07Ty"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61A1662E7;
	Fri, 22 Aug 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842671; cv=none; b=rleaB9MY6eHwqTCtPHR2oaZ2T7EmZfIP7X2J7fLLZeNshEumM+hClrw4VxL1O7TTltVXHikVsoAPpkI16S1nnn4uamYKGvuRx4GDwAMDzhDCxT/Bv0xHoa2ytsd+FZkwITFXWC4XRZpNuJzy58TG4LEhwBOCKGXYSnmrCp/wkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842671; c=relaxed/simple;
	bh=6bdEFkPP9mtL8SXN2YyvE+O8XqCKf7T664vIzlyCJ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lmoD3ZSjfqPq52gb42jQax8IwLr99udU6hHAXsCp3Spbll013XT8RxD8dEY5APyrqnCdMvM0KMDQzhcec4QMiVdu9CSH/Qd+SSAEkDReZ2YlF25jJumitZhwZVWaty0RR/+yDNscFcQ4c4Jpb15gUjTU9EkfLJc8qQVSYDpnjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UnVg07Ty; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755842665; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=v8DQvhGd0hsTZwVKh2gZIsPRps/MXpijPs1f0x0Pe6U=;
	b=UnVg07TyujxpwcAJHhK6CGD5MsE4yahq+Hj2IPrnl7jtFWQriLtyYJ9/mmENXmGwnNPTPleGMrgEExHS0JnP0Da49zG/kO63KTlNgczPAG8mlIamiMWhC+TEQUTw4K31orkdEFMOJfRAZ2pBC+3rY0GNUNKl9Gpa4fJ/FHS+V2Y=
Received: from localhost.localdomain(mailfrom:mii.w@linux.alibaba.com fp:SMTPD_---0WmId2o._1755842662 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 14:04:24 +0800
From: 'MingMing Wang' <mii.w@linux.alibaba.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ycheng@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	MingMing Wang <mii.w@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [RFC net] tcp: Fix orphaned socket stalling indefinitely in FIN-WAIT-1
Date: Fri, 22 Aug 2025 14:02:54 +0800
Message-ID: <20250822060254.74708-1-mii.w@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: MingMing Wang <mii.w@linux.alibaba.com>

An orphaned TCP socket can stall indefinitely in FIN-WAIT-1
if the following conditions are met:
1. net.ipv4.tcp_retries2 is set to a value ≤ 8;
2. The peer advertises a zero window, and the window never reopens.

Steps to reproduce:
1. Set up two instances with nmap installed: one will act as the server
   the other as the client
2. Execute on the server:
   a. lower rmem : `sysctl -w net.ipv4.tcp_rmem="16 32 32"`
   b. start a listener: `nc -l -p 1234`
3. Execute on the client:
   a. lower tcp_retries2: `sysctl -w net.ipv4.tcp_retries2=8`
   b. send pakcets: `cat /dev/zero | nc <server-ip> 1234`
   c. after five seconds, stop the process: `killall nc`
4. Execute on the server: `killall -STOP nc`
5. Expected abnormal result: using `ss` command, we'll notice that the
   client connection remains stuck in the FIN_WAIT1 state, and the
   backoff counter always be 8 and no longer increased, as shown below:
   ```
   FIN-WAIT-1 0      1389    172.16.0.2:50316    172.16.0.1:1234
         cubic wscale:2,7 rto:201 backoff:8 rtt:0.078/0.007 mss:36
		 ... other fields omitted ...
   ```
6. If we set tcp_retries2 to 15 and repeat the steps above, the FIN_WAIT1
   state will be forcefully reclaimed after about 5 minutes.

During the zero-window probe retry process, it will check whether the
current connection is alive or not. If the connection is not alive and
the counter of retries exceeds the maximum allowed `max_probes`, retry
process will be terminated.

In our case, when we set `net.ipv4.tcp_retries2` to 8 or a less value,
according to the current implementation, the `icsk->icsk_backoff` counter
will be capped at `net.ipv4.tcp_retries2`. The value calculated by
`inet_csk_rto_backoff` will always be too small, which means the
computed backoff duration will always be less than rto_max. As a result,
the alive check will always return true. The condition before the
`goto abort` statement is an logical AND condition, the abort branch
can never be reached.

So, the TCP retransmission backoff mechanism has two issues:

1. `icsk->icsk_backoff` should monotonically increase during probe
   transmission and, upon reaching the maximum backoff limit, the
   connection should be terminated. However, the backoff value itself
   must not be capped prematurely — it should only control when to abort.

2. The condition for orphaned connection abort was incorrectly based on
   connection liveness and probe count. It should instead consider whether
   the number of orphaned probes exceeds the intended limit.

To fix this, introduce a local variable `orphan_probes` to track orphan
probe attempts separately from `max_probes`, which is used for RTO
retransmissions. This decouples the two counters and prevents accidental
overwrites, ensuring correct timeout behavior for orphaned connections.

Fixes: b248230c34970 ("tcp: abort orphan sockets stalling on zero window probes")
Co-developed-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Co-developed-by: MingMing Wang <mii.w@linux.alibaba.com>
Signed-off-by: MingMing Wang <mii.w@linux.alibaba.com>

---
We couldn't determine the rationale behind the following check in tcp_send_probe0():
```
if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
    icsk->icsk_backoff++;
```

This condition appears to be the root cause of the observed stall.
However, it has existed in the kernel for over 20 years — which suggests
there might be a historical or subtle reason for its presence.

We would greatly appreciate it if anyone could shed
---
 net/ipv4/tcp_output.c | 4 +---
 net/ipv4/tcp_timer.c  | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index caf11920a878..21795d696e38 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4385,7 +4385,6 @@ void tcp_send_probe0(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	struct net *net = sock_net(sk);
 	unsigned long timeout;
 	int err;
 
@@ -4401,8 +4400,7 @@ void tcp_send_probe0(struct sock *sk)
 
 	icsk->icsk_probes_out++;
 	if (err <= 0) {
-		if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
-			icsk->icsk_backoff++;
+		icsk->icsk_backoff++;
 		timeout = tcp_probe0_when(sk, tcp_rto_max(sk));
 	} else {
 		/* If packet was not sent due to local congestion,
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index a207877270fb..4dba2928e1bf 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -419,9 +419,9 @@ static void tcp_probe_timer(struct sock *sk)
 	if (sock_flag(sk, SOCK_DEAD)) {
 		unsigned int rto_max = tcp_rto_max(sk);
 		const bool alive = inet_csk_rto_backoff(icsk, rto_max) < rto_max;
+		int orphan_probes = tcp_orphan_retries(sk, alive);
 
-		max_probes = tcp_orphan_retries(sk, alive);
-		if (!alive && icsk->icsk_backoff >= max_probes)
+		if (!alive || icsk->icsk_backoff >= orphan_probes)
 			goto abort;
 		if (tcp_out_of_resources(sk, true))
 			return;
-- 
2.46.0


