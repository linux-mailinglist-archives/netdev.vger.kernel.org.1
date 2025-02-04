Return-Path: <netdev+bounces-162757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98034A27DDF
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025433A5FA2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C35D219A9F;
	Tue,  4 Feb 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JmZmJlID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DB219E98
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706187; cv=none; b=EUyd9meEN7eaMSjQz82USzxzMyAQVUo88yD6aJyXgYvZ9+bfoa5zo9nCnJelersHQxmd8b0Yx0rtqGF317mxTX7n0eA9zRc1sVMA1ME9a9iQ4+G8YAK+kqvEukxyN+lCtyf9/RiqkLOuULQxv9b8JWtcHUcIfmwd9JI5Lmvan2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706187; c=relaxed/simple;
	bh=3TTTMAlH6QrUD1JEhhh3jlOL8Od/24VgLeIkmIzVb8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HYEHo/xhCVYcWvspGlSc/hy+eKSFyikUZDxePE3uQyDizgj81FGKJVpC4CR6+WRodzO/OSyN3iccQkYCVyAeYtFZh7ScRUb0NY3/54dCHgPOieMBweBzm7yC5YtnVDM9zN8arnaRT9WQ26n8czb/raz8eLHUTKlndzuZeEdXQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JmZmJlID; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21effc750d2so21955975ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738706184; x=1739310984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0S8m7MJQ5/FnsU214aSM8zvp8aT7+npI6Aryy8yySDg=;
        b=JmZmJlIDwtqjK6jPs5kmPcQkXdv/2f8okEyBqkWcduEaWQeYZ5LYsTM+qBVdbFh+bS
         KoRv9564uoNNjMz57FLa92SCdMEID4ikyqHUKvNsM3cNP0pmvxoDF8WugNM57sdDUs6Y
         bFzDU8z3kBnnRzTPiZdmuBhxPHizk2UrG+pEBmUbWQ97WInJ4aLyg+rABv1XetmqILpi
         tqoc8GCSWKgITdr6f9snLUL9R6CjXEK5FawiMOU9SkUD/+8cn9T0XeG6AnI0X95XIrUw
         3M2cQbd3kRsqjfXbiFXMGZPBA7fGXMQ/BCmsmN2NEyo1jyNvwhWePXqJ3vwPRcjla3TM
         h+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738706184; x=1739310984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0S8m7MJQ5/FnsU214aSM8zvp8aT7+npI6Aryy8yySDg=;
        b=HHv8lequb5bVD35z9VmRuwPQDzZO4PBXy4qSUyOdWDZXFReiux+FyBPR8Nh9s9+N2m
         tVVzl0qQFW9LeOxJJ2APRDDIIwTW6v8EM2Dk6gsn40rp9IK5yPiEOoNBxbOuldrSEmN/
         WoHv3CFbCMT8EVAo7zSTspn+Av5pObv7iAp3lrGsaZCavE3zrsV+PVaX0gl0jCH/lXzG
         3F4wNjsj9g0Trm0S6w9Xy0OQp7GNXhaxzxyVAxQRvwEpPMUCylBOcgEnqLR7PqqBj5DJ
         q4KgBmA5TzsK0Wvx7suJ+thb4+7JgShucYCgGB92oO2GicUWRa1Tgd5wSJ8IaUYSdgn+
         ATLA==
X-Gm-Message-State: AOJu0YzBBRhf4nQK//nUDxcpUVSsjkvXmAQ8XdYGRMs63kovtmb4ewT1
	HhnjkdyE+t7m3rdCn8QEngx20MDKRCAUubD+AJhLUHvFti5PDZ/HPL2LoDZY3WseeybELzYpirh
	C
X-Gm-Gg: ASbGncv5O30Cqi0lW43Hq6S70QoWL1xL4eadSPQt7+SnqontUL0VuJedcH2uUJxPAv6
	QR8y9mVqCXVG+OAvNNj3J5fWRRudOZLFjw0j19pAYOfm4pxpDmOIPFGM/oWY7B+G6WWq1wTRKKn
	Oy8G9Hkd5mHgVPjOE5wP2HNwWzP8qC4tKVheSfWESs+wQO3qU5vVxt6JGhFvleTh3T7UcAoBU+o
	9GW0ElhTHky0Ow8R+KQRtECOLwVUcLVJZImRWmTTG3VR26DSMEsiDF7/K7Edg99UQk21PSYQTcF
X-Google-Smtp-Source: AGHT+IEsTnpMGB61RE+33oGsObrNjsHgkla90sANheM1n4lzyDlsOZ6ylAWFhYstpfVEj5mje2AXNQ==
X-Received: by 2002:a05:6a00:e87:b0:725:e499:5b8a with SMTP id d2e1a72fcca58-730351bd62dmr720485b3a.15.1738706184308;
        Tue, 04 Feb 2025 13:56:24 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69bbb5dsm11408786b3a.97.2025.02.04.13.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 13:56:23 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v13 00/10] io_uring zero copy rx
