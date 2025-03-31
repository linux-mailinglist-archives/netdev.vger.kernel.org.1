Return-Path: <netdev+bounces-178464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A91A7719F
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63FC516ABA1
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7310D21CC5A;
	Mon, 31 Mar 2025 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="ArZ7/O7o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0F21CC57
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465584; cv=none; b=dqR2H0lPsH/tQm+OvZcc1fGqnC4cw812qg64wnytD/aDUbybbdud/IZlplv9A71kg8rdFBbrEx6xU1PIytGLF812hOIDnq5LPLK3YxAHOfc9rMivP6bGVFnCHnml8k/xXXpR3+wf5+yLDhiHw7Ndjw76BAGww4//lWnW+d9cBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465584; c=relaxed/simple;
	bh=Jx/E0GZiH9TALgjcxxkh4MZdIuOMnAr4TEI28UpjJ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0NkYJScEWaBW5iptbj4qVBMCMlgHhxXpzwF+xKp05ztD5X/TUkjUhJXs/+2bvW5gTaMoKxbCNus/YsnPgB0SzGqTshJ3034d8LZXLjIePYccFkWQM9waNjArIq1bZNiEgeupVyY9SoOn0oqQqSgvUmc79B2WRRlPA1q0rPZ1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=ArZ7/O7o; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r6eeHYSMGwCxyEzUDbzFJxQ1LmI1Iqc+HHNCl8ierZQ=; t=1743465582; x=1744329582; 
	b=ArZ7/O7odesf6+1ncP8uWpfNQgh/1H4GvTtmghlrKrcoPPAYozFC7qafIgyTmeI4ySpO/wZ1hyq
	JTJM8bnC3oGerW8RHlqo1Dn/hWac3cxlSUg/SLIUaukhiJKOUWn+ZSNyrmTKosdsbe1Re1S8pju+w
	Uwb3nckaKcpwIyHpl9j3/Hlw9meBWtDYuBS2fuwhH+fUSB+m9sY0lLRN88h6FW2XZx68buBK5YEdJ
	bU/FBkHA9l6EfqDjW2OfXMgyJ1ZtwlOXdKlxCUE3TU88mCg3qTl1hSZY/QopdmCteOIbCuAPsf9BL
	9oSOjtnWfp/Vv3vjRC4AHlzAWhpTdc8dCauA==;
Received: from ouster448.stanford.edu ([172.24.72.71]:55223 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tzOqF-000219-Qs; Mon, 31 Mar 2025 16:46:57 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v7 00/14] Begin upstreaming Homa transport protocol
Date: Mon, 31 Mar 2025 16:45:33 -0700
Message-ID: <20250331234548.62070-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 37ebbbd1f3b6ac136ac8d1f8e8dc2007

This patch series begins the process of upstreaming the Homa transport
protocol. Homa is an alternative to TCP for use in datacenter
environments. It provides 10-100x reductions in tail latency for short
messages relative to TCP. Its benefits are greatest for mixed workloads
containing both short and long messages running under high network loads.
Homa is not API-compatible with TCP: it is connectionless and message-
oriented (but still reliable and flow-controlled). Homa's new API not
only contributes to its performance gains, but it also eliminates the
massive amount of connection state required by TCP for highly connected
datacenter workloads (Homa uses ~ 1 socket per application, whereas
TCP requires a separate socket for each peer).

For more details on Homa, please consult the Homa Wiki:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview
The Wiki has pointers to two papers on Homa (one of which describes
this implementation) as well as man pages describing the application
API and other information.

There is also a GitHub repo for Homa:
https://github.com/PlatformLab/HomaModule
The GitHub repo contains a superset of this patch set, including:
* Additional source code that will eventually be upstreamed
* Extensive unit tests (which will also be upstreamed eventually)
* Application-level library functions (which need to go in glibc?)
* Man pages (which need to be upstreamed as well)
* Benchmarking and instrumentation code

For this patch series, Homa has been stripped down to the bare minimum
functionality capable of actually executing remote procedure calls. (about
8000 lines of source code, compared to 15000 in the complete Homa). The
remaining code will be upstreamed in smaller batches once this patch
series has been accepted. Note: the code in this patch series is
functional but its performance is not very interesting (about the same
as TCP).

The patch series is arranged to introduce the major functional components
of Homa. Until the last patch has been applied, the code is inert (it
will not be compiled).

Note: this implementation of Homa supports both IPv4 and IPv6.

