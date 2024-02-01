Return-Path: <netdev+bounces-68217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733628462A5
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 22:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C6282D4C
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 21:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1180C3D0A6;
	Thu,  1 Feb 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0XonZpp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A43CF74
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823137; cv=none; b=l0WxKY4sPCl4H0uqbNwm217pc8iWvJz9aATgVNB9RXUkkhS3xPLWtnY3Y4lsslKozZBhsnn5landnSHBK1r2JegUrLlfm0VUAbYIMLxPrG/WkRS5msJI/kYu0zP+ePMk0i8KMP78kw25/KgLsDlYh/m9K1WBTBc85BJ8mAlcGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823137; c=relaxed/simple;
	bh=gcFRt6guRbJvRlfKKnLErbkDpMNlOkob/Z26kOlcSiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=We+9vmkhVVT+bsMOQYtH1pIiu/5pbfdPbHIPuAn6kXqAMNkdILd1x1H8XJI3WP2RaZZ85JImOGtqDZH4Drm7AVbeB1yJE4y3Em9+bWiwDSybChWsWEgQHKs8Yvwk99KgErMhzgEWz9/yUnH4XmqJ3QTFFFQWpi3hVWSKmi+P6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0XonZpp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706823133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n3PFqV4X+PAmUcO5sh2SGXfyFJPg8mnE8OvAkuTspNg=;
	b=B0XonZppfS3Xd3w4v3mL3SG30eIjsdNIJVwgS7osKAChWXIY8C0HhzEYKG25elBzsos5E4
	xSyiRTXDT00hHukMY4kJevgIp2Agq3eUcwMZlzO2uoQALAQJzhD48WqihYzGrcE/Ok5KPR
	Gm943tMriXp2sfIO+fpYqXAPl0XuQZo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-kK1pkJySO8aVi3DHnJbgXA-1; Thu,
 01 Feb 2024 16:32:10 -0500
X-MC-Unique: kK1pkJySO8aVi3DHnJbgXA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10B031C0690B;
	Thu,  1 Feb 2024 21:32:10 +0000 (UTC)
Received: from fenrir.redhat.com (unknown [10.22.8.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3CFAE492BC6;
	Thu,  1 Feb 2024 21:32:09 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com
Subject: [RFC net-next] tcp: add support for SO_PEEK_OFF
Date: Thu,  1 Feb 2024 16:32:01 -0500
Message-ID: <20240201213201.1228681-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

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
[  5]   0.00-10.04  sec  12.9 GBytes  11.0 Gbits/sec                  receiver
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
jmaloy@freyr:~/passt$ perf report -q --symbol-filter=do_syscall_64 -p ____sys_recvmsg -x --stdio -i  perf.data | head -1
    46.32%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg

With offset support:
----------------------
jmaloy@freyr:~/passt$ perf report -q --symbol-filter=do_syscall_64 -p ____sys_recvmsg -x --stdio -i  perf.data | head -1
   28.12%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg

Signed-off-by: Jon Maloy <jmaloy@redhat.com>
---
 include/net/tcp.h  |  1 +
 net/ipv4/af_inet.c |  1 +
 net/ipv4/tcp.c     | 25 +++++++++++++++++++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 87f0e6c2e1f2..7eca7f2ac102 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -357,6 +357,7 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family);
 ssize_t tcp_splice_read(struct socket *sk, loff_t *ppos,
 			struct pipe_inode_info *pipe, size_t len,
 			unsigned int flags);
+int tcp_set_peek_offset(struct sock *sk, int val);
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 				     bool force_schedule);
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index fb81de10d332..7a8b3a91257f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1068,6 +1068,7 @@ const struct proto_ops inet_stream_ops = {
 #endif
 	.splice_eof	   = inet_splice_eof,
 	.splice_read	   = tcp_splice_read,
+	.set_peek_off      = tcp_set_peek_offset,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
 	.sendmsg_locked    = tcp_sendmsg_locked,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fce5668a6a3d..33ade88633de 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -863,6 +863,14 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 }
 EXPORT_SYMBOL(tcp_splice_read);
 
+int tcp_set_peek_offset(struct sock *sk, int val)
+{
+	WRITE_ONCE(sk->sk_peek_off, val);
+
+	return 0;
+}
+EXPORT_SYMBOL(tcp_set_peek_offset);
+
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 				     bool force_schedule)
 {
@@ -2302,7 +2310,6 @@ static int tcp_inq_hint(struct sock *sk)
  *	tricks with *seq access order and skb->users are not required.
  *	Probably, code can be easily improved even more.
  */
-
 static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			      int flags, struct scm_timestamping_internal *tss,
 			      int *cmsg_flags)
@@ -2317,6 +2324,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	long timeo;
 	struct sk_buff *skb, *last;
 	u32 urg_hole = 0;
+	u32 peek_offset = 0;
 
 	err = -ENOTCONN;
 	if (sk->sk_state == TCP_LISTEN)
@@ -2349,7 +2357,8 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 
 	seq = &tp->copied_seq;
 	if (flags & MSG_PEEK) {
-		peek_seq = tp->copied_seq;
+		peek_offset = max(sk_peek_offset(sk, flags), 0);
+		peek_seq = tp->copied_seq + peek_offset;
 		seq = &peek_seq;
 	}
 
@@ -2452,11 +2461,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
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
 
@@ -2497,7 +2506,10 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
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
@@ -2774,6 +2786,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		data_was_unread += len;
 		__kfree_skb(skb);
 	}
+	sk_set_peek_off(sk, -1);
 
 	/* If socket has been already reset (e.g. in tcp_reset()) - kill it. */
 	if (sk->sk_state == TCP_CLOSE)
@@ -4492,7 +4505,7 @@ void tcp_done(struct sock *sk)
 		reqsk_fastopen_remove(sk, req, false);
 
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
-
+	sk_set_peek_off(sk, -1);
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk->sk_state_change(sk);
 	else
-- 
2.42.0


