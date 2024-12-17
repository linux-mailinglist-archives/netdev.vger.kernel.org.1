Return-Path: <netdev+bounces-152423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9769F3EA9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29DF16B135
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6273C442F;
	Tue, 17 Dec 2024 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="MWf0pwKQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C51361
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734394030; cv=none; b=uiPRnAnkLOfDan0nLSww3CYXICZeScVugxVfIJL4ZkHPgf+v/wkHwY1oCwpFMvEiyArjsQDBW0p3vXpg0WR3HF8hRDF5HCIlK9n9sJx0+1I253BNp0TdNiWNnBggjwlK4woOVKtMwBhlKcRyW21u5AQaoWa5q8g+UDyQaN2RDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734394030; c=relaxed/simple;
	bh=Tpu5KRKYW1lH+oRV9MuQ8IaE8fUrlZe05TqhARDzSNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoARLdKjuSfwqU8Tf4zW25v4hEBv96QwbeQ3ffQgXxg/OZDCnKK8wvvHveHpwnQ/8tlCAzUaQxN3EYm8RWxDyj0MhZIdWHJ9XiP7BRs0M9ZHgezJjb3COz+f6poQNYkhMZ0h1Rv+XqENOgiEn5tpFRGztVjj2Gb4/Ozuejr7/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=MWf0pwKQ; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YAym86nMDojupZVtMzLaoM8hJY5INpFKTrwTLS3XcnI=; t=1734394028; x=1735258028; 
	b=MWf0pwKQQSRCM83sX+RI1UzqSHVrM/1XANqBcMcLmz5zg5GW5S/EkKLonXJzfU8OWF5Ehvu4+zg
	hMSG0Z677hqAFVPrlUvjbG7bRf87nF8cgL/Yh0VaGbaaoMVBadG4dfhQbhPpCGRrDQEVfdMKyJDaL
	T/LOHLS6gKicbVEtYUO0gnDYxzUxG1+4nPA52oxuta3qvxKUaao18GiUQx3YODkCODfnYx4G+a8ab
	1RpPYgS065tGq1IY2cLQrfAcjo6POzLn2ZZGwLNv1bZEyd9+SOpYkoO3IlvHNHfO3OYT48OL6sO69
	8cPs9y2ayhIiA2mxW6T1tO3GqP5GBekFHI6w==;
Received: from ouster448.stanford.edu ([172.24.72.71]:53919 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tNL77-0002IN-71; Mon, 16 Dec 2024 16:07:02 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
Date: Mon, 16 Dec 2024 16:06:14 -0800
Message-ID: <20241217000626.2958-2-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241217000626.2958-1-ouster@cs.stanford.edu>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: a32b54b3e61ee546c29088a78f118104

Note: for man pages, see the Homa Wiki at:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 MAINTAINERS               |   7 ++
 include/uapi/linux/homa.h | 170 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)
 create mode 100644 include/uapi/linux/homa.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1389704c7d8d..935d1e995018 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10391,6 +10391,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HOMA TRANSPORT PROTOCOL
+M:	John Ousterhout <ouster@cs.stanford.edu>
+S:	Maintained
+W:	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
+F:	include/uapi/linux/homa.h
+F:	net/homa/
+
 HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
new file mode 100644
index 000000000000..555efa600b3f
--- /dev/null
+++ b/include/uapi/linux/homa.h
@@ -0,0 +1,170 @@
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
+ * define HOMA_MIN_DEFAULT_PORT - The 16-bit port space is divided into
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
+	uint32_t flags;
+
+	/**
+	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
+	 * Passes in bpages from previous messages that can now be
+	 * recycled; returns bpages from the new message.
+	 */
+	uint32_t num_bpages;
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
+	uint32_t bpage_offsets[HOMA_MAX_BPAGES];
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
+#define HOMA_RECVMSG_REQUEST       0x01
+#define HOMA_RECVMSG_RESPONSE      0x02
+#define HOMA_RECVMSG_NONBLOCKING   0x04
+#define HOMA_RECVMSG_VALID_FLAGS   0x07
+
+/** define SO_HOMA_RCVBUF - setsockopt option for specifying buffer region. */
+#define SO_HOMA_RCVBUF 10
+
+/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVBUF. */
+struct homa_rcvbuf_args {
+	/** @start: First byte of buffer region. */
+	void *start;
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
+ * define HOMA_FLAG_DONT_THROTTLE - disable the output throttling mechanism:
+ * always send all packets immediately.
+ */
+#define HOMA_FLAG_DONT_THROTTLE   2
+
+/* I/O control calls on Homa sockets. These are mapped into the
+ * SIOCPROTOPRIVATE range of 0x89e0 through 0x89ef.
+ */
+
+#define HOMAIOCFREEZE _IO(0x89, 0xef)
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _UAPI_LINUX_HOMA_H */
-- 
2.34.1


