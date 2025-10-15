Return-Path: <netdev+bounces-229725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B395BE0456
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4D27347E8F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A326F302151;
	Wed, 15 Oct 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="gQUVtleb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F36302167
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554365; cv=none; b=DEt+pRNqlhahxSypHJdh5ZAhfID5qIuKO8ohJ/ClaGkh2O/5TB+ViZBAVzRkEn3OuId+lnuSPXCOlgPW7KXqlrZXezcSsV2b0jc4EaY61cwfpQ6HTeMX2CUVzwOYUPBCOmuwg5ywUUYnCFFRh+0ZWQPEGvIaJ5zCU5QRWdsA8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554365; c=relaxed/simple;
	bh=a2fp/c3RQi9oWmcsR0NH/A5OGHxw1dQWW6eHxdJIaFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXaJX21ZJfofQotpnAJlOhSIvP3LCQXEXznIYjrTqA+gShulnE5KoBdXkWN9UBeXr0FCj5QJK4zwkvn1g6C7p+EsH/W8Yy8j2BLiaD3/Wirih5KIMH6MAIvta/qQR+4Z2+2cipxE1MUm4OjHIrmg3Y78Uw/1B/kjfpLWGXb7vs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=gQUVtleb; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N3cn1x2SowvMPqqHdpPv0aUjQ7hOZxYyZHBst2zEWmM=; t=1760554363; x=1761418363; 
	b=gQUVtleb6ePIkcZ6hJBQ5qnSHwevpL1vD6T1z2goOa5claiqOUrK5W7iiXArTEn4ir8/7UTv+JZ
	exVlKMuc5NVmxy14rvleJ3olP58I0OiG6oSdjWmdur7lqVVjeCty5JLQyaj0ZC6Zjb8LX0YGu8wI5
	WnypLmvxzE/xHi/9Me4FOOCb7dKI2LI7dHQA4kTvmwb9Ocu7S5QIVdMhkHUvndDVZd7dyUCb0DI6k
	hQf7fwVsMyYgayH8268QMF5kubn+xTbEFj9941ogO42PVe0/T7M90lE2siCVPAfbfB3wP3+BE6cbL
	/o+dBQkRpFG53dSrL+QQa7R7VMMNIHEyg9TQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:50623 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1v96b4-00063x-3m; Wed, 15 Oct 2025 11:51:39 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v16 01/14] net: homa: define user-visible API for Homa
Date: Wed, 15 Oct 2025 11:50:48 -0700
Message-ID: <20251015185102.2444-2-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20251015185102.2444-1-ouster@cs.stanford.edu>
References: <20251015185102.2444-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: ff940fef6e54d16082d5a75293152dce

Note: for man pages, see the Homa Wiki at:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v16:
* Implement HOMAIOCINFO ioctl.

Changes for v14:
* Add "WITH Linux-syscall-note" SPDX license note

Changes for v11:
* Add explicit padding to struct homa_recvmsg_args to fix problems compiling
  on 32-bit machines.

Changes for v9:
* Eliminate use of _Static_assert
* Remove declarations related to now-defunct homa_api.c

Changes for v7:
* Add HOMA_SENDMSG_NONBLOCKING flag for sendmsg
* API changes for new mechanism for waiting for incoming messages
* Add setsockopt SO_HOMA_SERVER (enable incoming requests)
* Use u64 and __u64 properly
---
 MAINTAINERS               |   6 +
 include/uapi/linux/homa.h | 300 ++++++++++++++++++++++++++++++++++++++
 net/Kconfig               |   1 +
 net/Makefile              |   1 +
 4 files changed, 308 insertions(+)
 create mode 100644 include/uapi/linux/homa.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 97d958c945e4..9dd7506b502e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11185,6 +11185,12 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HOMA TRANSPORT PROTOCOL
+M:	John Ousterhout <ouster@cs.stanford.edu>
+S:	Maintained
+F:	net/homa/
+F:	include/uapi/linux/homa.h
+
 HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
