Return-Path: <netdev+bounces-178466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37598A771A2
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4241F188E255
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E390521E094;
	Mon, 31 Mar 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="WxbZzzC6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056B21E08B
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465589; cv=none; b=rolbuRRnEO8juiFEoLI81MytUugCE3/H8Y4qy28YcnU80aOWepgWH10rPacbteHBcnPeCVJux/xVQNeNIPXqp8s/eVsD6v+aB9dIdd+pFUrszzYvOWpin4uMkKBooDR1JqhY2hN2MUtJmRf6ZAYX8FE3xWipdczJT4djlKJYrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465589; c=relaxed/simple;
	bh=M2ghivTakc7EK5DVk5kAi6aMR/EZ/GbfyP5zhTjQ5B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJDc5EtVLS3qOaCSeTnk27Fx8S94urzwV9pEJaidIxOYoRn5a1PTWjxfNau5cHYIPgKHwHs/Q3vdgL9Ffxy03sy7ev9i7zSZCnreElPTpGr9KhFIZ+fuuIAM1FVZECrk+YTf8C6oFNmLg5RlLjKT+jiOwdtF+cYVacoYLUotk8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=WxbZzzC6; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gdJDM5Osc4esfy0FB4AiBOAXe+BY5psuBqafpgcHYkI=; t=1743465587; x=1744329587; 
	b=WxbZzzC6d2lv+pri8SrzyjpE8f7EjGFi+sdNvInIWTdOEo6uGXk4ipa2bti271ShCoXk5bRv+hh
	vhS5HNtr4sQD9+RtwXX44a2HgWalFF0jRg65LoUf0nHoyz7MTaroJUhnEIgNl1X7PpT73il/D8GxL
	4Fw7O6+Ffr4QCuWI7/iic9ZcFKcfUPsrt+tCvFq7d/qzDFBxQW7wqvWmASVbxBOFiNkqq/tmaPm/c
	SVSZwiNGmUfCmvuqw5wnvS2GvK7T1sDLVwtFkZMW0uoJVaQLyh/MhN/DS1iG19bdLkMtdQfPXJiY6
	YdO4aFQCeBknuHLIN+44JXsgwmApLfKskqzQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:55223 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tzOqJ-000219-Tu; Mon, 31 Mar 2025 16:47:01 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v7 03/14] net: homa: create shared Homa header files
Date: Mon, 31 Mar 2025 16:45:36 -0700
Message-ID: <20250331234548.62070-4-ouster@cs.stanford.edu>
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
X-Scan-Signature: ab7cdc80bd51477082ebcdc005d6f603

homa_impl.h defines "struct homa", which contains overall information
about the Homa transport, plus various odds and ends that are used
throughout the Homa implementation.

homa_stub.h is a temporary header file that provides stubs for
facilities that have omitted for this first patch series. This file
will go away once Home is fully upstreamed.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v7:
* Make Homa a per-net subsystem
* Track tx buffer memory usage
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Remove "lock_slow" functions, which don't add functionality in this
  patch series
