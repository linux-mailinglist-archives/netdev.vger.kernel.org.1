Return-Path: <netdev+bounces-178467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16608A771A1
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5377E3ABDA9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F85121D3CC;
	Mon, 31 Mar 2025 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="dlUeWOxi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CE21D3C7
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465592; cv=none; b=QOJa5nLmMsEJhKe7Rr6v1QJuJmKa8T+ZLG8xQAP0uBXLfhmHthena3zOA+lz7DN7VlE98SGIT0EkoFAE6fvm9qaDrL08PmxoPScCNwvGs+1WERqgLQk7FadWDY0uRHxD/5PIRr572CDFSc0WHUR6sg/YwlVDL1Wg1GHDANlweCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465592; c=relaxed/simple;
	bh=UcERAP4tfPL2oTa2mBykpYPwwUGfgpheATL7/wytIuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyP55DOxJgDPanxZeeYrqPFKR0gTKQUjHGUf6ZoUwcgG0SSwBKF07jdUz5tJh4/EerMEvJXwqpiUJmC2/zYIv57Z1SYfCx+56hWtHohTbksgL0ut6xu0pKxuZxfQPJ0KzzxaI1jWsMmG9DIXhT1H1ssnTeD3lFvooS2xyI0M1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=dlUeWOxi; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wq7PBvrKNV+G0LcElUGMd5/8dcY2ww7PHAsI2nVSezo=; t=1743465590; x=1744329590; 
	b=dlUeWOxiUjqIa8L1zqaY8yjxAoBheQxlPC4GRrxO+FkHlLuKWO5/g/jJY6jAgy79wM4d79fXtVA
	JFo+RTS27ngaEors3VNIH8adAC9qYQLCLDjIg3T2HZn2bHHr4x56gxh0FkdDCKCOnLprt0lCdzadA
	lRXXDwmYw4WRzfPenP2hzkyFWpKRm+qN+L6a4SRcqjaIFKrR3WQj0BnazBhfQ5QOW5Yvj3TiQFP7j
	X9c/Nv26hVs+qlzxd8sQgVE8/A9XeepNETSa/37unjJ9m1fNxqX93zVV/Hp2SvRhXUj3UzZu8Gj/L
	divEgy4Xh2Gkg98zeS5qAcANZB4uZCbB24jw==;
Received: from ouster448.stanford.edu ([172.24.72.71]:55223 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tzOqH-000219-3Z; Mon, 31 Mar 2025 16:46:58 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v7 01/14] net: homa: define user-visible API for Homa
Date: Mon, 31 Mar 2025 16:45:34 -0700
Message-ID: <20250331234548.62070-2-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250331234548.62070-1-ouster@cs.stanford.edu>
References: <20250331234548.62070-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 00ae0dc23c387355c0c9f5c46aa55045

Note: for man pages, see the Homa Wiki at:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v7:
* Add HOMA_SENDMSG_NONBLOCKING flag for sendmsg
* API changes for new mechanism for waiting for incoming messages
* Add setsockopt SO_HOMA_SERVER (enable incoming requests)
* Use u64 and __u64 properly
---
 include/uapi/linux/homa.h | 196 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 include/uapi/linux/homa.h

diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
new file mode 100644
index 000000000000..f67e93271283
--- /dev/null
+++ b/include/uapi/linux/homa.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file defines the kernel call interface for the Homa
+ * transport protocol.
+ */
+
+#ifndef _UAPI_LINUX_HOMA_H
+#define _UAPI_LINUX_HOMA_H
+
+#include <linux/types.h>
+#ifndef __KERNEL__
+#include <netinet/in.h>
+#include <sys/socket.h>
+#endif
+
+/* IANA-assigned Internet Protocol number for Homa. */
+#define IPPROTO_HOMA 146
+
+/**
+ * define HOMA_MAX_MESSAGE_LENGTH - Maximum bytes of payload in a Homa
+ * request or response message.
+ */
+#define HOMA_MAX_MESSAGE_LENGTH 1000000
+
+/**
+ * define HOMA_BPAGE_SIZE - Number of bytes in pages used for receive
+ * buffers. Must be power of two.
+ */
+#define HOMA_BPAGE_SIZE (1 << HOMA_BPAGE_SHIFT)
+#define HOMA_BPAGE_SHIFT 16
+
+/**
+ * define HOMA_MAX_BPAGES - The largest number of bpages that will be required
+ * to store an incoming message.
+ */
+#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1) \
+		>> HOMA_BPAGE_SHIFT)
+
+/**
+ * define HOMA_MIN_DEFAULT_PORT - The 16 bit port space is divided into
+ * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
+ * for well-defined server ports. The remaining ports are used for client
+ * ports; these are allocated automatically by Homa. Port 0 is reserved.
+ */
+#define HOMA_MIN_DEFAULT_PORT 0x8000
+
+/**
+ * struct homa_sendmsg_args - Provides information needed by Homa's
+ * sendmsg; passed to sendmsg using the msg_control field.
+ */
+struct homa_sendmsg_args {
+	/**
+	 * @id: (in/out) An initial value of 0 means a new request is
+	 * being sent; nonzero means the message is a reply to the given
+	 * id. If the message is a request, then the value is modified to
+	 * hold the id of the new RPC.
+	 */
+	__u64 id;
+
+	/**
+	 * @completion_cookie: (in) Used only for request messages; will be
+	 * returned by recvmsg when the RPC completes. Typically used to
+	 * locate app-specific info about the RPC.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @flags: (in) OR-ed combination of bits that control the operation.
+	 * See below for values.
+	 */
+	__u32 flags;
+
+	__u32 reserved;
+};
+
+#if !defined(__cplusplus)
+_Static_assert(sizeof(struct homa_sendmsg_args) >= 24,
+	       "homa_sendmsg_args shrunk");
+_Static_assert(sizeof(struct homa_sendmsg_args) <= 24,
+	       "homa_sendmsg_args grew");
+#endif
+
+/* Flag bits for homa_sendmsg_args.flags (see man page for documentation):
+ */
+#define HOMA_SENDMSG_PRIVATE       0x01
+#define HOMA_SENDMSG_NONBLOCKING   0x02
+#define HOMA_SENDMSG_VALID_FLAGS   0x03
+
+/**
+ * struct homa_recvmsg_args - Provides information needed by Homa's
+ * recvmsg; passed to recvmsg using the msg_control field.
+ */
+struct homa_recvmsg_args {
+	/**
+	 * @id: (in/out) Initial value is 0 to wait for any shared RPC;
+	 * nonzero means wait for that specific (private) RPC. Returns
+	 * the id of the RPC received.
+	 */
+	__u64 id;
+
+	/**
+	 * @completion_cookie: (out) If the incoming message is a response,
+	 * this will return the completion cookie specified when the
+	 * request was sent. For requests this will always be zero.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @flags: (in) OR-ed combination of bits that control the operation.
+	 * See below for values.
+	 */
+	__u32 flags;
+
+	/**
+	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
+	 * Passes in bpages from previous messages that can now be
+	 * recycled; returns bpages from the new message.
+	 */
+	__u32 num_bpages;
+
+	/**
+	 * @bpage_offsets: (in/out) Each entry is an offset into the buffer
+	 * region for the socket pool. When returned from recvmsg, the
+	 * offsets indicate where fragments of the new message are stored. All
+	 * entries but the last refer to full buffer pages (HOMA_BPAGE_SIZE
+	 * bytes) and are bpage-aligned. The last entry may refer to a bpage
+	 * fragment and is not necessarily aligned. The application now owns
+	 * these bpages and must eventually return them to Homa, using
+	 * bpage_offsets in a future recvmsg invocation.
+	 */
+	__u32 bpage_offsets[HOMA_MAX_BPAGES];
+};
+
+#if !defined(__cplusplus)
+_Static_assert(sizeof(struct homa_recvmsg_args) >= 88,
+	       "homa_recvmsg_args shrunk");
+_Static_assert(sizeof(struct homa_recvmsg_args) <= 88,
+	       "homa_recvmsg_args grew");
+#endif
+
+/* Flag bits for homa_recvmsg_args.flags (see man page for documentation):
+ */
+#define HOMA_RECVMSG_NONBLOCKING   0x01
+#define HOMA_RECVMSG_VALID_FLAGS   0x01
+
+/** define SO_HOMA_RCVBUF: setsockopt option for specifying buffer region. */
+#define SO_HOMA_RCVBUF 10
+
+/**
+ * define SO_HOMA_SERVER: setsockopt option for specifying whether a
+ * socket will act as server.
+ */
+#define SO_HOMA_SERVER 11
+
+/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVBUF. */
+struct homa_rcvbuf_args {
+	/** @start: Address of first byte of buffer region in user space. */
+	__u64 start;
+
+	/** @length: Total number of bytes available at @start. */
+	size_t length;
+};
+
+/* Meanings of the bits in Homa's flag word, which can be set using
+ * "sysctl /net/homa/flags".
+ */
+
+/**
+ * define HOMA_FLAG_DONT_THROTTLE - disable the output throttling mechanism
+ * (always send all packets immediately).
+ */
+#define HOMA_FLAG_DONT_THROTTLE   2
+
+/**
+ * I/O control calls on Homa sockets. These are mapped into the
+ * SIOCPROTOPRIVATE range of 0x89e0 through 0x89ef.
+ */
+
+#define HOMAIOCFREEZE _IO(0x89, 0xef)
+
+int     homa_send(int sockfd, const void *message_buf,
+		  size_t length, const struct sockaddr *dest_addr,
+		  __u32 addrlen,  __u64 *id, __u64 completion_cookie,
+		  int flags);
+int     homa_sendv(int sockfd, const struct iovec *iov,
+		   int iovcnt, const struct sockaddr *dest_addr,
+		   __u32 addrlen,  __u64 *id, __u64 completion_cookie,
+		   int flags);
+ssize_t homa_reply(int sockfd, const void *message_buf,
+		   size_t length, const struct sockaddr *dest_addr,
+		   __u32 addrlen,  __u64 id);
+ssize_t homa_replyv(int sockfd, const struct iovec *iov,
+		    int iovcnt, const struct sockaddr *dest_addr,
+		    __u32 addrlen,  __u64 id);
+
+#endif /* _UAPI_LINUX_HOMA_H */
-- 
2.34.1


