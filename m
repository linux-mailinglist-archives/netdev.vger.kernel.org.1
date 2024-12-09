Return-Path: <netdev+bounces-150304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF769E9D84
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A19164015
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667A154BFC;
	Mon,  9 Dec 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="cD9mLwD3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132713775E
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766736; cv=none; b=Y+sCFEO+Ry7xIiBsXmutijCj70aa4DgC8f+3r04zAN+nVrVcmcviVMxo3a3TSHuTKgudYRjkso8P24J0bQV+XKdztjPYNxItMVIzf42gxB/f/FH/MdjjtbM1dYswabBofyOjzwS3llU2CMSn9PlEXcZZafCVk4ApkgU2FpwDYfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766736; c=relaxed/simple;
	bh=q47wp+7ShOmXP9lThVu5siRWhq5Erpp/RWwWRLpRKOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWQr7g/PKQXZdKtxwmIF+I/lExWSsbrhsWuu75+wD7WraXPS7fS+L7zuyEsgq38wLjbr+0hqPyGVphnRcBBGFvL7lUjmFMfW367OtDb68ukvu4C270DcQvu3QSjVBHUneXfXz/4qYfPfr9iNT1yEWzaOnjHJaE8T+KDCmSdfOMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=cD9mLwD3; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+JhDzHtSkTfJYvYO/zyUqfJtGitI0F3X+O3mT98acPs=; t=1733766734; x=1734630734; 
	b=cD9mLwD3eBIvw7U9cztQTLgmK+shhk5/Mi6l9z8WjkAiAVdGmWcJOpwMrNxUoSm1URaX7djz6/i
	A4fbmVMFrh/LX1EN3t0zBVwq6S3g8A6CCOojjvHJKunMsW0RX65nw5PmkqjB8xcbWRjphXfCXdHXD
	iRAvtCivpeW7/QATQ5vJPueY0UUAs9eUBiYBpH1VEkCV7EkzZR8OyDrtL7ffM6cuFz7OpZX1vqWCA
	ja0kYXhFQ50jHQEFhKsO7FWJ1UzRifeidmXrwZy1narvEI0NqL2UmwVpzith15P03iIPQHwemfkFv
	S3a4i70FXF6Zkr8LXlQFX7zX5pKEMAv8+4QQ==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:53595 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tKhvY-0006KI-QF; Mon, 09 Dec 2024 09:52:13 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v3 00/12] Begin upstreaming Homa transport protocol
Date: Mon,  9 Dec 2024 09:51:17 -0800
Message-ID: <20241209175131.3839-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 9c1c2f2bbf77627aba3b3999e7d87b9b

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
  net: homa: define Homa packet formats
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
 include/uapi/linux/homa.h |  164 ++++++
 net/Kconfig               |    1 +
 net/Makefile              |    1 +
 net/homa/Kconfig          |   19 +
 net/homa/Makefile         |   14 +
 net/homa/homa_impl.h      |  696 ++++++++++++++++++++++++
 net/homa/homa_incoming.c  | 1074 +++++++++++++++++++++++++++++++++++++
 net/homa/homa_outgoing.c  |  854 +++++++++++++++++++++++++++++
 net/homa/homa_peer.c      |  367 +++++++++++++
 net/homa/homa_peer.h      |  232 ++++++++
 net/homa/homa_plumbing.c  | 1024 +++++++++++++++++++++++++++++++++++
 net/homa/homa_pool.c      |  446 +++++++++++++++
 net/homa/homa_pool.h      |  154 ++++++
 net/homa/homa_rpc.c       |  489 +++++++++++++++++
 net/homa/homa_rpc.h       |  458 ++++++++++++++++
 net/homa/homa_sock.c      |  386 +++++++++++++
 net/homa/homa_sock.h      |  401 ++++++++++++++
 net/homa/homa_stub.h      |   81 +++
 net/homa/homa_timer.c     |  157 ++++++
 net/homa/homa_utils.c     |  177 ++++++
 net/homa/homa_wire.h      |  365 +++++++++++++
 22 files changed, 7567 insertions(+)
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


