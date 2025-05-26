Return-Path: <netdev+bounces-193316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA3AC3897
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB591892129
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F012D1A7262;
	Mon, 26 May 2025 04:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="BeKcnsc9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9C19DF99
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748233727; cv=none; b=lo/rEp1rtHtKsjLkkc9niO8u9ECRGKUij9Uu+yA7R1Wh8rdAgJCbCfBvZ9uSS7PQzxSQDSvAz77jXzQH/SDorfmhxSNl97jFXwScG8BH41r8pGw2lsZ0no6YMyVPiyyhNLQywDk3yoYauhlBmgrc5Kf+P2cI+GOtihIgVCPDRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748233727; c=relaxed/simple;
	bh=9efHdjr/Le68V7B3nAEf+gp399ROEGbgtehXMHQQ1lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMUnuG6mjkJdc5Y2SvJX0vLGuyVI/NQ0Qv4W5lNZpXa9XRbiceDOWOJv9/NNxx5UqxLnIPftaC+jNxEpw9T/JsJefVozgsiityT6D0BD5s6oMF/8ezpgZJXI0ptzW+l1pSj18vgQ0QiI8FtQTF+3Y+J3CjbgTYR0SgHryGUKaxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=BeKcnsc9; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AOYcdxOpZJJUwtu8510UA6C62qyRomiCnxjYehdMGoQ=; t=1748233725; x=1749097725; 
	b=BeKcnsc9CB0eOXtIp2WhZpsIg9AeWK8GvoQUTDENI35OWBYxGqU6XK7i3Sau7w7N46VIHReLPK4
	AxbVhp35iMS1kkcSpyiKO9Ch1uol4qYHfveAZgRnXp8arrRDZoX1AXdsG6Q+nzqSdsiwFd9YRJhNk
	g9X1KQXK3x60Ua3tkGvR8SpV11AJysubxX7lXbknl3H5ycKOQMxrpuHz/cpO3VxD6XeuPSRjpyNHi
	kH02upOGz8GQa5Te0LzJl0zkwzzNeKMuOOwUixO3xVXCLZv3y4SZw/oyCeFUtbC80zAWgW2nNl7Os
	9Z4yPDbwjwNRAEfwI0pbVBecpnSXMjX+Koog==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:54961 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uJPS7-0006Qy-8u; Sun, 25 May 2025 21:28:45 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v9 03/15] net: homa: create shared Homa header files
Date: Sun, 25 May 2025 21:28:05 -0700
Message-ID: <20250526042819.2526-4-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250526042819.2526-1-ouster@cs.stanford.edu>
References: <20250526042819.2526-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: a15d19c8e206a5c7e532936f7d053422

homa_impl.h defines "struct homa", which contains overall information
about the Homa transport, plus various odds and ends that are used
throughout the Homa implementation.

homa_stub.h is a temporary header file that provides stubs for
facilities that have omitted for this first patch series. This file
will go away once Home is fully upstreamed.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Move information from sync.txt into comments in homa_impl.h
* Add limits on number of active peer structs
* Introduce homa_net objects; there is now a single global struct homa
  shared by all network namespaces, with one homa_net per network namespace
  with netns-specific information.
* Introduce homa_clock as an abstraction layer for the fine-grain clock.
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)
* Eliminate sizeof32 definition

