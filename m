Return-Path: <netdev+bounces-139684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CC49B3CEB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B6A1F21571
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B591DFE2B;
	Mon, 28 Oct 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="eRajWTD0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BC61E22EF
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151458; cv=none; b=Ae98JQQSppyh9Qq/Qwel9t/jy0kUhi/epjtEnbQ3eMr3dicmnmNiMOVreBiB8pQSDw3s/jD0DM+6933WACsgQsNA9iFThPq/YshcwzWgW3FVwAf79v16Cyl35ZnzJF3qR6eaDW6C3qABkqOVxB/Q9hRyLMXEvuHIuBY9nfh9GTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151458; c=relaxed/simple;
	bh=rkABdtpdZQgMw9KpwwCPQnqjc5Zh1orI2MZQCPdhFI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPxcsFtU6gGYzdQIjx6ves9LqAWvCNDrp8C99D7BRWE5cQgG9CUQduoyLeZcee8RImBUD9jSqfp1/nZ04yZiC2tC7MHz5qQlsn95LyojUgwSjEkQyFbRuO6ICDCZ5Jk4GtTHB7pRCmOWsVqbgQhIh3Of28dKNbyr1XtmBA3TZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=eRajWTD0; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k/waYF7swEutjGVEqGtZvwtJ1dlrOc5cg0ch+n/cOZg=; t=1730151455; x=1731015455; 
	b=eRajWTD08Ytgqau7you1otCZVRq6S0NKsWKFk55KsMtxTPVH8IEJvc4haj0HoLs69rMdjTihCAf
	IL+8IFOful12zezrRGg+7MxgxGmDq4Ogmf7WLUikkRlQSFiKZSwuZ4coeDpNf7RlLNubOmmgTzvPV
	xejhJaaVjK2YoK4VtxrcYgaPdSkYLYs20UYLxMlFfaPC2+3Uq7pxlSNzKAO96WBaD4o1/fvQQOJi+
	ETADx9jhP1oQA0EEiSt5BNP3rZXqwX7hHXPYApGl2kp8MXqe/kA2x7fdLSoTW2aDgTXAeDOEJlfAc
	DdLLnLDYWBPjSEG+9qrDmRCfjo6xchOsAylQ==;
Received: from ouster2016.stanford.edu ([172.24.72.71]:54106 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t5XPJ-0005xj-69; Mon, 28 Oct 2024 14:36:13 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next 01/12] net: homa: define user-visible API for Homa
Date: Mon, 28 Oct 2024 14:35:28 -0700
Message-ID: <20241028213541.1529-2-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241028213541.1529-1-ouster@cs.stanford.edu>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 21932f0bb9e8b158673ea01bbd84b966

Note: for man pages, see the Homa Wiki at:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 include/uapi/linux/homa.h | 199 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100644 include/uapi/linux/homa.h

diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
new file mode 100644
index 000000000000..306d272e4b63
--- /dev/null
+++ b/include/uapi/linux/homa.h
@@ -0,0 +1,199 @@
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
+#ifdef __cplusplus
+extern "C"
+{
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
+#define HOMA_BPAGE_SHIFT 16
+#define HOMA_BPAGE_SIZE (1 << HOMA_BPAGE_SHIFT)
+
+/**
+ * define HOMA_MAX_BPAGES: The largest number of bpages that will be required
+ * to store an incoming message.
+ */
+#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1) \
+		>> HOMA_BPAGE_SHIFT)
+
+/**
+ * define HOMA_MIN_DEFAULT_PORT - The 16-bit port space is divided into
+ * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
+ * for well-defined server ports. The remaining ports are used for client
+ * ports; these are allocated automatically by Homa. Port 0 is reserved.
+ */
+#define HOMA_MIN_DEFAULT_PORT 0x8000
+
+/**
+ * Holds either an IPv4 or IPv6 address (smaller and easier to use than
+ * sockaddr_storage).
+ */
+union sockaddr_in_union {
+	struct sockaddr sa;
+	struct sockaddr_in in4;
+	struct sockaddr_in6 in6;
+};
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
+	uint64_t id;
+
+	/**
+	 * @completion_cookie: (in) Used only for request messages; will be
+	 * returned by recvmsg when the RPC completes. Typically used to
+	 * locate app-specific info about the RPC.
+	 */
+	uint64_t completion_cookie;
+};
+
+#if !defined(__cplusplus)
+_Static_assert(sizeof(struct homa_sendmsg_args) >= 16,
+	       "homa_sendmsg_args shrunk");
+_Static_assert(sizeof(struct homa_sendmsg_args) <= 16,
+	       "homa_sendmsg_args grew");
+#endif
+
+/**
+ * struct homa_recvmsg_args - Provides information needed by Homa's
+ * recvmsg; passed to recvmsg using the msg_control field.
+ */
+struct homa_recvmsg_args {
+	/**
+	 * @id: (in/out) Initially specifies the id of the desired RPC, or 0
+	 * if any RPC is OK; returns the actual id received.
+	 */
+	uint64_t id;
+
+	/**
+	 * @completion_cookie: (out) If the incoming message is a response,
+	 * this will return the completion cookie specified when the
+	 * request was sent. For requests this will always be zero.
+	 */
+	uint64_t completion_cookie;
+
+	/**
+	 * @flags: (in) OR-ed combination of bits that control the operation.
+	 * See below for values.
+	 */
+	int flags;
+
+	/**
+	 * @error_addr: the address of the peer is stored here when available.
+	 * This field is different from the msg_name field in struct msghdr
+	 * in that the msg_name field isn't set after errors. This field will
+	 * always be set when peer information is available, which includes
+	 * some error cases.
+	 */
+	union sockaddr_in_union peer_addr;
+
+	/**
+	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
+	 * Passes in bpages from previous messages that can now be
+	 * recycled; returns bpages from the new message.
+	 */
+	uint32_t num_bpages;
+
+	uint32_t _pad[1];
+
+	/**
+	 * @bpage_offsets: (in/out) Each entry is an offset into the buffer
+	 * region for the socket pool. When returned from recvmsg, the
+	 * offsets indicate where fragments of the new message are stored. All
+	 * entries but the last refer to full buffer pages (HOMA_BPAGE_SIZE bytes)
+	 * and are bpage-aligned. The last entry may refer to a bpage fragment and
+	 * is not necessarily aligned. The application now owns these bpages and
+	 * must eventually return them to Homa, using bpage_offsets in a future
+	 * recvmsg invocation.
+	 */
+	uint32_t bpage_offsets[HOMA_MAX_BPAGES];
+};
+
+#if !defined(__cplusplus)
+_Static_assert(sizeof(struct homa_recvmsg_args) >= 120,
+	       "homa_recvmsg_args shrunk");
+_Static_assert(sizeof(struct homa_recvmsg_args) <= 120,
+	       "homa_recvmsg_args grew");
+#endif
+
+/* Flag bits for homa_recvmsg_args.flags (see man page for documentation):
+ */
+#define HOMA_RECVMSG_REQUEST       0x01
+#define HOMA_RECVMSG_RESPONSE      0x02
+#define HOMA_RECVMSG_NONBLOCKING   0x04
+#define HOMA_RECVMSG_VALID_FLAGS   0x07
+
+/** define SO_HOMA_SET_BUF: setsockopt option for specifying buffer region. */
+#define SO_HOMA_SET_BUF 10
+
+/** struct homa_set_buf - setsockopt argument for SO_HOMA_SET_BUF. */
+struct homa_set_buf_args {
+	/** @start: First byte of buffer region. */
+	void *start;
+
+	/** @length: Total number of bytes available at @start. */
+	size_t length;
+};
+
+/**
+ * Meanings of the bits in Homa's flag word, which can be set using
+ * "sysctl /net/homa/flags".
+ */
+
+/**
+ * Disable the output throttling mechanism: always send all packets
+ * immediately.
+ */
+#define HOMA_FLAG_DONT_THROTTLE   2
+
+int     homa_send(int sockfd, const void *message_buf,
+		  size_t length, const union sockaddr_in_union *dest_addr,
+		  uint64_t *id, uint64_t completion_cookie);
+int     homa_sendv(int sockfd, const struct iovec *iov,
+		   int iovcnt, const union sockaddr_in_union *dest_addr,
+		   uint64_t *id, uint64_t completion_cookie);
+ssize_t homa_reply(int sockfd, const void *message_buf,
+		   size_t length, const union sockaddr_in_union *dest_addr,
+		   uint64_t id);
+ssize_t homa_replyv(int sockfd, const struct iovec *iov,
+		    int iovcnt, const union sockaddr_in_union *dest_addr,
+		    uint64_t id);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _UAPI_LINUX_HOMA_H */
-- 
2.34.1