* Rename homa_rpc_free to homa_rpc_end
* Add homa_make_header_avl function
* Use u64 and __u64 properly
---
 net/homa/homa_impl.h | 624 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_stub.h |  91 +++++++
 2 files changed, 715 insertions(+)
 create mode 100644 net/homa/homa_impl.h
 create mode 100644 net/homa/homa_stub.h

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
new file mode 100644
index 000000000000..d3a2adec0a45
--- /dev/null
+++ b/net/homa/homa_impl.h
@@ -0,0 +1,624 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file contains definitions that are shared across the files
+ * that implement Homa for Linux.
+ */
+
+#ifndef _HOMA_IMPL_H
+#define _HOMA_IMPL_H
+
+#include <linux/bug.h>
+
+#include <linux/audit.h>
+#include <linux/icmp.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/proc_fs.h>
+#include <linux/sched/clock.h>
+#include <linux/sched/signal.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/vmalloc.h>
+#include <net/icmp.h>
+#include <net/ip.h>
+#include <net/netns/generic.h>
+#include <net/protocol.h>
+#include <net/inet_common.h>
+#include <net/gro.h>
+#include <net/rps.h>
+
+#include <linux/homa.h>
+#include "homa_wire.h"
+
+/* Forward declarations. */
+struct homa;
+struct homa_peer;
+struct homa_rpc;
+struct homa_sock;
+
+#define sizeof32(type) ((int)(sizeof(type)))
+
+/**
+ * union sockaddr_in_union - Holds either an IPv4 or IPv6 address (smaller
+ * and easier to use than sockaddr_storage).
+ */
+union sockaddr_in_union {
+	/** @sa: Used to access as a generic sockaddr. */
+	struct sockaddr sa;
+
+	/** @in4: Used to access as IPv4 socket. */
+	struct sockaddr_in in4;
+
+	/** @in6: Used to access as IPv6 socket.  */
+	struct sockaddr_in6 in6;
+};
+
+/**
+ * struct homa - Stores overall information about an implementation of
+ * the Homa transport. One of these objects exists for each network namespace.
+ */
+struct homa {
+	/**
+	 * @next_outgoing_id: Id to use for next outgoing RPC request.
+	 * This is always even: it's used only to generate client-side ids.
+	 * Accessed without locks. Note: RPC ids are unique within a
+	 * single client machine.
+	 */
+	atomic64_t next_outgoing_id;
+
+	/**
+	 * @link_idle_time: The time, measured by sched_clock, at which we
+	 * estimate that all of the packets we have passed to Linux for
+	 * transmission will have been transmitted. May be in the past.
+	 * This estimate assumes that only Homa is transmitting data, so
+	 * it could be a severe underestimate if there is competing traffic
+	 * from, say, TCP. Access only with atomic ops.
+	 */
+	atomic64_t link_idle_time ____cacheline_aligned_in_smp;
+
+	/**
+	 * @pacer_mutex: Ensures that only one instance of homa_pacer_xmit
+	 * runs at a time. Only used in "try" mode: never block on this.
+	 */
+	spinlock_t pacer_mutex ____cacheline_aligned_in_smp;
+
+	/**
+	 * @pacer_fifo_fraction: The fraction of time (in thousandths) when
+	 * the pacer should transmit next from the oldest message, rather
+	 * than the highest-priority message. Set externally via sysctl.
+	 */
+	int pacer_fifo_fraction;
+
+	/**
+	 * @pacer_fifo_count: When this becomes <= zero, it's time for the
+	 * pacer to allow the oldest RPC to transmit.
+	 */
+	int pacer_fifo_count;
+
+	/**
+	 * @pacer_wake_time: time (in sched_clock units) when the pacer last
+	 * woke up (if the pacer is running) or 0 if the pacer is sleeping.
+	 */
+	u64 pacer_wake_time;
+
+	/**
+	 * @throttle_lock: Used to synchronize access to @throttled_rpcs. To
+	 * insert or remove an RPC from throttled_rpcs, must first acquire
+	 * the RPC's socket lock, then this lock.
+	 */
+	spinlock_t throttle_lock;
+
+	/**
+	 * @throttled_rpcs: Contains all homa_rpcs that have bytes ready
+	 * for transmission, but which couldn't be sent without exceeding
+	 * the queue limits for transmission.
+	 */
+	struct list_head throttled_rpcs;
+
+	/**
+	 * @throttle_add: The time (in sched_clock() units) when the most
+	 * recent RPC was added to @throttled_rpcs.
+	 */
+	u64 throttle_add;
+
+	/**
+	 * @throttle_min_bytes: If a packet has fewer bytes than this, then it
+	 * bypasses the throttle mechanism and is transmitted immediately.
+	 * We have this limit because for very small packets we can't keep
+	 * up with the NIC (we're limited by CPU overheads); there's no
+	 * need for throttling and going through the throttle mechanism
+	 * adds overhead, which slows things down. At least, that's the
+	 * hypothesis (needs to be verified experimentally!). Set externally
+	 * via sysctl.
+	 */
+	int throttle_min_bytes;
+
+	/**
+	 * @prev_default_port: The most recent port number assigned from
+	 * the range of default ports.
+	 */
+	__u16 prev_default_port ____cacheline_aligned_in_smp;
+
+	/**
+	 * @port_map: Information about all open sockets. Dynamically
+	 * allocated; must be kfreed.
+	 */
+	struct homa_socktab *port_map ____cacheline_aligned_in_smp;
+
+	/**
+	 * @peers: Info about all the other hosts we have communicated with.
+	 * Dynamically allocated; must be kfreed.
+	 */
+	struct homa_peertab *peers;
+
+	/** @max_numa: Highest NUMA node id in use by any core. */
+	int max_numa;
+
+	/**
+	 * @link_mbps: The raw bandwidth of the network uplink, in
+	 * units of 1e06 bits per second.  Set externally via sysctl.
+	 */
+	int link_mbps;
+
+	/**
+	 * @resend_ticks: When an RPC's @silent_ticks reaches this value,
+	 * start sending RESEND requests.
+	 */
+	int resend_ticks;
+
+	/**
+	 * @resend_interval: minimum number of homa timer ticks between
+	 * RESENDs for the same RPC.
+	 */
+	int resend_interval;
+
+	/**
+	 * @timeout_ticks: abort an RPC if its silent_ticks reaches this value.
+	 */
+	int timeout_ticks;
+
+	/**
+	 * @timeout_resends: Assume that a server is dead if it has not
+	 * responded after this many RESENDs have been sent to it.
+	 */
+	int timeout_resends;
+
+	/**
+	 * @request_ack_ticks: How many timer ticks we'll wait for the
+	 * client to ack an RPC before explicitly requesting an ack.
+	 * Set externally via sysctl.
+	 */
+	int request_ack_ticks;
+
+	/**
+	 * @reap_limit: Maximum number of packet buffers to free in a
+	 * single call to home_rpc_reap.
+	 */
+	int reap_limit;
+
+	/**
+	 * @dead_buffs_limit: If the number of packet buffers in dead but
+	 * not yet reaped RPCs is less than this number, then Homa reaps
+	 * RPCs in a way that minimizes impact on performance but may permit
+	 * dead RPCs to accumulate. If the number of dead packet buffers
+	 * exceeds this value, then Homa switches to a more aggressive approach
+	 * to reaping RPCs. Set externally via sysctl.
+	 */
+	int dead_buffs_limit;
+
+	/**
+	 * @max_dead_buffs: The largest aggregate number of packet buffers
+	 * in dead (but not yet reaped) RPCs that has existed so far in a
+	 * single socket.  Readable via sysctl, and may be reset via sysctl
+	 * to begin recalculating.
+	 */
+	int max_dead_buffs;
+
+	/**
+	 * @pacer_kthread: Kernel thread that transmits packets from
+	 * throttled_rpcs in a way that limits queue buildup in the
+	 * NIC.
+	 */
+	struct task_struct *pacer_kthread;
+
+	/**
+	 * @pacer_exit: true means that the pacer thread should exit as
+	 * soon as possible.
+	 */
+	bool pacer_exit;
+
+	/**
+	 * @max_nic_queue_ns: Limits the NIC queue length: we won't queue
+	 * up a packet for transmission if link_idle_time is this many
+	 * nanoseconds in the future (or more). Set externally via sysctl.
+	 */
+	int max_nic_queue_ns;
+
+	/**
+	 * @ns_per_mbyte: the number of ns that it takes to transmit
+	 * 10**6 bytes on our uplink. This is actually a slight overestimate
+	 * of the value, to ensure that we don't underestimate NIC queue
+	 * length and queue too many packets.
+	 */
+	u32 ns_per_mbyte;
+
+	/**
+	 * @max_gso_size: Maximum number of bytes that will be included
+	 * in a single output packet that Homa passes to Linux. Can be set
+	 * externally via sysctl to lower the limit already enforced by Linux.
+	 */
+	int max_gso_size;
+
+	/**
+	 * @gso_force_software: A non-zero value will cause Homa to perform
+	 * segmentation in software using GSO; zero means ask the NIC to
+	 * perform TSO. Set externally via sysctl.
+	 */
+	int gso_force_software;
+
+	/**
+	 * @wmem_max: Limit on the value of sk_sndbuf for any socket. Set
+	 * externally via sysctl.
+	 */
+	int wmem_max;
+
+	/**
+	 * @timer_ticks: number of times that homa_timer has been invoked
+	 * (may wraparound, which is safe).
+	 */
+	u32 timer_ticks;
+
+	/**
+	 * @flags: a collection of bits that can be set using sysctl
+	 * to trigger various behaviors.
+	 */
+	int flags;
+
+	/**
+	 * @bpage_lease_usecs: how long a core can own a bpage (microseconds)
+	 * before its ownership can be revoked to reclaim the page.
+	 */
+	int bpage_lease_usecs;
+
+	/**
+	 * @next_id: Set via sysctl; causes next_outgoing_id to be set to
+	 * this value; always reads as zero. Typically used while debugging to
+	 * ensure that different nodes use different ranges of ids.
+	 */
+	int next_id;
+
+	/**
+	 * @timer_kthread: Thread that runs timer code to detect lost
+	 * packets and crashed peers.
+	 */
+	struct task_struct *timer_kthread;
+
+	/** @hrtimer: Used to wakeup @timer_kthread at regular intervals. */
+	struct hrtimer hrtimer;
+
+	/**
+	 * @destroyed: True means that this structure is being destroyed
+	 * so everyone should clean up.
+	 */
+	bool destroyed;
+
+};
+
+/**
+ * struct homa_skb_info - Additional information needed by Homa for each
+ * outbound DATA packet. Space is allocated for this at the very end of the
+ * linear part of the skb.
+ */
+struct homa_skb_info {
+	/**
+	 * @next_skb: used to link together all of the skb's for a Homa
+	 * message (in order of offset).
+	 */
+	struct sk_buff *next_skb;
+
+	/**
+	 * @wire_bytes: total number of bytes of network bandwidth that
+	 * will be consumed by this packet. This includes everything,
+	 * including additional headers added by GSO, IP header, Ethernet
+	 * header, CRC, preamble, and inter-packet gap.
+	 */
+	int wire_bytes;
+
+	/**
+	 * @data_bytes: total bytes of message data across all of the
+	 * segments in this packet.
+	 */
+	int data_bytes;
+
+	/** @seg_length: maximum number of data bytes in each GSO segment. */
+	int seg_length;
+
+	/**
+	 * @offset: offset within the message of the first byte of data in
+	 * this packet.
+	 */
+	int offset;
+};
+
+/**
+ * homa_get_skb_info() - Return the address of Homa's private information
+ * for an sk_buff.
+ * @skb:     Socket buffer whose info is needed.
+ * Return: address of Homa's private information for @skb.
+ */
+static inline struct homa_skb_info *homa_get_skb_info(struct sk_buff *skb)
+{
+	return (struct homa_skb_info *)(skb_end_pointer(skb)) - 1;
+}
+
+/**
+ * homa_set_doff() - Fills in the doff TCP header field for a Homa packet.
+ * @h:     Packet header whose doff field is to be set.
+ * @size:  Size of the "header", bytes (must be a multiple of 4). This
+ *         information is used only for TSO; it's the number of bytes
+ *         that should be replicated in each segment. The bytes after
+ *         this will be distributed among segments.
+ */
+static inline void homa_set_doff(struct homa_data_hdr *h, int size)
+{
+	/* Drop the 2 low-order bits from size and set the 4 high-order
+	 * bits of doff from what's left.
+	 */
+	h->common.doff = size << 2;
+}
+
+/**
+ * homa_throttle_lock() - Acquire the throttle lock.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+static inline void homa_throttle_lock(struct homa *homa)
+	__acquires(&homa->throttle_lock)
+{
+	spin_lock_bh(&homa->throttle_lock);
+}
+
+/**
+ * homa_throttle_unlock() - Release the throttle lock.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+static inline void homa_throttle_unlock(struct homa *homa)
+	__releases(&homa->throttle_lock)
+{
+	spin_unlock_bh(&homa->throttle_lock);
+}
+
+/** skb_is_ipv6() - Return true if the packet is encapsulated with IPv6,
+ *  false otherwise (presumably it's IPv4).
+ */
+static inline bool skb_is_ipv6(const struct sk_buff *skb)
+{
+	return ipv6_hdr(skb)->version == 6;
+}
+
+/**
+ * ipv6_to_ipv4() - Given an IPv6 address produced by ipv4_to_ipv6, return
+ * the original IPv4 address (in network byte order).
+ * @ip6:  IPv6 address; assumed to be a mapped IPv4 address.
+ * Return: IPv4 address stored in @ip6.
+ */
+static inline __be32 ipv6_to_ipv4(const struct in6_addr ip6)
+{
+	return ip6.in6_u.u6_addr32[3];
+}
+
+/**
+ * canonical_ipv6_addr() - Convert a socket address to the "standard"
+ * form used in Homa, which is always an IPv6 address; if the original address
+ * was IPv4, convert it to an IPv4-mapped IPv6 address.
+ * @addr:   Address to canonicalize (if NULL, "any" is returned).
+ * Return: IPv6 address corresponding to @addr.
+ */
+static inline struct in6_addr canonical_ipv6_addr(const union sockaddr_in_union
+						  *addr)
+{
+	struct in6_addr mapped;
+
+	if (addr) {
+		if (addr->sa.sa_family == AF_INET6)
+			return addr->in6.sin6_addr;
+		ipv6_addr_set_v4mapped(addr->in4.sin_addr.s_addr, &mapped);
+		return mapped;
+	}
+	return in6addr_any;
+}
+
+/**
+ * skb_canonical_ipv6_saddr() - Given a packet buffer, return its source
+ * address in the "standard" form used in Homa, which is always an IPv6
+ * address; if the original address was IPv4, convert it to an IPv4-mapped
+ * IPv6 address.
+ * @skb:   The source address will be extracted from this packet buffer.
+ * Return: IPv6 address for @skb's source machine.
+ */
+static inline struct in6_addr skb_canonical_ipv6_saddr(struct sk_buff *skb)
+{
+	struct in6_addr mapped;
+
+	if (skb_is_ipv6(skb))
+		return ipv6_hdr(skb)->saddr;
+	ipv6_addr_set_v4mapped(ip_hdr(skb)->saddr, &mapped);
+	return mapped;
+}
+
+static inline bool is_homa_pkt(struct sk_buff *skb)
+{
+	struct iphdr *iph = ip_hdr(skb);
+
+	return (iph->protocol == IPPROTO_HOMA);
+}
+
+/**
+ * homa_make_header_avl() - Invokes pskb_may_pull to make sure that all the
+ * Homa header information for a packet is in the linear part of the skb
+ * where it can be addressed using skb_transport_header.
+ * @skb:     Packet for which header is needed.
+ * Return:   The result of pskb_may_pull (true for success)
+ */
+static inline bool homa_make_header_avl(struct sk_buff *skb)
+{
+	int pull_length;
+
+	pull_length = skb_transport_header(skb) - skb->data + HOMA_MAX_HEADER;
+	if (pull_length > skb->len)
+		pull_length = skb->len;
+	return pskb_may_pull(skb, pull_length);
+}
+
+#define UNIT_LOG(...)
+#define UNIT_HOOK(...)
+
+extern unsigned int homa_net_id;
+
+void     homa_abort_rpcs(struct homa *homa, const struct in6_addr *addr,
+			 int port, int error);
+void     homa_abort_sock_rpcs(struct homa_sock *hsk, int error);
+void     homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+		      struct homa_rpc *rpc);
+void     homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb);
+void     homa_add_to_throttled(struct homa_rpc *rpc);
+int      homa_backlog_rcv(struct sock *sk, struct sk_buff *skb);
+int      homa_bind(struct socket *sk, struct sockaddr *addr,
+		   int addr_len);
+int      homa_check_nic_queue(struct homa *homa, struct sk_buff *skb,
+			      bool force);
+void     homa_close(struct sock *sock, long timeout);
+int      homa_copy_to_user(struct homa_rpc *rpc);
+void     homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
+void     homa_destroy(struct homa *homa);
+int      homa_disconnect(struct sock *sk, int flags);
+void     homa_dispatch_pkts(struct sk_buff *skb, struct homa *homa);
+int      homa_err_handler_v4(struct sk_buff *skb, u32 info);
+int      homa_err_handler_v6(struct sk_buff *skb,
+			     struct inet6_skb_parm *opt, u8 type,  u8 code,
+			     int offset, __be32 info);
+int      homa_fill_data_interleaved(struct homa_rpc *rpc,
+				    struct sk_buff *skb, struct iov_iter *iter);
+struct homa_gap *homa_gap_new(struct list_head *next, int start, int end);
+void     homa_gap_retry(struct homa_rpc *rpc);
+int      homa_get_port(struct sock *sk, unsigned short snum);
+int      homa_getsockopt(struct sock *sk, int level, int optname,
+			 char __user *optval, int __user *optlen);
+int      homa_hash(struct sock *sk);
+enum hrtimer_restart homa_hrtimer(struct hrtimer *timer);
+int      homa_init(struct homa *homa);
+int      homa_ioctl(struct sock *sk, int cmd, int *karg);
+int      homa_load(void);
+int      homa_message_out_fill(struct homa_rpc *rpc,
+			       struct iov_iter *iter, int xmit);
+void     homa_message_out_init(struct homa_rpc *rpc, int length);
+void     homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
+			   struct homa_rpc *rpc);
+struct sk_buff *homa_new_data_packet(struct homa_rpc *rpc,
+				     struct iov_iter *iter, int offset,
+				     int length, int max_seg_data);
+int      homa_net_init(struct net *net);
+void     homa_net_exit(struct net *net);
+int      homa_pacer_main(void *transport);
+void     homa_pacer_stop(struct homa *homa);
+bool     homa_pacer_xmit(struct homa *homa);
+__poll_t homa_poll(struct file *file, struct socket *sock,
+		   struct poll_table_struct *wait);
+int      homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+		      int flags, int *addr_len);
+void     homa_remove_from_throttled(struct homa_rpc *rpc);
+void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
+			 struct homa_sock *hsk);
+void     homa_rpc_abort(struct homa_rpc *crpc, int error);
+void     homa_rpc_acked(struct homa_sock *hsk,
+			const struct in6_addr *saddr, struct homa_ack *ack);
+void     homa_rpc_end(struct homa_rpc *rpc);
+void     homa_rpc_handoff(struct homa_rpc *rpc);
+int      homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+int      homa_setsockopt(struct sock *sk, int level, int optname,
+			 sockptr_t optval, unsigned int optlen);
+int      homa_shutdown(struct socket *sock, int how);
+int      homa_softirq(struct sk_buff *skb);
+void     homa_spin(int ns);
+void     homa_timer(struct homa *homa);
+int      homa_timer_main(void *transport);
+void     homa_unhash(struct sock *sk);
+void     homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
+void     homa_unload(void);
+int      homa_wait_private(struct homa_rpc *rpc, int nonblocking);
+struct homa_rpc
+	*homa_wait_shared(struct homa_sock *hsk, int nonblocking);
+int      homa_xmit_control(enum homa_packet_type type, void *contents,
+			   size_t length, struct homa_rpc *rpc);
+int      __homa_xmit_control(void *contents, size_t length,
+			     struct homa_peer *peer, struct homa_sock *hsk);
+void     homa_xmit_data(struct homa_rpc *rpc, bool force);
+void     homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk);
+
+int      homa_message_in_init(struct homa_rpc *rpc, int unsched);
+void     homa_resend_data(struct homa_rpc *rpc, int start, int end);
+void     __homa_xmit_data(struct sk_buff *skb, struct homa_rpc *rpc);
+
+/**
+ * homa_check_pacer() - This method is invoked at various places in Homa to
+ * see if the pacer needs to transmit more packets and, if so, transmit
+ * them. It's needed because the pacer thread may get descheduled by
+ * Linux, result in output stalls.
+ * @homa:    Overall data about the Homa protocol implementation. No locks
+ *           should be held when this function is invoked.
+ * @softirq: Nonzero means this code is running at softirq (bh) level;
+ *           zero means it's running in process context.
+ */
+static inline void homa_check_pacer(struct homa *homa, int softirq)
+{
+	if (list_empty(&homa->throttled_rpcs))
+		return;
+
+	/* The ">> 1" in the line below gives homa_pacer_main the first chance
+	 * to queue new packets; if the NIC queue becomes more than half
+	 * empty, then we will help out here.
+	 */
+	if ((sched_clock() + (homa->max_nic_queue_ns >> 1)) <
+			atomic64_read(&homa->link_idle_time))
+		return;
+	homa_pacer_xmit(homa);
+}
+
+/**
+ * homa_from_net() - Return the struct homa associated with a particular
+ * struct net.
+ * @net:     Get the struct homa for this net namespace.
+ * Return:   see above
+ */
+static inline struct homa *homa_from_net(struct net *net)
+{
+	return (struct homa *) net_generic(net, homa_net_id);
+}
+
+/**
+ * homa_from_sock() - Return the struct homa associated with a particular
+ * struct sock.
+ * @sock:    Get the struct homa for this socket.
+ * Return:   see above
+ */
+static inline struct homa *homa_from_sock(struct sock *sock)
+{
+	return (struct homa *) net_generic(sock_net(sock), homa_net_id);
+}
+
+/**
+ * homa_from_skb() - Return the struct homa associated with a particular
+ * sk_buff.
+ * @skb:     Get the struct homa for this packet buffer.
+ * Return:   see above
+ */
+static inline struct homa *homa_from_skb(struct sk_buff *skb)
+{
+	return (struct homa *) net_generic(dev_net(skb->dev), homa_net_id);
+}
+
+extern struct completion homa_pacer_kthread_done;
+#endif /* _HOMA_IMPL_H */
diff --git a/net/homa/homa_stub.h b/net/homa/homa_stub.h
new file mode 100644
index 000000000000..3bfe7b8b5b42
--- /dev/null
+++ b/net/homa/homa_stub.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file contains stripped-down replacements that have been
+ * temporarily removed from Homa during the Linux upstreaming
+ * process. By the time upstreaming is complete this file will
+ * have gone away.
+ */
+
+#ifndef _HOMA_STUB_H
+#define _HOMA_STUB_H
+
+#include "homa_impl.h"
+
+static inline int homa_skb_init(struct homa *homa)
+{
+	return 0;
+}
+
+static inline void homa_skb_cleanup(struct homa *homa)
+{}
+
+static inline void homa_skb_release_pages(struct homa *homa)
+{}
+
+static inline int homa_skb_append_from_iter(struct homa *homa,
+					    struct sk_buff *skb,
+					    struct iov_iter *iter, int length)
+{
+	char *dst = skb_put(skb, length);
+
+	if (copy_from_iter(dst, length, iter) != length)
+		return -EFAULT;
+	return 0;
+}
+
+static inline int homa_skb_append_to_frag(struct homa *homa,
+					  struct sk_buff *skb, void *buf,
+					  int length)
+{
+	char *dst = skb_put(skb, length);
+
+	memcpy(dst, buf, length);
+	return 0;
+}
+
+static inline int  homa_skb_append_from_skb(struct homa *homa,
+					    struct sk_buff *dst_skb,
+					    struct sk_buff *src_skb,
+					    int offset, int length)
+{
+	return homa_skb_append_to_frag(homa, dst_skb,
+			skb_transport_header(src_skb) + offset, length);
+}
+
+static inline void homa_skb_free_tx(struct homa *homa, struct sk_buff *skb)
+{
+	kfree_skb(skb);
+}
+
+static inline void homa_skb_free_many_tx(struct homa *homa,
+					 struct sk_buff **skbs, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		kfree_skb(skbs[i]);
+}
+
+static inline void homa_skb_get(struct sk_buff *skb, void *dest, int offset,
+				int length)
+{
+	memcpy(dest, skb_transport_header(skb) + offset, length);
+}
+
+static inline struct sk_buff *homa_skb_new_tx(int length)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(HOMA_SKB_EXTRA + HOMA_IPV6_HEADER_LENGTH +
+			sizeof(struct homa_skb_info) + length, GFP_ATOMIC);
+	if (likely(skb)) {
+		skb_reserve(skb, HOMA_SKB_EXTRA + HOMA_IPV6_HEADER_LENGTH);
+		skb_reset_transport_header(skb);
+	}
+	return skb;
+}
+
+static inline void homa_skb_stash_pages(struct homa *homa, int length)
+{}
+
+#endif /* _HOMA_STUB_H */
-- 
2.34.1


