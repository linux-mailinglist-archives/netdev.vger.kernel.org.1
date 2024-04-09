Return-Path: <netdev+bounces-86199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B727A89DF29
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 17:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569AD28BEA5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56673135A56;
	Tue,  9 Apr 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZcfkn0q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89B13541F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676494; cv=none; b=soApBJAe4PVMPwLo6tQwdWahBxMbENuqZE8vaNyco6rFqVGaMREnhx395PRYLJ2uS3iZqeoqDurOyKLzXePMsoUbZOcwoSabdhrzOZSLQU+2COgY3LR+5SgNxtAD8Qs0FCZkN7Mf2KZuGelRqkp+nf1Rvhun2MCtGErheStVJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676494; c=relaxed/simple;
	bh=z9GsAUOcb10kW10cXeTGlgDogI4Yv8S+kfEzRw148/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCntwNH1sO+2R/n7OgT4DlGNTFnGKvKRi1Eetqa/JdSK9P9ONxXaTUloa6Tpo8+Lh/EbitFCJbVJcGmVat2PefE3UvHclAPmMYJET5KFzc2pZyWQSKe5HdiFroGHRL/ObTcYawckyNGWAappeP1OWyCDmb19k+qd4mlomrB+GXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZcfkn0q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712676491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nkgYrxjL0uqszJbbD8cR7MTsYdHeRVM/o9fq3RdqUTs=;
	b=EZcfkn0quH5FhJInoxRzFpveW7CiVYOZBaHvHviXJAdUuxVp8p3LhdwBjnpVw2iasEkBtP
	t5S7WGVMu/CASCF6N/bcr5V0VNPx9d4u6JvAsuqi16Tp6ofjtdFNuWri2nvnI4VfstgsHw
	r/S00OtJ1yEhC8DyQmviFPRHOY6EmiQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-0D9dMticNoudtPSiNtVCjQ-1; Tue,
 09 Apr 2024 11:28:07 -0400
X-MC-Unique: 0D9dMticNoudtPSiNtVCjQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C66D380009E;
	Tue,  9 Apr 2024 15:28:07 +0000 (UTC)
