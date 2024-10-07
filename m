Return-Path: <netdev+bounces-132871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF49939ED
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5833B20EA1
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E75418C911;
	Mon,  7 Oct 2024 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="DEhppDyv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32A7187876
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339389; cv=none; b=qT+Kx5jBH5xz5xSUx5xaQAMkt1N5KuDruG5/cgMkndh8yMv2R9KaQ+ZEZWsXjFSII2/i7aGJhjEZJbPNNGio4+qq1EsmfnoihdGlrEI2Veq5FdP0j4Nb0DlRDLZDvHr/ISIad97wYAzcRN4Yit9HTgj3+EIL/x+xzLUSZc5SBvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339389; c=relaxed/simple;
	bh=7C8bPrmlWzZ0fDgCfsqHbdUxwredIend7rcx+h8H6Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6XuXOaPQR69O+Sz33Qq6P0XN/JhVIYYSD0CrCjfen4+/knlOnca7PVmErjohJE6CIEJeStiSsY/1+mhhqEiF9lD5kj9O1l8hT2ysVy+PbsU6NsfhSytNDslL0IZXmv5lUFvkg75vvyY2hD1A68BNFy/tCF1Ze1jLxfBo8LPYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=DEhppDyv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-208cf673b8dso54672015ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728339387; x=1728944187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nuv2n+8uEHTfuIuhS+E4zqbrQvcw4irJS2P1hGkAKqo=;
        b=DEhppDyvHlzEwDYlYh2vBd8H8WtNjYG80nyrymnw5DgGObcJKNZibKCiXKfWLDM42v
         5eJ9I2kQyl5WGZdqd2Zby1fsrKWa0zXRTj9Sq1BlfN2pNui+3sbmF5JkxBq8hdLp51Jq
         mOXZ1i89kE+Pbr/vpRl1VuzDw9k8CP6EO1a/8vPeOYlGKJZcqfSn0vCysifLhuh5FlYQ
         02NM2ig3YWXaugVy7wRpV75LEhdsr3oBmFNUKM7I4fo52TGI+kV7TlXUEBqCQBgK4bXn
         NsIUqcLax5zoQlOwAaAErP0OCXneH6cyOhZviStw8uh/KP0gYSL8ZvM7sfdiaUycsF0j
         g6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339387; x=1728944187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuv2n+8uEHTfuIuhS+E4zqbrQvcw4irJS2P1hGkAKqo=;
        b=reNhm7cKyVwjUFLJqmL8BnrExhxLDpz48UYhKkKaKNGSQpBmjHIAigSpD1+yOMlZhC
         vuvkb5AsNnxkZYKrfenLuJXE016zEuiTRnXmsoUpPy0ZEdkjYHa3DcnfnUTWjPIqekx0
         uFnaLxuHtrdmGk2RX0aXfnTlWox1u2e7mr8gD2slwGq+Hla4OX3Qy5sIU5ztzHN5Q0LM
         uPgOOXsI/OV6hovvgv7iJ1P4EWGRDJL6qFlmZ0vnENQ+YroPg58LEVmZtCgzEQpG8sk6
         qfT/8unpZnFPWohmgPWSncj+WA31vYNsUFWBnAwtNIhyMIthyjow05PP+lQfsGdAQZB1
         44Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWojU8mIvP/zto+o8SNDthSlhKqRoTz6ZJQ6qdV4I6gfxfF561Kpq0Y7idhisTbbmqaMIJjYG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIaHVQXFldi+kPnngrS0zLja/CpXhPQ5cHEhj33Z3faVU/Dwg
	Fenu90WOy+LZWCvzMphbySC/2DwQUHr7zaEp2gi4I4Vm5thEEm5ymXTGwOUOF/g=
X-Google-Smtp-Source: AGHT+IHCGtbhDRV/KP3m/cCLBEHrtu8jvcqjBkoWdcKzH5jVoTJKteDirpGCgm+WWhjmQYXvbAmQVw==
X-Received: by 2002:a17:903:4408:b0:20b:b455:eb7c with SMTP id d9443c01a7336-20bff176f0cmr185914875ad.56.1728339386975;
        Mon, 07 Oct 2024 15:16:26 -0700 (PDT)
