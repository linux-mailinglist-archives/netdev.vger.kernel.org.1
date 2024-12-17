Return-Path: <netdev+bounces-152421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6549F3EA7
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F671890F92
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF99804;
	Tue, 17 Dec 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="kk/izLd+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6310E0
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734394029; cv=none; b=VMrCf6qaavM7mTRCPAE2sSfjasAmsty5niBAIRGrHFbIDoSA0ERVZw8DfDDVtVX32FBEEGf3SXhXxYyrzH7BLVyXzQlN8UGNoSFjtbvPfjZQYsmuA8fnrLOMQWHVSSktEPfa+SiHVCagS6+S73mI+B/KC4E0PGN1hJ6OXt6GkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734394029; c=relaxed/simple;
	bh=cBy7Gsab2Y6/gMtCjGjnKlfXuu7deLzuy+/1KLvYDe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IrEm0ua6wH/hxbI8nBH5VMKggPui2f9Y8vOQ6u7nY7UOuXm9LJsaKzWyWO6G2y/+qCotRMHSiVTUBxPdyNQHXPRM8vd1K8O3c1C1E3DMU2OUwfQUMbVGOSt8Y5cNZ2Ro3lIeUIB0oRh1Nt9U4AmXnTc+N3tzcmD28Vfn2fgPbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=kk/izLd+; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=li2YMYaPZXFwZapwVNx5spAaLak9BubJ/q2r2/gN8y4=; t=1734394027; x=1735258027; 
	b=kk/izLd+jvTbcVBV1OOX8bVMNeU+RPSSqdz+A1OUM02Chruez3xWuJKh/y9M14sXF1w2oFn3hcV
	fL9K0WsJtpUxS+/FDdI/cq/OWo6m9xD6AcWfYQceeX1a3wOhsz8I65OVDXw3HhCFPDXati//zhG1Y
	dE6q/eZbPsGZF0++ZV4rU9MRcB3w1pdebrwmBHGjhT5HJhqfiqjVV/X1x8w+UkhienOgnowRnIAjT
	KOaaNu0VWHp+x/AUGxthVhVc9EyN0zLYF+5w2TIiRLFaMCxy5pJaXOLsIu0Cp3hecJI0YRM+nvM3v
	x2SQYrmlNbp4JbhcnQ6iNPiP8EuYFhHBFZaQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:53919 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tNL76-0002IN-67; Mon, 16 Dec 2024 16:07:01 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v4 00/12] Begin upstreaming Homa transport protocol
Date: Mon, 16 Dec 2024 16:06:13 -0800
Message-ID: <20241217000626.2958-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 8702cc1dda9699d4c426511d87241f5c

This patch series begins the process of upstreaming the Homa transport
protocol. Homa is an alternative to TCP for use in datacenter
environments. It provides 10-100x reductions in tail latency for short
messages relative to TCP. Its benefits are greatest for mixed workloads
containing both short and long messages running under high network loads.
Homa is not API-compatible with TCP: it is connectionless and message-
oriented (but still reliable and flow-controlled). Homa's new API not
only contributes to its performance gains, but it also eliminates the
massive amount of connection state required by TCP for highly connected
datacenter workloads.

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

John Ousterhout (12):
  inet: homa: define user-visible API for Homa
  net: homa: create homa_wire.h
  net: homa: create shared Homa header files
  net: homa: create homa_pool.h and homa_pool.c
  net: homa: create homa_rpc.h and homa_rpc.c
  net: homa: create homa_peer.h and homa_peer.c
  net: homa: create homa_sock.h and homa_sock.c
  net: homa: create homa_incoming.c
  net: homa: create homa_outgoing.c
  net: homa: create homa_timer.c
  net: homa: create homa_plumbing.c homa_utils.c
  net: homa: create Makefile and Kconfig

 MAINTAINERS               |    7 +
 include/uapi/linux/homa.h |  170 ++++++
 net/Kconfig               |    1 +
 net/Makefile              |    1 +
 net/homa/Kconfig          |   19 +
 net/homa/Makefile         |   14 +
 net/homa/homa_impl.h      |  720 +++++++++++++++++++++++++
 net/homa/homa_incoming.c  | 1073 +++++++++++++++++++++++++++++++++++++
 net/homa/homa_outgoing.c  |  855 +++++++++++++++++++++++++++++
 net/homa/homa_peer.c      |  364 +++++++++++++
 net/homa/homa_peer.h      |  233 ++++++++
 net/homa/homa_plumbing.c  | 1001 ++++++++++++++++++++++++++++++++++
 net/homa/homa_pool.c      |  446 +++++++++++++++
 net/homa/homa_pool.h      |  154 ++++++
 net/homa/homa_rpc.c       |  485 +++++++++++++++++
 net/homa/homa_rpc.h       |  458 ++++++++++++++++
 net/homa/homa_sock.c      |  382 +++++++++++++
 net/homa/homa_sock.h      |  406 ++++++++++++++
 net/homa/homa_stub.h      |   81 +++
 net/homa/homa_timer.c     |  157 ++++++
 net/homa/homa_utils.c     |  166 ++++++
 net/homa/homa_wire.h      |  355 ++++++++++++
 22 files changed, 7548 insertions(+)
 create mode 100644 include/uapi/linux/homa.h
 create mode 100644 net/homa/Kconfig
 create mode 100644 net/homa/Makefile
 create mode 100644 net/homa/homa_impl.h
 create mode 100644 net/homa/homa_incoming.c
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

--
2.34.1