Received: from fenrir.redhat.com (unknown [10.22.8.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4EC5D444301;
	Tue,  9 Apr 2024 15:28:06 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [net-next v4] tcp: add support for SO_PEEK_OFF socket option
Date: Tue,  9 Apr 2024 11:28:05 -0400
Message-ID: <20240409152805.913891-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Jon Maloy <jmaloy@redhat.com>

When reading received messages from a socket with MSG_PEEK, we may want
to read the contents with an offset, like we can do with pread/preadv()
when reading files. Currently, it is not possible to do that.

In this commit, we add support for the SO_PEEK_OFF socket option for TCP,
in a similar way it is done for Unix Domain sockets.

In the iperf3 log examples shown below, we can observe a throughput
improvement of 15-20 % in the direction host->namespace when using the
protocol splicer 'pasta' (https://passt.top).
This is a consistent result.

pasta(1) and passt(1) implement user-mode networking for network
namespaces (containers) and virtual machines by means of a translation
layer between Layer-2 network interface and native Layer-4 sockets
(TCP, UDP, ICMP/ICMPv6 echo).

Received, pending TCP data to the container/guest is kept in kernel
buffers until acknowledged, so the tool routinely needs to fetch new
data from socket, skipping data that was already sent.

At the moment this is implemented using a dummy buffer passed to
recvmsg(). With this change, we don't need a dummy buffer and the
related buffer copy (copy_to_user()) anymore.

passt and pasta are supported in KubeVirt and libvirt/qemu.

jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
SO_PEEK_OFF not supported by kernel.

jmaloy@freyr:~/passt# iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 192.168.122.1, port 44822
[  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 44832
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  1.02 GBytes  8.78 Gbits/sec
[  5]   1.00-2.00   sec  1.06 GBytes  9.08 Gbits/sec
[  5]   2.00-3.00   sec  1.07 GBytes  9.15 Gbits/sec
[  5]   3.00-4.00   sec  1.10 GBytes  9.46 Gbits/sec
[  5]   4.00-5.00   sec  1.03 GBytes  8.85 Gbits/sec
[  5]   5.00-6.00   sec  1.10 GBytes  9.44 Gbits/sec
[  5]   6.00-7.00   sec  1.11 GBytes  9.56 Gbits/sec
[  5]   7.00-8.00   sec  1.07 GBytes  9.20 Gbits/sec
[  5]   8.00-9.00   sec   667 MBytes  5.59 Gbits/sec
[  5]   9.00-10.00  sec  1.03 GBytes  8.83 Gbits/sec
[  5]  10.00-10.04  sec  30.1 MBytes  6.36 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.04  sec  10.3 GBytes  8.78 Gbits/sec   receiver
-----------------------------------------------------------
Server listening on 5201 (test #2)
-----------------------------------------------------------
^Ciperf3: interrupt - the server has terminated
jmaloy@freyr:~/passt#
logout
[ perf record: Woken up 23 times to write data ]
[ perf record: Captured and wrote 5.696 MB perf.data (35580 samples) ]
jmaloy@freyr:~/passt$

jmaloy@freyr:~/passt$ perf record -g ./pasta --config-net -f
SO_PEEK_OFF supported by kernel.

jmaloy@freyr:~/passt# iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 192.168.122.1, port 52084
[  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 52098
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  1.32 GBytes  11.3 Gbits/sec
[  5]   1.00-2.00   sec  1.19 GBytes  10.2 Gbits/sec
[  5]   2.00-3.00   sec  1.26 GBytes  10.8 Gbits/sec
[  5]   3.00-4.00   sec  1.36 GBytes  11.7 Gbits/sec
[  5]   4.00-5.00   sec  1.33 GBytes  11.4 Gbits/sec
[  5]   5.00-6.00   sec  1.21 GBytes  10.4 Gbits/sec
[  5]   6.00-7.00   sec  1.31 GBytes  11.2 Gbits/sec
[  5]   7.00-8.00   sec  1.25 GBytes  10.7 Gbits/sec
[  5]   8.00-9.00   sec  1.33 GBytes  11.5 Gbits/sec
[  5]   9.00-10.00  sec  1.24 GBytes  10.7 Gbits/sec
[  5]  10.00-10.04  sec  56.0 MBytes  12.1 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.04  sec  12.9 GBytes  11.0 Gbits/sec  receiver
-----------------------------------------------------------
Server listening on 5201 (test #2)
-----------------------------------------------------------
^Ciperf3: interrupt - the server has terminated
logout
[ perf record: Woken up 20 times to write data ]
[ perf record: Captured and wrote 5.040 MB perf.data (33411 samples) ]
jmaloy@freyr:~/passt$

The perf record confirms this result. Below, we can observe that the
CPU spends significantly less time in the function ____sys_recvmsg()
when we have offset support.

Without offset support:
----------------------
jmaloy@freyr:~/passt$ perf report -q --symbol-filter=do_syscall_64 \
                       -p ____sys_recvmsg -x --stdio -i  perf.data | head -1
46.32%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg

With offset support:
----------------------
jmaloy@freyr:~/passt$ perf report -q --symbol-filter=do_syscall_64 \
                       -p ____sys_recvmsg -x --stdio -i  perf.data | head -1
28.12%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jon Maloy <jmaloy@redhat.com>

---
v3: - Applied changes suggested by Stefano Brivio and Paolo Abeni
v4: - Same as v3. Posting was delayed because I first had to debug
      an issue that turned out to not be directly related to this
      change.

Signed-off-by: Jon Maloy <jmaloy@redhat.com>
---
 net/ipv4/af_inet.c |  1 +
 net/ipv4/tcp.c     | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 55bd72997b31..a7cfeda28bb2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1072,6 +1072,7 @@ const struct proto_ops inet_stream_ops = {
 #endif
 	.splice_eof	   = inet_splice_eof,
 	.splice_read	   = tcp_splice_read,
+	.set_peek_off      = sk_set_peek_off,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
 	.sendmsg_locked    = tcp_sendmsg_locked,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 92ee60492314..c0d6fd576d32 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1416,8 +1416,6 @@ static int tcp_peek_sndq(struct sock *sk, struct msghdr *msg, int len)
 	struct sk_buff *skb;
 	int copied = 0, err = 0;
 
-	/* XXX -- need to support SO_PEEK_OFF */
-
 	skb_rbtree_walk(skb, &sk->tcp_rtx_queue) {
 		err = skb_copy_datagram_msg(skb, 0, msg, skb->len);
 		if (err)
@@ -2328,6 +2326,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;		/* Read at least this many bytes */
 	long timeo;
 	struct sk_buff *skb, *last;
+	u32 peek_offset = 0;
 	u32 urg_hole = 0;
 
 	err = -ENOTCONN;
@@ -2361,7 +2360,8 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 
 	seq = &tp->copied_seq;
 	if (flags & MSG_PEEK) {
-		peek_seq = tp->copied_seq;
+		peek_offset = max(sk_peek_offset(sk, flags), 0);
+		peek_seq = tp->copied_seq + peek_offset;
 		seq = &peek_seq;
 	}
 
@@ -2464,11 +2464,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		if ((flags & MSG_PEEK) &&
-		    (peek_seq - copied - urg_hole != tp->copied_seq)) {
+		    (peek_seq - peek_offset - copied - urg_hole != tp->copied_seq)) {
 			net_dbg_ratelimited("TCP(%s:%d): Application bug, race in MSG_PEEK\n",
 					    current->comm,
 					    task_pid_nr(current));
-			peek_seq = tp->copied_seq;
+			peek_seq = tp->copied_seq + peek_offset;
 		}
 		continue;
 
@@ -2509,7 +2509,10 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 		WRITE_ONCE(*seq, *seq + used);
 		copied += used;
 		len -= used;
-
+		if (flags & MSG_PEEK)
+			sk_peek_offset_fwd(sk, used);
+		else
+			sk_peek_offset_bwd(sk, used);
 		tcp_rcv_space_adjust(sk);
 
 skip_copy:
@@ -3010,6 +3013,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	__skb_queue_purge(&sk->sk_receive_queue);
 	WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 	WRITE_ONCE(tp->urg_data, 0);
+	sk_set_peek_off(sk, -1);
 	tcp_write_queue_purge(sk);
 	tcp_fastopen_active_disable_ofo_check(sk);
 	skb_rbtree_purge(&tp->out_of_order_queue);
-- 
2.42.0


