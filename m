Return-Path: <netdev+bounces-64472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8EF833561
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 17:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15A72830E4
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F915D294;
	Sat, 20 Jan 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ii4OrG0K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C40EBF
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705769548; cv=none; b=mNCFCptmvSVYZUFlX+88pbXJqvphEJDiHXJqJOZOJMbrbIrFAH8KfJgTRgtZkxTp9n3FaN7d9whdhJGoKK18vT3Y7li4OnWSGgRq5uSUJKpn6dRkNbBGY/fY6YsyIQkeXeDi+R7ADvzb8qJgA9roSjBnSuYCiXJmSlIESEitG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705769548; c=relaxed/simple;
	bh=McBVKXrTBoTQ+Ss+hM08XjKgFq3EH6+FoXNaX5fSUPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5aTTqR0070rwGzrdQyxyse1/D6YRTD/yj8RUe0AqMqqdePLQti9OSioygoRnX+WBfvPvFvkwQ226rE60/1u0EiWydTY0aqgljmUQEeYtkz/A1QYTEgrWIOc9xP1SpbJgHo1ckH3AsTeYVueITmK0Lo0RUDg91rx9ebOuQfpiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ii4OrG0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705769545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ob8mAcWo74LjEhdDE7gqkpwioqO++fhG4D1V0yB9X8=;
	b=Ii4OrG0KR5kbVFhvA+YaSG3FY8SCL9hd+/5r8Z1aKEH7dZ1VOVOwS56yUsHPSz2eXXu213
	nCa8vjML7wa/xxc18sZCEKXy7vd8v22jedn4cMbW5v+1GkMf0JuIJTUHqZco6HzF//48t9
	HpQLWZ+ITh+zZM/R5fZlc/onFb1ZwNU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-fR3NOMmaOFKr9TfhA_DnIw-1; Sat, 20 Jan 2024 11:52:22 -0500
X-MC-Unique: fR3NOMmaOFKr9TfhA_DnIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BD30185A781;
	Sat, 20 Jan 2024 16:52:22 +0000 (UTC)
Received: from fenrir.redhat.com (unknown [10.22.32.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A93FF40C6EBA;
	Sat, 20 Jan 2024 16:52:21 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com
Subject: [RFC net-next v2] tcp: add support for read with offset when using MSG_PEEK
Date: Sat, 20 Jan 2024 11:52:18 -0500
Message-ID: <20240120165218.2283302-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Jon Maloy <jmaloy@redhat.com>

When reading received messages from a socket with MSG_PEEK, we may want
to read the contents with an offset, like we can do with pread/preadv()
when reading files. Currently, it is not possible to do that.

In this commit, we allow the user to set iovec.iov_base in the first
vector entry to NULL. This tells the socket to skip the first entry,
hence letting the iov_len field of that entry indicate the offset value.
This way, there is no need to add any new arguments or flags.

In the iperf3 log examples shown below, we can observe a throughput
improvement of ~15 % in the direction host->namespace when using the
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
MSG_PEEK with offset not supported by kernel.

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
MSG_PEEK with offset supported by kernel.

jmaloy@freyr:~/passt# iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 192.168.122.1, port 40854
[  5] local 192.168.122.180 port 5201 connected to 192.168.122.1 port 40862
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec  1.22 GBytes  10.5 Gbits/sec
[  5]   1.00-2.00   sec  1.19 GBytes  10.2 Gbits/sec
[  5]   2.00-3.00   sec  1.22 GBytes  10.5 Gbits/sec
[  5]   3.00-4.00   sec  1.11 GBytes  9.56 Gbits/sec
[  5]   4.00-5.00   sec  1.20 GBytes  10.3 Gbits/sec
[  5]   5.00-6.00   sec  1.14 GBytes  9.80 Gbits/sec
[  5]   6.00-7.00   sec  1.17 GBytes  10.0 Gbits/sec
[  5]   7.00-8.00   sec  1.12 GBytes  9.61 Gbits/sec
[  5]   8.00-9.00   sec  1.13 GBytes  9.74 Gbits/sec
[  5]   9.00-10.00  sec  1.26 GBytes  10.8 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.04  sec  11.8 GBytes  10.1 Gbits/sec   receiver
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
   27.24%     0.00%  passt.avx2  [kernel.vmlinux]  [k] do_syscall_64  ____sys_recvmsg

Signed-off-by: Jon Maloy <jmaloy@redhat.com>

---
v2: Put test of msg->msg_iter.nr_segs before test on msg->msg_iter.__iov,
    since the latter may be uninitialized when other receive functions
    are used. Reported by Martin Zaharinov.
---
 net/ipv4/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fce5668a6a3d..e8fdf3617377 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2351,6 +2351,16 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	if (flags & MSG_PEEK) {
 		peek_seq = tp->copied_seq;
 		seq = &peek_seq;
+		if (msg->msg_iter.nr_segs > 1 && !msg->msg_iter.__iov[0].iov_base) {
+			size_t peek_offset;
+
+			peek_offset = msg->msg_iter.__iov[0].iov_len;
+			msg->msg_iter.__iov = &msg->msg_iter.__iov[1];
+			msg->msg_iter.nr_segs -= 1;
+			msg->msg_iter.count -= peek_offset;
+			len -= peek_offset;
+			*seq += peek_offset;
+		}
 	}
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
-- 
2.42.0