Changes for v8:
* Pull out pacer-related fields into separate struct homa_pacer in homa_pacer.h

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
 net/homa/homa_impl.h | 603 +++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_stub.h |  91 +++++++
 2 files changed, 694 insertions(+)
 create mode 100644 net/homa/homa_impl.h
 create mode 100644 net/homa/homa_stub.h

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
new file mode 100644
index 000000000000..7c634c24ffaf
--- /dev/null
+++ b/net/homa/homa_impl.h
@@ -0,0 +1,603 @@
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
+#ifdef __CHECKER__
+#define __context__(x, y, z) __attribute__((context(x, y, z)))
+#else
+#define __context__(...)
+#endif /* __CHECKER__ */
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
+ * struct homa - Stores overall information about the Homa transport, which
+ * is shared across all Homa sockets and all network namespaces.
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
+	 * @pacer:  Information related to the pacer; managed by homa_pacer.c.
+	 */
+	struct homa_pacer *pacer;
+
+	/**
+	 * @peertab: Info about all the other hosts we have communicated with;
+	 * includes peers from all network namespaces.
+	 */
+	struct homa_peertab *peertab;
+
+	/**
+	 * @socktab: Information about all open sockets. Dynamically
+	 * allocated; must be kfreed.
+	 */
+	struct homa_socktab *socktab;
+
+	/** @max_numa: Highest NUMA node id in use by any core. */
+	int max_numa;
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
+	 * @bpage_lease_cycles: same as bpage_lease_usecs except in
+	 * homa_clock() units.
+	 */
+	int bpage_lease_cycles;
+
+	/**
+	 * @next_id: Set via sysctl; causes next_outgoing_id to be set to
+	 * this value; always reads as zero. Typically used while debugging to
+	 * ensure that different nodes use different ranges of ids.
+	 */
+	int next_id;
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
+ * struct homa_net - Contains Homa information that is specific to a
+ * particular network namespace.
+ */
+struct homa_net {
+	/** @net: Network namespace corresponding to this structure. */
+	struct net *net;
+
+	/** @homa: Global Homa information. */
+	struct homa *homa;
+
+	/**
+	 * @prev_default_port: The most recent port number assigned from
+	 * the range of default ports.
+	 */
+	__u16 prev_default_port;
+
+	/**
+	 * @num_peers: The total number of struct homa_peers that exist
+	 * for this namespace. Managed by homa_peer.c under the peertab lock.
+	 */
+	int num_peers;
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
+/**
+ * is_homa_pkt() - Return true if @skb is a Homa packet, false otherwise.
+ * @skb:    Packet buffer to check.
+ * Return:  see above.
+ */
+static inline bool is_homa_pkt(struct sk_buff *skb)
+{
+	struct iphdr *iph = ip_hdr(skb);
+
+	return iph->protocol == IPPROTO_HOMA;
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
+/**
+ * homa_net_from_net() - Return the struct homa_net associated with a particular
+ * struct net.
+ * @net:     Get the Homa data for this net namespace.
+ * Return:   see above.
+ */
+static inline struct homa_net *homa_net_from_net(struct net *net)
+{
+	return (struct homa_net *)net_generic(net, homa_net_id);
+}
+
+/**
+ * homa_from_skb() - Return the struct homa associated with a particular
+ * sk_buff.
+ * @skb:     Get the struct homa for this packet buffer.
+ * Return:   see above.
+ */
+static inline struct homa *homa_from_skb(struct sk_buff *skb)
+{
+	struct homa_net *hnet;
+
+	hnet = net_generic(dev_net(skb->dev), homa_net_id);
+	return hnet->homa;
+}
+
+/**
+ * homa_net_from_skb() - Return the struct homa_net associated with a particular
+ * sk_buff.
+ * @skb:     Get the struct homa for this packet buffer.
+ * Return:   see above.
+ */
+static inline struct homa_net *homa_net_from_skb(struct sk_buff *skb)
+{
+	struct homa_net *hnet;
+
+	hnet = net_generic(dev_net(skb->dev), homa_net_id);
+	return hnet;
+}
+
+/**
+ * homa_clock() - Return a fine-grain clock value that is monotonic and
+ * consistent across cores.
+ * Return: see above.
+ */
+static inline u64 homa_clock(void)
+{
+	/* As of May 2025 there does not appear to be a portable API that
+	 * meets Homa's needs:
+	 * - The Intel X86 TSC works well but is not portable.
+	 * - sched_clock() does not guarantee monotonicity or consistency.
+	 * - ktime_get_mono_fast_ns and ktime_get_raw_fast_ns are very slow
+	 *   (27 ns to read, vs 8 ns for TSC)
+	 * Thus we use a hybrid approach that uses TSC (via get_cycles) where
+	 * available (which should be just about everywhere Homa runs).
+	 */
+#ifdef CONFIG_X86_TSC
+	return get_cycles();
+#else
+	return ktime_get_mono_fast_ns();
+#endif /* CONFIG_X86_TSC */
+}
+
+/**
+ * homa_clock_khz() - Return the frequency of the values returned by
+ * homa_clock, in units of KHz.
+ * Return: see above.
+ */
+static inline u64 homa_clock_khz(void)
+{
+#ifdef CONFIG_X86_TSC
+	return cpu_khz;
+#else
+	return 1000000;
+#endif /* CONFIG_X86_TSC */
+}
+
+/**
+ * homa_ns_to_cycles() - Convert from units of nanoseconds to units of
+ * homa_clock().
+ * @ns:      A time measurement in nanoseconds
+ * Return:   The time in homa_clock() units corresponding to @ns.
+ */
+static inline u64 homa_ns_to_cycles(u64 ns)
+{
+#ifdef CONFIG_X86_TSC
+	u64 tmp;
+
+	tmp = ns * cpu_khz;
+	do_div(tmp, 1000000);
+	return tmp;
+#else
+	return ns;
+#endif /* CONFIG_X86_TSC */
+}
+
+/**
+ * homa_usecs_to_cycles() - Convert from units of microseconds to units of
+ * homa_clock().
+ * @usecs:   A time measurement in microseconds
+ * Return:   The time in homa_clock() units corresponding to @usecs.
+ */
+static inline u64 homa_usecs_to_cycles(u64 usecs)
+{
+#ifdef CONFIG_X86_TSC
+	u64 tmp;
+
+	tmp = usecs * cpu_khz;
+	do_div(tmp, 1000);
+	return tmp;
+#else
+	return usecs * 1000;
+#endif /* CONFIG_X86_TSC */
+}
+
+/* Homa Locking Strategy:
+ *
+ * (Note: this documentation is referenced in several other places in the
+ * Homa code)
+ *
+ * In the Linux TCP/IP stack the primary locking mechanism is a sleep-lock
+ * per socket. However, per-socket locks aren't adequate for Homa, because
+ * sockets are "larger" in Homa. In TCP, a socket corresponds to a single
+ * connection between two peers; an application can have hundreds or
+ * thousands of sockets open at once, so per-socket locks leave lots of
+ * opportunities for concurrency. With Homa, a single socket can be used for
+ * communicating with any number of peers, so there will typically be just
+ * one socket per thread. As a result, a single Homa socket must support many
+ * concurrent RPCs efficiently, and a per-socket lock would create a bottleneck
+ * (Homa tried this approach initially).
+ *
+ * Thus, the primary locks used in Homa spinlocks at RPC granularity. This
+ * allows operations on different RPCs for the same socket to proceed
+ * concurrently. Homa also has socket locks (which are spinlocks different
+ * from the official socket sleep-locks) but these are used much less
+ * frequently than RPC locks.
+ *
+ * Lock Ordering:
+ *
+ * There are several other locks in Homa besides RPC locks, all of which
+ * are spinlocks. When multiple locks are held, they must be acquired in a
+ * consistent order in order to prevent deadlock. Here are the rules for Homa:
+ * 1. Except for RPC and socket locks, all locks should be considered
+ *    "leaf" locks: don't acquire other locks while holding them.
+ * 2. The lock order is:
+ *    * RPC lock
+ *    * Socket lock
+ *    * Other lock
+ * 3. It is not safe to wait on an RPC lock while holding any other lock.
+ * 4. It is safe to wait on a socket lock while holding an RPC lock, but
+ *    not while holding any other lock.
+ *
+ * It may seem surprising that RPC locks are acquired *before* socket locks,
+ * but this is essential for high performance. Homa has been designed so that
+ * many common operations (such as processing input packets) can be performed
+ * while holding only an RPC lock; this allows operations on different RPCs
+ * to proceed in parallel. Only a few operations, such as handing off an
+ * incoming message to a waiting thread, require the socket lock. If socket
+ * locks had to be acquired first, any operation that might eventually need
+ * the socket lock would have to acquire it before the RPC lock, which would
+ * severely restrict concurrency.
+ *
+ * Socket Shutdown:
+ *
+ * It is possible for socket shutdown to begin while operations are underway
+ * that hold RPC locks but not the socket lock. For example, a new RPC
+ * creation might be underway when a socket is shut down. The RPC creation
+ * will eventually acquire the socket lock and add the new RPC to those
+ * for the socket; it would be very bad if this were to happen after
+ * homa_sock_shutdown things is has deleted all RPCs for the socket.
+ * In general, any operation that acquires a socket lock must check
+ * hsk->shutdown after acquiring the lock and abort if hsk->shutdown is set.
+ *
+ * Spinlock Implications:
+ *
+ * Homa uses spinlocks exclusively; this is needed because locks typically
+ * need to be acquired at atomic level, such as in SoftIRQ code.
+ *
+ * Operations that can block, such as memory allocation and copying data
+ * to/from user space, are not permitted while holding spinlocks (spinlocks
+ * disable interrupts, so the holder must not block. This results in awkward
+ * code in several places to move restricted operations outside locked
+ * regions. Such code typically looks like this:
+ *   - Acquire a reference on an object such as an RPC, in order to prevent
+ *     the object from being deleted.
+ *   - Release the object's lock.
+ *   - Perform the restricted operation.
+ *   - Re-acquire the lock.
+ *   - Release the reference.
+ * It is possible that the object may have been modified by some other party
+ * while it was unlocked, so additional checks may be needed after reacquiring
+ * the lock. As one example, an RPC may have been terminated, in which case
+ * any operation in progress on that RPC should be aborted after reacquiring
+ * the lock.
+ *
+ * Lists of RPCs:
+ *
+ * There are a few places where Homa needs to process all of the RPCs
+ * associated with a socket, such as the timer. Such code must first lock
+ * the socket (to protect access to the link pointers) then lock
+ * individual RPCs on the list. However, this violates the rules for locking
+ * order. It isn't safe to unlock the socket before locking the individual RPCs,
+ * because RPCs could be deleted and their memory recycled between the unlock
+ * of the socket lock and the lock of the RPC; this could result in corruption.
+ * Homa uses two different approaches to handle this situation:
+ * 1. Use ``homa_protect_rpcs`` to prevent RPC reaping for a socket. RPCs can
+ *    still be terminated, but their memory won't go away until
+ *    homa_unprotect_rpcs is invoked. This allows the socket lock to be
+ *    released before acquiring RPC locks; after acquiring each RPC lock,
+ *    the RPC must be checked to see if it has been terminated; if so, skip it.
+ * 2. Use ``spin_trylock_bh`` to acquire the RPC lock while still holding the
+ *    socket lock. If this fails, then release the socket lock and retry
+ *    both the socket lock and the RPC lock. Of course, the state of both
+ *    socket and RPC could change before the locks are finally acquired.
+ */
+
+#endif /* _HOMA_IMPL_H */
diff --git a/net/homa/homa_stub.h b/net/homa/homa_stub.h
new file mode 100644
index 000000000000..aefe816db1c2
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
+static inline struct sk_buff *homa_skb_alloc_tx(int length)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(HOMA_SKB_EXTRA + sizeof(struct homa_skb_info) + length,
+			GFP_ATOMIC);
+	if (likely(skb)) {
+		skb_reserve(skb, HOMA_SKB_EXTRA);
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
2.43.0


