Return-Path: <netdev+bounces-140156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7529B5659
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B252B2167A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577A220ADFF;
	Tue, 29 Oct 2024 23:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Ew8Eikz3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3822207A01
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243161; cv=none; b=dqeGudhpXW1MDFLP/DvlBvAhr13LZLoEOy34n/ZldQ9/pdWOEAK9IvV+s5GIyxJpoHr3SLHmPCTL6w6WkjG+qed3eU1NaPgw68jLqa/1BYDiSFmcjfxEsYmqfqAq0Hlva7yWaJTel0Ak4dC3tG0rRHbbX827dn3JszdgjSJuWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243161; c=relaxed/simple;
	bh=ckYWs8vGwFdrsMZzNiBTyFnHL49borYUw0L7TKH09YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JFS/aTJsCDEtpkUMIY+Dv140WGmqNZQ1/BZrc4v/JBlzZgGRUAKkeuWpAGx1n4sQh2c9PJEbY1xZNOFAEaSbL0Tjldh5ZqmYGR0AueA/i7E2pPL64a+aoNQOw5SfTn77nePSlnIg9MI1Dy4YOv5tKlMdjckoDPhyPG9KGtySR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Ew8Eikz3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eab7622b61so4204929a12.1
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1730243158; x=1730847958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHTpdAKqGDn2tTPY3FMPpzdpWD2HjxROymlWuHycit8=;
        b=Ew8Eikz3Zup/i0Og7vHbHt7NbjAzpN3C1TVrTZ6vqwAMQ+EkUrryUJmZtr7ou1yUbk
         SrfaVGrC1962eXcCz3fX0WBAAhLZ3r2VMqGrYqKRpsYqowpi8MnQUWPDscYKn+UkpYGf
         7p5SIq4QJhwQMfGR5/ryyGki+ufPPOCCpBi6dJKuq0MCKfTGBHMUacNqXaFyOoCw2yzE
         HpwWyex/32gFPwtNV9HMpFkt1CSFpxsnEeHiQ0+45So2C4F8WOcgCqRXWbxhqMQYA1nI
         kZbhsqW1jQcfdxAko8CjxI5bNlQHEESiv9+20eqgn9egery5MSlP2jESEaZbjeXyJMcH
         3sgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730243158; x=1730847958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHTpdAKqGDn2tTPY3FMPpzdpWD2HjxROymlWuHycit8=;
        b=CcLJdA3MujUf2ciTKkN/VafKVhm1ULKQUD0evH2Gar/s9qtWmhZXdVb54P6b7VSbRS
         cmnT2Zh/Q+Jpsb5B73SHWEqax4yc80lGF3kpxiOL2VgYdepCBkHQpAn3vlUbH6tRx2WZ
         a1l9SjpisxzoRdIg4nulmta1jj7aPVzA6ub9cMZiNeXLiSfmFHRtJgX3VbJUjwrhRg56
         c0YLOcy8m4PswCENhyaOlw1vE/z2HyPWde7NLHafPkggIC36S86omcBVzxK2swkzoqyx
         WO3iYGZAZRvKzseFjovguVoz25evt89iNr14R0jRGNZqLSoDXKnNesdsjJ412wU8FbN9
         M6qw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQ0Syyj5WYYvg05PqNBAE/zcYpCkcy1xd6ESkXha80sLlJsFImQY+pMnnJLqUoWp2+kY9560=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHvmTpg2W8Iylt4lh47crgwqkGlbWirX2+SEA5JVGbeqBDLu+
	rK1kf/OBC8RO/ZCYfN1zIv6W2OK+OeaaPSIrwK95K+xBNU9rNp/0x/c8s5StrxQ=
X-Google-Smtp-Source: AGHT+IH4R12c0MvvS+1j0V71k+RCvRyGrGVh8ZyvaltPwDDqFJcpfPoUNMVP6+Utz2jd321ot8Oihg==
X-Received: by 2002:a05:6300:4043:b0:1d9:3bfd:4a0d with SMTP id adf61e73a8af0-1d9a850b5a5mr15134456637.50.1730243158085;
        Tue, 29 Oct 2024 16:05:58 -0700 (PDT)
Received: from localhost (fwdproxy-prn-024.fbsv.net. [2a03:2880:ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8661098sm8136986a12.8.2024.10.29.16.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:05:57 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
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
Subject: [PATCH v7 00/15] io_uring zero copy rx
Date: Tue, 29 Oct 2024 16:05:03 -0700
Message-ID: <20241029230521.2385749-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

==============
Patch overview
==============

Networking folks would be mostly interested in patches 1-8, 11, 12 and
14. Patches 1-8 make the necessary prerequisite changes in netdev core.

Patch 11 implements struct memory_provider_ops, patch 12 adds a
recv_actor_t func used with tcp_read_sock(), and patch 14 passes it all
to netdev via the queue API.

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
[2]: https://github.com/isilence/linux.git zcrx/v7

liburing for testing:
[3]: https://github.com/isilence/liburing.git zcrx/next

kperf for testing:
[4]: https://git.kernel.dk/kperf.git

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

David Wei (4):
  io_uring/zcrx: add interface queue and refill queue
  io_uring/zcrx: add io_zcrx_area
  io_uring/zcrx: add io_recvzc request
  io_uring/zcrx: set pp memory provider for an rx queue

Jakub Kicinski (1):
  net: page_pool: create hooks for custom page providers

Pavel Begunkov (10):
  net: prefix devmem specific helpers
  net: generalise net_iov chunk owners
  net: prepare for non devmem TCP memory providers
  net: page_pool: add ->scrub mem provider callback
  net: page pool: add helper creating area from pages
  net: page_pool: introduce page_pool_mp_return_in_cache
  net: add helper executing custom callback from napi
  io_uring/zcrx: implement zerocopy receive pp memory provider
  io_uring/zcrx: add copy fallback
  io_uring/zcrx: throttle receive requests

 Kconfig                                 |   2 +
 include/linux/io_uring_types.h          |   3 +
 include/net/busy_poll.h                 |   6 +
 include/net/netmem.h                    |  21 +-
 include/net/page_pool/memory_provider.h |  14 +
 include/net/page_pool/types.h           |  10 +
 include/uapi/linux/io_uring.h           |  54 ++
 io_uring/KConfig                        |  10 +
 io_uring/Makefile                       |   1 +
 io_uring/io_uring.c                     |   7 +
 io_uring/io_uring.h                     |  10 +
 io_uring/memmap.c                       |   8 +
 io_uring/net.c                          |  74 +++
 io_uring/opdef.c                        |  16 +
 io_uring/register.c                     |   7 +
 io_uring/rsrc.c                         |   2 +-
 io_uring/rsrc.h                         |   1 +
 io_uring/zcrx.c                         | 838 ++++++++++++++++++++++++
 io_uring/zcrx.h                         |  76 +++
 net/core/dev.c                          |  81 ++-
 net/core/devmem.c                       |  51 +-
 net/core/devmem.h                       |  45 +-
 net/core/page_pool.c                    | 102 ++-
 net/core/page_pool_user.c               |  15 +-
 net/ipv4/tcp.c                          |   8 +-
 25 files changed, 1388 insertions(+), 74 deletions(-)
 create mode 100644 include/net/page_pool/memory_provider.h
 create mode 100644 io_uring/KConfig
 create mode 100644 io_uring/zcrx.c
 create mode 100644 io_uring/zcrx.h

-- 
2.43.5