Date: Tue,  4 Feb 2025 13:56:11 -0800
Message-ID: <20250204215622.695511-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset contains net/ patches needed by a new io_uring request
implementing zero copy rx into userspace pages, eliminating a kernel
to user copy.

We configure a page pool that a driver uses to fill a hw rx queue to
hand out user pages instead of kernel pages. Any data that ends up
hitting this hw rx queue will thus be dma'd into userspace memory
directly, without needing to be bounced through kernel memory. 'Reading'
data out of a socket instead becomes a _notification_ mechanism, where
the kernel tells userspace where the data is. The overall approach is
similar to the devmem TCP proposal.

This relies on hw header/data split, flow steering and RSS to ensure
packet headers remain in kernel memory and only desired flows hit a hw
rx queue configured for zero copy. Configuring this is outside of the
scope of this patchset.

We share netdev core infra with devmem TCP. The main difference is that
io_uring is used for the uAPI and the lifetime of all objects are bound
to an io_uring instance. Data is 'read' using a new io_uring request
type. When done, data is returned via a new shared refill queue. A zero
copy page pool refills a hw rx queue from this refill queue directly. Of
course, the lifetime of these data buffers are managed by io_uring
rather than the networking stack, with different refcounting rules.

This patchset is the first step adding basic zero copy support. We will
extend this iteratively with new features e.g. dynamically allocated
zero copy areas, THP support, dmabuf support, improved copy fallback,
general optimisations and more.

In terms of netdev support, we're first targeting Broadcom bnxt. Patches
aren't included since Taehee Yoo has already sent a more comprehensive
patchset adding support in [1]. Google gve should already support this,
and Mellanox mlx5 support is WIP pending driver changes.

===========
Performance
===========

Note: Comparison with epoll + TCP_ZEROCOPY_RECEIVE isn't done yet.

Test setup:
* AMD EPYC 9454
* Broadcom BCM957508 200G
* Kernel v6.11 base [2]
* liburing fork [3]
* kperf fork [4]
* 4K MTU
* Single TCP flow

With application thread + net rx softirq pinned to _different_ cores:

+-------------------------------+
| epoll     | io_uring          |
|-----------|-------------------|
| 82.2 Gbps | 116.2 Gbps (+41%) |
+-------------------------------+

Pinned to _same_ core:

+-------------------------------+
| epoll     | io_uring          |
|-----------|-------------------|
| 62.6 Gbps | 80.9 Gbps (+29%)  |
+-------------------------------+

=====
Links
=====

Broadcom bnxt support:
[1]: https://lore.kernel.org/netdev/20241003160620.1521626-8-ap420073@gmail.com/

Linux kernel branch including io_uring bits:
[2]: https://github.com/isilence/linux.git zcrx/v13

liburing for testing:
[3]: https://github.com/isilence/liburing.git zcrx/next

kperf for testing:
[4]: https://git.kernel.dk/kperf.git

Changes in v13:
---------------
* Fix race between io_uring closing and netdev unregister
* Regenerate Netlink YAML

Changes in v12:
---------------
* Check nla_nest_start() errors
* Don't leak a netdev, add missing netdev_put()
* Warn on failed queue restart during close

Changes in v11:
---------------
* Add a shim provider helper for page_pool_set_dma_addr_netmem()
* Drop netdev in ->uninstall, pin struct device instead
* Add net_mp_open_rxq() and net_mp_close_rxq()
* Remove unneeded CFLAGS += -I/usr/include/ in selftest Makefile

Changes in v10:
---------------
* Fix !CONFIG_PAGE_POOL build
* Use acquire/release for RQ in examples
* Fix page_pool_ref_netmem for net_iov
* Move provider helpers / definitions into a new file
* Don’t export page_pool_{set,clear}_pp_info, introduce
  net_mp_niov_{set,clear}_page_pool() instead
* Remove devmem.h from net/core/page_pool_user.c
* Add Netdev yaml for io-uring attribute
* Add memory provider ops for filling in Netlink info

Changes in v9:
--------------
* Fail proof against multiple page pools running the same memory
  provider
  * Lock the consumer side of the refill queue.
  * Move scrub into io_uring exit.
  * Kill napi_execute.
  * Kill area init api and export finer grained net helpers as partial
    init now need to happen in ->alloc_netmems()
* Separate user refcounting.
  * Fix copy fallback path math.
* Add rodata check to page_pool_init()
* Fix incorrect path in documentation

Changes in v8:
--------------
* add documentation and selftest
* use io_uring regions for the refill ring

