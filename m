Return-Path: <netdev+bounces-63164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FA82B70F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 23:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136FF1F26391
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 22:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009AC58AB7;
	Thu, 11 Jan 2024 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC7UvpaN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212958AA6
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705011777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ldBbjlNyvJpqRT8UVQ1uTP+X4LUowOkKJYCUus9dCR8=;
	b=PC7UvpaNqXhp+bpgdKvECnepA9014x35vgaRrv0CCYG3VVv7r5JzqC8N6TevKVQw2Mupw9
	yzIQRGeC8BtcCELGFYZcuJ1CrnNkzQFRdxyHIdPbRPNQX8kMBOtzvY1hdCxf4GHUVVcOzT
	rmwoxFYHnnRst7uSzfI84bgLB0y/Xng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-KKIJZG1QMgCO-LRzswimeQ-1; Thu, 11 Jan 2024 17:22:56 -0500
X-MC-Unique: KKIJZG1QMgCO-LRzswimeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2586185A783;
	Thu, 11 Jan 2024 22:22:55 +0000 (UTC)
Received: from fenrir.redhat.com (unknown [10.22.16.242])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 696FD51D5;
	Thu, 11 Jan 2024 22:22:55 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com
Subject: [RFC net-next] tcp: add support for read with offset when using MSG_PEEK
Date: Thu, 11 Jan 2024 17:22:52 -0500
Message-ID: <20240111222252.221693-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

From: Jon Maloy <jmaloy@redhat.com>

When reading received messages with MSG_PEEK, we sometines have to read
the leading bytes of the stream several times, only to reach the bytes
we really want. This is clearly non-optimal.

What we would want is something similar to pread/preadv(), but working
even for tcp sockets. At the same time, we don't want to add any new
arguments to the recv/recvmsg() calls.

In this commit, we allow the user to set iovec.iov_base in the first
vector entry to NULL. This tells the socket to skip the first entry,
hence letting the iov_len field of that entry indicate the offset value.
This way, there is no need to add any new arguments or flags.

In the iperf3 logs examples shown below, we can observe a throughput
improvement of ~20 % in the direction host->namespace when using the
protocol splicer 'passt'. This is a consistent result.

$ ./passt/passt/pasta --config-net  -f
MSG_PEEK with offset not supported.
[root@fedora37 ~]# perf record iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 192.168.122.1, port 60344
[  6] local 192.168.122.163 port 5201 connected to 192.168.122.1 port 60360
[ ID] Interval           Transfer     Bitrate
{...]
[  6]  13.00-14.00  sec  2.54 GBytes  21.8 Gbits/sec
[  6]  14.00-15.00  sec  2.52 GBytes  21.7 Gbits/sec
[  6]  15.00-16.00  sec  2.50 GBytes  21.5 Gbits/sec
[  6]  16.00-17.00  sec  2.49 GBytes  21.4 Gbits/sec
[  6]  17.00-18.00  sec  2.51 GBytes  21.6 Gbits/sec
[  6]  18.00-19.00  sec  2.48 GBytes  21.3 Gbits/sec
[  6]  19.00-20.00  sec  2.49 GBytes  21.4 Gbits/sec
[  6]  20.00-20.04  sec  87.4 MBytes  19.2 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  6]   0.00-20.04  sec  48.9 GBytes  21.0 Gbits/sec receiver
-----------------------------------------------------------

[jmaloy@fedora37 ~]$ ./passt/passt/pasta --config-net  -f
MSG_PEEK with offset supported.
[root@fedora37 ~]# perf record iperf3 -s
-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------
Accepted connection from 192.168.122.1, port 46362
[  6] local 192.168.122.163 port 5201 connected to 192.168.122.1 port 46374
[ ID] Interval           Transfer     Bitrate
[...]
[  6]  12.00-13.00  sec  3.18 GBytes  27.3 Gbits/sec
[  6]  13.00-14.00  sec  3.17 GBytes  27.3 Gbits/sec
[  6]  14.00-15.00  sec  3.13 GBytes  26.9 Gbits/sec
[  6]  15.00-16.00  sec  3.17 GBytes  27.3 Gbits/sec
[  6]  16.00-17.00  sec  3.17 GBytes  27.2 Gbits/sec
[  6]  17.00-18.00  sec  3.14 GBytes  27.0 Gbits/sec
[  6]  18.00-19.00  sec  3.17 GBytes  27.2 Gbits/sec
[  6]  19.00-20.00  sec  3.12 GBytes  26.8 Gbits/sec
[  6]  20.00-20.04  sec   119 MBytes  25.5 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  6]   0.00-20.04  sec  59.4 GBytes  25.4 Gbits/sec receiver
-----------------------------------------------------------

Passt is used to support VMs in containers, such as KubeVirt, and
is also generally supported in libvirt/QEMU since release 9.2 / 7.2.

Signed-off-by: Jon Maloy <jmaloy@redhat.com>
Signed-off-by: Jon Paul Maloy <jmaloy@redhat.com>
---
 net/ipv4/tcp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..e9d3b5bf2f66 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2310,6 +2310,7 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			      int *cmsg_flags)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	size_t peek_offset;
 	int copied = 0;
 	u32 peek_seq;
 	u32 *seq;
@@ -2353,6 +2354,20 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	if (flags & MSG_PEEK) {
 		peek_seq = tp->copied_seq;
 		seq = &peek_seq;
+		if (!msg->msg_iter.__iov[0].iov_base) {
+			peek_offset = msg->msg_iter.__iov[0].iov_len;
+			msg->msg_iter.__iov = &msg->msg_iter.__iov[1];
+			if (msg->msg_iter.nr_segs <= 1)
+				goto out;
+			msg->msg_iter.nr_segs -= 1;
+			if (msg->msg_iter.count <= peek_offset)
+				goto out;
+			msg->msg_iter.count -= peek_offset;
+			if (len <= peek_offset)
+				goto out;
+			len -= peek_offset;
+			*seq += peek_offset;
+		}
 	}
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
-- 
2.39.0