v7 changes:
- Add documentation files reap.txt and sync.txt.
- Replace __u64 with _u64 (and __s64 with s64) in non-uapi settings.
- Replace '__aligned(L1_CACHE_BYTES)' with '____cacheline_aligned_in_smp'.
- Use alloc_percpu_gfp for homa_pool::cores.
- Extract bool homa_bpage_available from homa_pool_get_pages.
- Rename homa_rpc_free to homa_rpc_end.
- Use skb_queue_purge in homa_rpc_reap instead of hand-coding.
- Clean up RCU usage in several places:
  - Eliminate unnecessary use of RCU for homa_sock::dead_rpcs.
  - Eliminate use of RCU for homa::throttled_rpcs (unnecessary, unclear
    that it would have worked). Added return value from homa_pacer_xmit.
  - Call rcu_read_lock/unlock in homa_peer_find (just to be safe; probably
    isn't necessary)
  - Eliminate extraneous use of RCU in homa_pool_allocate.
  - Cleaned up RCU usage around homa_sock::active_rpcs.
  - Change homa_sock_find to take a reference on the returned socket;
    caller no longer has to worry about RCU issues.
- Remove "locker" arguments from homa_lock_rpc, homa_lock_sock,
  homa_rpc_try_lock, and homa_bucket_lock (shouldn't be needed, given
  CONFIG_PROVE_LOCKING).
- Use __GFP_ZERO in *alloc calls instead of initializing individual
  struct fields to zero.
- Don't use raw_smp_processor_id; use smp_processor_id instead.
- Remove homa_peertab_get_peers from this patch series (and also fix
  problems in it related to RCU usage).
- Add annotation to homa_peertab_gc_dsts requiring write_lock.
- Remove "lock_slow" functions, which don't add functionality in this patch
  series.
- Remove unused fields from homa_peer structs.
- Reorder fields in homa_rpc_bucket to squeeze out padding.
- Refactor homa_sock_start_scan etc.
  - Take a reference on the current socket to keep it from being freed.
  - No need now for homa_socktab::active_scans or struct homa_socktab_links.
  - rcu_read_lock/unlock is now entirely in the homa_sock scan methods;
    no need for callers to worry about this.
- Add homa_rpc_hold and homa_rpc_put. Replaces several ad-hoc mechanisms,
  such as RPC_COPYING_FROM_USER and RPC_COPYING_TO_USER, with a single
  general-purpose mechanism.
- Use __skb_queue_purge instead of skb_queue_purge (locking isn't needed
  because Homa has its own locks).
- Rename UNKNOWN packet type to RPC_UNKNOWN.
- Add hsk->is_server plus SO_HOMA_SERVER setsockopt: by default, sockets
  will not accept incoming RPCs unless they have been bound.
- Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard mechanisms (wait_event_*) for blocking
  threads. Create homa_interest.c and homa_interest.h.
* Add memory accounting for outbound messages (e.g. new sysctl value
  wmem_max); senders now block when memory limit is exceeded.
* Made Homa a pernet subsystem (a separate Homa transport for each
  network namespace).

v6 changes:
- Make hrtimer variable in homa_timer_main static instead of stack-allocated
  (avoids complaints when in debug mode).
- Remove unnecessary cast in homa_dst_refresh.
- Replace erroneous uses of GFP_KERNEL with GFP_ATOMIC.
- Check for "all ports in use" in homa_sock_init.
- Refactor API for homa_rpc_reap to incorporate "reap all" feature,
  eliminate need for callers to specify exact amount of work to do
  when in "reap a few" mode.
- Fix bug in homa_rpc_reap (wasn't resetting rx_frees for each iteration
  of outer loop).

v5 changes:
- Change type of start in struct homa_rcvbuf_args from void* to __u64;
  also add more __user annotations.
- Refactor homa_interest: replace awkward ready_rpc field with two
  fields: rpc and rpc_ready. Added new functions homa_interest_get_rpc
  and homa_interest_set_rpc to encapsulate/clarify access to
  interest->rpc_ready.
- Eliminate use of LIST_POISON1 etc. in homa_interests (use list_del_init
  instead of list_del).
- Remove homa_next_skb function, which is obsolete, unused, and incorrect
- Eliminate ipv4_to_ipv6 function (use ipv6_addr_set_v4mapped instead)
- Eliminate is_mapped_ipv4 function (use ipv6_addr_v4mapped instead)
- Use __u64 instead of uint64_t in homa.h
- Remove 'extern "C"' from homa.h
- Various fixes from patchwork checks (checkpatch.pl, etc.)
- A few improvements to comments

v4 changes:
- Remove sport argument for homa_find_server_rpc (unneeded). Also
  remove client_port field from struct homa_ack
- Refactor ICMP packet handling (v6 was incorrect)
- Check for socket shutdown in homa_poll
- Fix potential for memory garbling in homa_symbol_for_type
- Remove unused ETHERNET_MAX_PAYLOAD declaration
- Rename classes in homa_wire.h so they all have "homa_" prefixes
- Various fixes from patchwork checks (checkpatch.pl, etc.)
- A few improvements to comments

v3 changes:
- Fix formatting in Kconfig
- Set ipv6_pinfo_offset in struct proto
- Check return value of inet6_register_protosw
- In homa_load cleanup, don't cleanup things that haven't been
  initialized
- Add MODULE_ALIAS_NET_PF_PROTO_TYPE to auto-load module
- Check return value from kzalloc call in homa_sock_init
- Change SO_HOMA_SET_BUF to SO_HOMA_RCVBUF
- Change struct homa_set_buf_args to struct homa_rcvbuf_args
- Implement getsockopt for SO_HOMA_RCVBUF
- Return ENOPROTOOPT instead of EINVAL where appropriate in
  setsockopt and getsockopt
- Fix crash in homa_pool_check_waiting if pool has no region yet
- Check for NULL msg->msg_name in homa_sendmsg
- Change addr->in6.sin6_family to addr->sa.sa_family in homa_sendmsg
  for clarity
- For some errors in homa_recvmsg, return directly rather than "goto done"
- Return error from recvmsg if offsets of returned read buffers are bogus
- Added comments to clarify lock-unlock pairs for RPCs
- Renamed homa_try_bucket_lock to homa_try_rpc_lock
- Fix issues found by test robot and checkpatch.pl
- Ensure first argument to do_div is 64 bits
- Remove C++ style comments
- Removed some code that will only be relevant in future patches that
  fill in missing Homa functionality

v2 changes:
- Remove sockaddr_in_union declaration from public API in homa.h
- Remove kernel wrapper functions (homa_send, etc.) from homa.h
- Fix many sparse warnings (still more work to do here) and other issues
  uncovered by test robot
- Fix checkpatch.pl issues
- Remove residual code related to unit tests
- Remove references to tt_record from comments
- Make it safe to delete sockets during homa_socktab scans
- Use uintptr_t for portability fo 32-bit platforms
- Use do_div instead of "/" for portability
- Remove homa->busy_usecs and homa->gro_busy_usecs (not needed in
  this stripped down version of Homa)
- Eliminate usage of cpu_khz, use sched_clock instead of get_cycles
- Add missing checks of kmalloc return values
- Remove "inline" qualifier from functions in .c files
- Document that pad fields must be zero
- Use more precise type "uint32_t" rather than "int"
- Remove unneeded #include of linux/version.h

John Ousterhout (14):
  net: homa: define user-visible API for Homa
  net: homa: create homa_wire.h
  net: homa: create shared Homa header files
  net: homa: create homa_pool.h and homa_pool.c
  net: homa: create homa_peer.h and homa_peer.c
  net: homa: create homa_sock.h and homa_sock.c
  net: homa: create homa_interest.h and homa_interest.c
  net: homa: create homa_rpc.h and homa_rpc.c
  net: homa: create homa_outgoing.c
  net: homa: create homa_utils.c
  net: homa: create homa_incoming.c
  net: homa: create homa_timer.c
  net: homa: create homa_plumbing.c
  net: homa: create Makefile and Kconfig

 include/uapi/linux/homa.h |  196 +++++++
 net/Kconfig               |    1 +
 net/Makefile              |    1 +
 net/homa/Kconfig          |   19 +
 net/homa/Makefile         |   15 +
 net/homa/homa_impl.h      |  624 +++++++++++++++++++++
 net/homa/homa_incoming.c  |  909 ++++++++++++++++++++++++++++++
 net/homa/homa_interest.c  |  122 +++++
 net/homa/homa_interest.h  |   99 ++++
 net/homa/homa_outgoing.c  |  835 ++++++++++++++++++++++++++++
 net/homa/homa_peer.c      |  308 +++++++++++
 net/homa/homa_peer.h      |  211 +++++++
 net/homa/homa_plumbing.c  | 1093 +++++++++++++++++++++++++++++++++++++
 net/homa/homa_pool.c      |  454 +++++++++++++++
 net/homa/homa_pool.h      |  148 +++++
 net/homa/homa_rpc.c       |  481 ++++++++++++++++
 net/homa/homa_rpc.h       |  482 ++++++++++++++++
 net/homa/homa_sock.c      |  391 +++++++++++++
 net/homa/homa_sock.h      |  385 +++++++++++++
 net/homa/homa_stub.h      |   91 +++
 net/homa/homa_timer.c     |  155 ++++++
 net/homa/homa_utils.c     |  118 ++++
 net/homa/homa_wire.h      |  360 ++++++++++++
 net/homa/reap.txt         |   50 ++
 net/homa/sync.txt         |   77 +++
 25 files changed, 7625 insertions(+)
 create mode 100644 include/uapi/linux/homa.h
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile
 create mode 100644 net/homa/homa_impl.h
 create mode 100644 net/homa/homa_incoming.c
 create mode 100644 net/homa/homa_interest.c
 create mode 100644 net/homa/homa_interest.h
 create mode 100644 net/homa/homa_outgoing.c
 create mode 100644 net/homa/homa_peer.c
 create mode 100644 net/homa/homa_peer.h
 create mode 100644 net/homa/homa_plumbing.c
 create mode 100644 net/homa/homa_pool.c
 create mode 100644 net/homa/homa_pool.h
 create mode 100644 net/homa/homa_rpc.c
 create mode 100644 net/homa/homa_rpc.h
 create mode 100644 net/homa/homa_sock.c
 create mode 100644 net/homa/homa_sock.h
 create mode 100644 net/homa/homa_stub.h
 create mode 100644 net/homa/homa_timer.c
 create mode 100644 net/homa/homa_utils.c
 create mode 100644 net/homa/homa_wire.h
 create mode 100644 net/homa/reap.txt
 create mode 100644 net/homa/sync.txt

--
2.34.1