Changes in v7:
--------------
net:
* Use NAPI_F_PREFER_BUSY_POLL for napi_execute + stylistics changes.

Changes in v6:
--------------
Please note: Comparison with TCP_ZEROCOPY_RECEIVE isn't done yet.

net:
* Drop a devmem.h clean up patch.
* Migrate to netdev_get_by_index from deprecated API.
* Fix !CONFIG_NET_DEVMEM build.
* Don’t return into the page pool cache directly, use a new helper
* Refactor napi_execute

io_uring:
* Require IORING_RECV_MULTISHOT flag set.
* Add unselectable CONFIG_IO_URING_ZCRX.
* Pulled latest io_uring changes.
* Unexport io_uring_pp_zc_ops.

Changes in v5:
--------------
* Rebase on top of merged net_iov + netmem infra.
* Decouple net_iov from devmem TCP.
* Use netdev queue API to allocate an rx queue.
* Minor uAPI enhancements for future extensibility.
* QoS improvements with request throttling.

Changes in RFC v4:
------------------
* Rebased on top of Mina Almasry's TCP devmem patchset and latest
  net-next, now sharing common infra e.g.:
    * netmem_t and net_iovs
    * Page pool memory provider
* The registered buffer (rbuf) completion queue where completions from
  io_recvzc requests are posted is removed. Now these post into the main
  completion queue, using big (32-byte) CQEs. The first 16 bytes is an
  ordinary CQE, while the latter 16 bytes contain the io_uring_rbuf_cqe
  as before. This vastly simplifies the uAPI and removes a level of
  indirection in userspace when looking for payloads.
  * The rbuf refill queue is still needed for userspace to return
    buffers to kernel.
* Simplified code and uAPI on the io_uring side, particularly
  io_recvzc() and io_zc_rx_recv(). Many unnecessary lines were removed
  e.g. extra msg flags, readlen, etc.

Changes in RFC v3:
------------------
* Rebased on top of Jakub Kicinski's memory provider API RFC. The ZC
  pool added is now a backend for memory provider.
* We're also reusing ppiov infrastructure. The refcounting rules stay
  the same but it's shifted into ppiov->refcount. That lets us to
  flexibly manage buffer lifetimes without adding any extra code to the
  common networking paths. It'd also make it easier to support dmabufs
  and device memory in the future.
  * io_uring also knows about pages, and so ppiovs might unnecessarily
    break tools inspecting data, that can easily be solved later.

Many patches are not for upstream as they depend on work in progress,
namely from Mina:

* struct netmem_t
* Driver ndo commands for Rx queue configs
* struct page_pool_iov and shared pp infra

Changes in RFC v2:
------------------
* Added copy fallback support if userspace memory allocated for ZC Rx
  runs out, or if header splitting or flow steering fails.
* Added veth support for ZC Rx, for testing and demonstration. We will
  need to figure out what driver would be best for such testing
  functionality in the future. Perhaps netdevsim?
* Added socket registration API to io_uring to associate specific
  sockets with ifqs/Rx queues for ZC.
* Added multi-socket support, such that multiple connections can be
  steered into the same hardware Rx queue.
* Added Netbench server/client support.

David Wei (2):
  netdev: add io_uring memory provider info
  net: add helpers for setting a memory provider on an rx queue

Pavel Begunkov (8):
  net: page_pool: don't cast mp param to devmem
  net: prefix devmem specific helpers
  net: generalise net_iov chunk owners
  net: page_pool: create hooks for custom memory providers
  net: page_pool: add callback for mp info printing
  net: page_pool: add a mp hook to unregister_netdevice*
  net: prepare for non devmem TCP memory providers
  net: page_pool: add memory provider helpers

 Documentation/netlink/specs/netdev.yaml | 15 ++++
 include/net/netmem.h                    | 21 +++++-
 include/net/page_pool/memory_provider.h | 45 ++++++++++++
 include/net/page_pool/types.h           |  4 ++
 include/uapi/linux/netdev.h             |  7 ++
 net/core/dev.c                          | 16 ++++-
 net/core/devmem.c                       | 93 ++++++++++++++++---------
 net/core/devmem.h                       | 49 ++++++-------
 net/core/netdev-genl.c                  | 11 +--
 net/core/netdev_rx_queue.c              | 69 ++++++++++++++++++
 net/core/page_pool.c                    | 51 +++++++++++---
 net/core/page_pool_user.c               |  7 +-
 net/ipv4/tcp.c                          |  7 +-
 tools/include/uapi/linux/netdev.h       |  7 ++
 14 files changed, 321 insertions(+), 81 deletions(-)
 create mode 100644 include/net/page_pool/memory_provider.h

-- 
2.43.5