new file mode 100644
index 000000000000..77e89f538258
--- /dev/null
+++ b/include/uapi/linux/homa.h
@@ -0,0 +1,300 @@
+/* SPDX-License-Identifier: BSD-2-Clause or GPL-2.0+ WITH Linux-syscall-note */
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
+#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1) >> \
+		HOMA_BPAGE_SHIFT)
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
+	/** @reserved: Not currently used, must be 0. */
+	__u32 reserved;
+};
+
+/* Flag bits for homa_sendmsg_args.flags (see man page for documentation):
+ */
+#define HOMA_SENDMSG_PRIVATE       0x01
+#define HOMA_SENDMSG_VALID_FLAGS   0x01
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
+	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
+	 * Passes in bpages from previous messages that can now be
+	 * recycled; returns bpages from the new message.
+	 */
+	__u32 num_bpages;
+
+	/** @reserved: Not currently used, must be 0. */
+	__u32 reserved;
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
+ * struct homa_rpc_info - Used by HOMAIOCINFO to return information about
+ * a specific RPC.
+ */
+struct homa_rpc_info {
+	/**
+	 * @id: Identifier for the RPC, unique among all RPCs sent by the
+	 * client node. If the low-order bit is 1, this node is the server
+	 * for the RPC; 0 means we are the client.
+	 */
+	__u64 id;
+
+	/** @peer: Address of the peer socket for this RPC. */
+	union {
+		struct sockaddr_storage storage;
+		struct sockaddr_in in4;
+		struct sockaddr_in6 in6;
+	} peer;
+
+	/**
+	 * @completion_cookie: For client-side RPCs this gives the completion
+	 * cookie specified when the RPC was initiated. For server-side RPCs
+	 * this is zero.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @tx_length: Length of the outgoing message in bytes, or -1 if
+	 * the sendmsg hasn't yet been called.
+	 */
+	__s32 tx_length;
+
+	/**
+	 * @tx_sent: Number of bytes of the outgoing message that have been
+	 * transmitted at least once.
+	 */
+	__u32 tx_sent;
+
+	/**
+	 * @tx_granted: Number of bytes of the outgoing message that the
+	 * receiver has authorized us to transmit (includes unscheduled
+	 * bytes).
+	 */
+	__u32 tx_granted;
+
+	/** @reserved: Reserved for future use. */
+	__u32 reserved;
+
+	/**
+	 * @rx_length: Length of the incoming message, in bytes. -1 means
+	 * the length is not yet known (this is a client-side RPC and
+	 * no packets have been received).
+	 */
+	__s32 rx_length;
+
+	/**
+	 * @rx_remaining: Number of bytes in the incoming message that have
+	 * not yet been received.
+	 */
+	__u32 rx_remaining;
+
+	/**
+	 * @rx_gaps: The number of gaps in the incoming message. A gap is
+	 * a range of bytes that have not been received yet, but bytes after
+	 * the gap have been received.
+	 */
+	__u32 rx_gaps;
+
+	/**
+	 * @rx_gap_bytes: The total number of bytes in gaps in the incoming
+	 * message.
+	 */
+	__u32 rx_gap_bytes;
+
+	/**
+	 * @rx_granted: The number of bytes in the message that the sender
+	 * is authorized to transmit (includes unscheduled bytes).
+	 */
+	__u32 rx_granted;
+
+	/**
+	 * @flags: Various single-bit values associated with the RPC:
+	 * HOMA_RPC_BUF_STALL:  The incoming message is currently stalled
+	 *                      because there is insufficient receiver buffer
+	 *                      space.
+	 * HOMA_RPC_PRIVATE:    The RPC has been created as "private"; set
+	 *                      only on the client side.
+	 * HOMA_RPC_RX_READY:   The incoming message is complete and has
+	 *                      been queued waiting for a thread to call
+	 *                      recvmsg.
+	 * HOMA_RPC_RX_COPY:    There are packets that have been received,
+	 *                      whose data has not yet been copied from
+	 *                      packet buffers to user space.
+	 */
+	__u16 flags;
+#define HOMA_RPC_BUF_STALL    1
+#define HOMA_RPC_PRIVATE      2
+#define HOMA_RPC_RX_READY     4
+#define HOMA_RPC_RX_COPY      8
+};
+
+/**
+ * struct homa_info - In/out argument passed to HOMAIOCINFO. Fields labeled
+ * as "in" must be set by the application; other fields are returned to the
+ * application from the kernel.
+ */
+struct homa_info {
+	/**
+	 * @rpc_info: (in) Address of memory region in which to store
+	 * information about individual RPCs.
+	 */
+	struct homa_rpc_info *rpc_info;
+
+	/**
+	 * @rpc_info_length: (in) Number of bytes of storage available at
+	 * rpc_info.
+	 */
+	size_t rpc_info_length;
+
+	/**
+	 * @bpool_avail_bytes: Number of bytes in the buffer pool for incoming
+	 * messages that is currently available for new messages.
+	 */
+	__u64 bpool_avail_bytes;
+
+	/** @port: Port number handled by this socket. */
+	__u32 port;
+
+	/**
+	 * @num_rpcs: Total number of active RPCs (both server and client) for
+	 * this socket. The number stored at @rpc_info will be less than this
+	 * if @rpc_info_length is too small.
+	 */
+	__u32 num_rpcs;
+
+	/**
+	 * @error_msg: Provides additional information about the last error
+	 * returned by a Homa-related kernel call such as sendmsg, recvmsg,
+	 * or ioctl. Not updated for some obvious return values such as EINTR
+	 * or EWOULDBLOCK.
+	 */
+#define HOMA_ERROR_MSG_SIZE 100
+	char error_msg[HOMA_ERROR_MSG_SIZE];
+};
+
+/* I/O control calls on Homa sockets.*/
+#define HOMAIOCINFO  _IOWR('h', 1, struct homa_info)
+
+#endif /* _UAPI_LINUX_HOMA_H */
diff --git a/net/Kconfig b/net/Kconfig
index d5865cf19799..92972ff2a78d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -250,6 +250,7 @@ source "net/bridge/netfilter/Kconfig"
 endif # if NETFILTER
 
 source "net/sctp/Kconfig"
+source "net/homa/Kconfig"
 source "net/rds/Kconfig"
 source "net/tipc/Kconfig"
 source "net/atm/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index aac960c41db6..71f740e0dc34 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -43,6 +43,7 @@ ifneq ($(CONFIG_VLAN_8021Q),)
 obj-y				+= 8021q/
 endif
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_HOMA)		+= homa/
 obj-$(CONFIG_RDS)		+= rds/
 obj-$(CONFIG_WIRELESS)		+= wireless/
 obj-$(CONFIG_MAC80211)		+= mac80211/
-- 
2.43.0


