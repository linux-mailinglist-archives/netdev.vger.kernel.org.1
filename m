Return-Path: <netdev+bounces-187559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6553AAA7D7D
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A3C1899078
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 23:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0357C2701CA;
	Fri,  2 May 2025 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="JpE0U2Gn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EB2701B3
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229893; cv=none; b=UYeCTr32QVgD3MeEI/CmRqFe7lVjO2Qx3Q3bozPut5LcT7o/F6ylfKHg7NKFgLuiQO9RmHoiOlCfhxqju54ZuqRXB0DKzVu0IAyGtPxL9kNfhbZieDnfNRYN1dY7wZyeHgmHQ5iW6fGlRl8b6qBHMHAS6PpBh+myLiZvySDoZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229893; c=relaxed/simple;
	bh=LGPCT0AWBQ5w/VFKGdlGzusSPrzcmhrTx7nBWlqzbf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVMDhXHZ2nw1DpJdY1EoI2k1JUftvtfl3zfLFI10hJ540vSwhtUyShQaJQkmwNatOlKLecEAvbWIwU2lGdWoW0VtZppxRCktKIVH4nCKnZq9rlOAgQadkkaxkWIxlcNdmBA2brbUGvvq2BZBp5BFoVxS6Ne1qcwGp8ftKUXdsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=JpE0U2Gn; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+WT1HihxsSX3weA54C3Iffb4Ke/0uoPHp7BcPHG9ODE=; t=1746229891; x=1747093891; 
	b=JpE0U2GnU/PNZkxOusceVL3r0jnoMRwOx5YeV0S4o6ayx7aWzCslifjEAefBnIp2/i1lkoeGKgi
	zZ6jl+I5Jcwsc5fNcmdz5DsQAiqrNapq8oV8AA41YKJ+wTo/8BnfbufkSDg+JoAXJ6rH5CuO8XiTC
	SRDL4uILV0P3ydkYH+Cc1jw55wTvuZ9NMT7HMWpJSgQkY4vRSzz09E0/kCYl9Z2wZpParmdItt/ly
	zwIJCG5+5K9Pe6NEhk9D8NPnju3hJLOABlsX/KhVCT2hNIDkLZDD5AL+0knWJNvdSnVpBh51djrpF
	FJURGcLsOZZanxORaVjo5kxEHHcQZPa96OyQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:64199 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uAzxA-0007if-Vz; Fri, 02 May 2025 16:38:02 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v8 00/15] Begin upstreaming Homa transport protocol
Date: Fri,  2 May 2025 16:37:13 -0700
Message-ID: <20250502233729.64220-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: eb4d7a2d71a591ea43a6ca3dcb92f058

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

v8 changes:
- There were no reviews of the v7 patch series, so there are not many changes
  in this version
- Pull out pacer code into separate files pacer.h and pacer.c
- Refactor homa_pool APIs (move allocation/deallocation into homa_pool.c,
  move locking responsibility out)
- Fix various problems from sparse, checkpatch, and kernel-doc

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

John Ousterhout (15):
  net: homa: define user-visible API for Homa
  net: homa: create homa_wire.h
  net: homa: create shared Homa header files
  net: homa: create homa_pool.h and homa_pool.c
  net: homa: create homa_peer.h and homa_peer.c
  net: homa: create homa_sock.h and homa_sock.c
  net: homa: create homa_interest.h and homa_interest.
  net: homa: create homa_pacer.h and homa_pacer.c
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
 net/homa/Kconfig          |   21 +
 net/homa/Makefile         |   16 +
 net/homa/homa_impl.h      |  481 ++++++++++++++++
 net/homa/homa_incoming.c  |  922 +++++++++++++++++++++++++++++++
 net/homa/homa_interest.c  |  122 +++++
 net/homa/homa_interest.h  |  100 ++++
 net/homa/homa_outgoing.c  |  575 +++++++++++++++++++
 net/homa/homa_pacer.c     |  310 +++++++++++
 net/homa/homa_pacer.h     |  185 +++++++
 net/homa/homa_peer.c      |  308 +++++++++++
 net/homa/homa_peer.h      |  211 +++++++
 net/homa/homa_plumbing.c  | 1098 +++++++++++++++++++++++++++++++++++++
 net/homa/homa_pool.c      |  470 ++++++++++++++++
 net/homa/homa_pool.h      |  149 +++++
 net/homa/homa_rpc.c       |  484 ++++++++++++++++
 net/homa/homa_rpc.h       |  484 ++++++++++++++++
 net/homa/homa_sock.c      |  393 +++++++++++++
 net/homa/homa_sock.h      |  386 +++++++++++++
 net/homa/homa_stub.h      |   91 +++
 net/homa/homa_timer.c     |  156 ++++++
 net/homa/homa_utils.c     |  103 ++++
 net/homa/homa_wire.h      |  362 ++++++++++++
 net/homa/reap.txt         |   50 ++
 net/homa/sync.txt         |   77 +++
 27 files changed, 7752 insertions(+)
 create mode 100644 include/uapi/linux/homa.h
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile
 create mode 100644 net/homa/homa_impl.h
 create mode 100644 net/homa/homa_incoming.c
 create mode 100644 net/homa/homa_interest.c
 create mode 100644 net/homa/homa_interest.h
 create mode 100644 net/homa/homa_outgoing.c
 create mode 100644 net/homa/homa_pacer.c
 create mode 100644 net/homa/homa_pacer.h
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
2.43.0