Received: from localhost (fwdproxy-prn-114.fbsv.net. [2a03:2880:ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1398cecasm44240605ad.276.2024.10.07.15.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:16:26 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: David Wei <dw@davidwei.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH v1 00/15] io_uring zero copy rx
Date: Mon,  7 Oct 2024 15:15:48 -0700
Message-ID: <20241007221603.1703699-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for zero copy rx into userspace pages using
io_uring, eliminating a kernel to user copy.

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

Test setup:
* AMD EPYC 9454
* Broadcom BCM957508 200G
* Kernel v6.11 base [2]
* liburing fork [3]
* kperf fork [4]
* 4K MTU
* Single TCP flow

With application thread + net rx softirq pinned to _different_ cores:

epoll
82.2 Gbps

io_uring
116.2 Gbps (+41%)

Pinned to _same_ core:

epoll
62.6 Gbps

io_uring
80.9 Gbps (+29%)

==============
Patch overview
==============

Networking folks would be mostly interested in patches 1-8, 11 and 14.
Patches 1-2 clean up net_iov and devmem, then patches 3-8 make changes
to netdev to suit our needs.

Patch 11 implements struct memory_provider_ops, and Patch 14 passes it
all to netdev via the queue API.

io_uring folks would be mostly interested in patches 9-15:

* Initial registration that sets up a hw rx queue.
* Shared ringbuf for userspace to return buffers.
* New request type for doing zero copy rx reads.

=====
Links
=====

Broadcom bnxt support:
[1]: https://lore.kernel.org/netdev/20241003160620.1521626-8-ap420073@gmail.com/

Linux kernel branch:
[2]: https://github.com/isilence/linux.git zcrx/v5

liburing for testing:
[3]: https://github.com/spikeh/liburing/tree/zcrx/next

kperf for testing:
[4]: https://github.com/spikeh/kperf/tree/zcrx/next

Changes in v1:
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

David Wei (5):
  net: page pool: add helper creating area from pages
  io_uring/zcrx: add interface queue and refill queue
  io_uring/zcrx: add io_zcrx_area
  io_uring/zcrx: add io_recvzc request
  io_uring/zcrx: set pp memory provider for an rx queue

Jakub Kicinski (1):
  net: page_pool: create hooks for custom page providers

Pavel Begunkov (9):
  net: devmem: pull struct definitions out of ifdef
  net: prefix devmem specific helpers
  net: generalise net_iov chunk owners
  net: prepare for non devmem TCP memory providers
  net: page_pool: add ->scrub mem provider callback
  net: add helper executing custom callback from napi
  io_uring/zcrx: implement zerocopy receive pp memory provider
  io_uring/zcrx: add copy fallback
  io_uring/zcrx: throttle receive requests

 include/linux/io_uring/net.h   |   5 +
 include/linux/io_uring_types.h |   3 +
 include/net/busy_poll.h        |   6 +
 include/net/netmem.h           |  21 +-
 include/net/page_pool/types.h  |  27 ++
 include/uapi/linux/io_uring.h  |  54 +++
 io_uring/Makefile              |   1 +
 io_uring/io_uring.c            |   7 +
 io_uring/io_uring.h            |  10 +
 io_uring/memmap.c              |   8 +
 io_uring/net.c                 |  81 ++++
 io_uring/opdef.c               |  16 +
 io_uring/register.c            |   7 +
 io_uring/rsrc.c                |   2 +-
 io_uring/rsrc.h                |   1 +
 io_uring/zcrx.c                | 847 +++++++++++++++++++++++++++++++++
 io_uring/zcrx.h                |  74 +++
 net/core/dev.c                 |  53 +++
 net/core/devmem.c              |  44 +-
 net/core/devmem.h              |  71 ++-
 net/core/page_pool.c           |  81 +++-
 net/core/page_pool_user.c      |  15 +-
 net/ipv4/tcp.c                 |   8 +-
 23 files changed, 1364 insertions(+), 78 deletions(-)
 create mode 100644 io_uring/zcrx.c
 create mode 100644 io_uring/zcrx.h

-- 
2.43.5


