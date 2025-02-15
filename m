Return-Path: <netdev+bounces-166626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B727FA369A3
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41486189842F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7A1624FD;
	Sat, 15 Feb 2025 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="sCXWpXYC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3F2943F
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578213; cv=none; b=h9o2Kz4pXFsVRKAI2KNdP8fxwyVoDC9TZDvOrnNBM/qp92GViZzE7qFGxBNpwUJwadyVmIZ/PFBjh0HV8W4EqSbyZtwwNgjMurmto1S4UytaqvdP6BPYOs5VKMb8wZkvnOuS+SsfFuOUTQTVeTmtbPzBjzLZHpuqTcbvDvOp9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578213; c=relaxed/simple;
	bh=9pTdmByBVpWL3oRo72V1P/Qnfm3p1w1EAQ8TvZwzW4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsPyNLXBBWAsiBwSG0vFjvMpj+4CRbkKFV7PQSmS5YBY25XRy/prY01Yx4n7CiNfHhW+Wo5aNZwreloWosdtJuQuJeI353PP7jYyF0wpg0EJqu/ch0Bum6bqxt5KqKmSVKQ/OaRg5HkHq7DVJqQRj5GJlFatIgkpJYNwDwioTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=sCXWpXYC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c92c857aso42490435ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 16:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1739578211; x=1740183011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHWoGsRhiFc/ooKo3TvF3R3d8ADOTW+DffRpnDLhJ48=;
        b=sCXWpXYCkPr4AIgT85SWKKDZgQpmOYI1AlUlPutZhDv9ApQnXaa2Z2BwJBMPMv19KC
         EaLI1lDprh7TUTYfByVEtSgDwxKWvyfywAibiWDyBwplB3CUpsHTPZT78ncgxkZ8nXHv
         Q7zpkAZ3gKvGFBj5EMHX8Ft+n8sHvCDMuUMe8/2hHRlSRExtqqepa1ZAjpIQCekbrE5L
         n/N2g3NctFgTy59DeQhWGiEQ8PHN5DKkgT54mEjSHuy1KkLLOwnsRQlvYP30gi6/cpWb
         K17YE/wTgwJGV9xtXcmj5jtM1tSABWZ46wRWaf+ikX4Ym5VOFUDSwJDLA1KliDwqW+Ek
         tBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578211; x=1740183011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHWoGsRhiFc/ooKo3TvF3R3d8ADOTW+DffRpnDLhJ48=;
        b=PqezGmv3K4GYVzzN9jnI2ShKiYp3XA5GSZ6tEorKpugyHjpbrZNduGm4sZ+ex493bR
         Rgl/Voc3JDxBkTmUTnmnkoP02yym1ueNyZ6EqY9WAmThrDQ501Vk8WRvoQHjhk+OMaB5
         cme2gcGOnIw6t4101GGeRgVsGoXCkuIzpM6XsKLYASh3uWuh3Q+082fq7XDQ8PO3iM8T
         di2pBCYBny3MKJ0sHmeG5A8IYkl8j30Gf1HW5j/ROUqfjrbpsiZ7Poul2uCa4Jw97CVv
         p45mbOuY/klyNNqQut4PgcJE+0AWHFACRLeGvxqgaEFyI0KLSKJ5A4SfuMzJ87J666Fz
         fTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmbPvEeXnQWwE/dMxOkDNx57jQK/Da3cNYfaDAa8NVXzv2oonlPTHTeFNJBJsOqpptaTsU45Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SNXCtHlWNxooLLubJtwxCmL2tTg42Q7BSGFuRLg8aP/S5vNb
	JOQyAixQykuEY9lT0Re2ZVuz1L0h7AdL/eBofzJFhuCpU8rFTs+rDcTo++Qd/iA=
X-Gm-Gg: ASbGnctZMQtKSW8hOshkmkY22l1Xwr4nXmkp/NDQp24QfIkkrf1ZXZfM79HJbh2gRpi
	isITZa1vUFv1ts6q8jTzpc9Y35bdVLHh0k6FtK1QshxD8MgBzPDVHr8nA3ry9hOjM62DyIbSPwq
	otbY7A4SPDszzyUoaH+zbyY0ImGp672nlbbR28epEZcD2OI0RCrhOmzXLAMGzfoSv/NfmwZyOJs
	LglpcmYOzXv+0iZa2b7+9jqmJumq2AtDMOoJQ/uqzhKgXYDq6rBD752knTa6fljzjQrdziWH9FI
X-Google-Smtp-Source: AGHT+IGB+0BtJEKjVmh9epCDeysVRSF5mdDq27M8L2mrfMjVlA01YXkfPFySEiuWNB9RVj09mjVQCA==
X-Received: by 2002:a17:903:94d:b0:21f:ba77:c49a with SMTP id d9443c01a7336-220d33a50a3mr143708735ad.4.1739578211445;
        Fri, 14 Feb 2025 16:10:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d473sm34116265ad.166.2025.02.14.16.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:10:11 -0800 (PST)
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
	Pedro Tammela <pctammela@mojatatu.com>,
	lizetao <lizetao1@huawei.com>
Subject: [PATCH v14 10/11] net: add documentation for io_uring zcrx
Date: Fri, 14 Feb 2025 16:09:45 -0800
Message-ID: <20250215000947.789731-11-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250215000947.789731-1-dw@davidwei.uk>
References: <20250215000947.789731-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for io_uring zero copy Rx that explains requirements
and the user API.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 Documentation/networking/index.rst    |   1 +
 Documentation/networking/iou-zcrx.rst | 202 ++++++++++++++++++++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 Documentation/networking/iou-zcrx.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 058193ed2eeb..c64133d309bf 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -63,6 +63,7 @@ Contents:
    gtp
    ila
    ioam6-sysctl
+   iou-zcrx
    ip_dynaddr
    ipsec
    ip-sysctl
diff --git a/Documentation/networking/iou-zcrx.rst b/Documentation/networking/iou-zcrx.rst
new file mode 100644
index 000000000000..0127319b30bb
--- /dev/null
+++ b/Documentation/networking/iou-zcrx.rst
@@ -0,0 +1,202 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+io_uring zero copy Rx
+=====================
+
+Introduction
+============
+
+io_uring zero copy Rx (ZC Rx) is a feature that removes kernel-to-user copy on
+the network receive path, allowing packet data to be received directly into
+userspace memory. This feature is different to TCP_ZEROCOPY_RECEIVE in that
+there are no strict alignment requirements and no need to mmap()/munmap().
+Compared to kernel bypass solutions such as e.g. DPDK, the packet headers are
+processed by the kernel TCP stack as normal.
+
+NIC HW Requirements
+===================
+
+Several NIC HW features are required for io_uring ZC Rx to work. For now the
+kernel API does not configure the NIC and it must be done by the user.
+
+Header/data split
+-----------------
+
+Required to split packets at the L4 boundary into a header and a payload.
+Headers are received into kernel memory as normal and processed by the TCP
+stack as normal. Payloads are received into userspace memory directly.
+
+Flow steering
+-------------
+
+Specific HW Rx queues are configured for this feature, but modern NICs
+typically distribute flows across all HW Rx queues. Flow steering is required
+to ensure that only desired flows are directed towards HW queues that are
+configured for io_uring ZC Rx.
+
+RSS
+---
+
+In addition to flow steering above, RSS is required to steer all other non-zero
+copy flows away from queues that are configured for io_uring ZC Rx.
+
+Usage
+=====
+
+Setup NIC
+---------
+
+Must be done out of band for now.
+
+Ensure there are at least two queues::
+
+  ethtool -L eth0 combined 2
+
+Enable header/data split::
+
+  ethtool -G eth0 tcp-data-split on
+
+Carve out half of the HW Rx queues for zero copy using RSS::
+
+  ethtool -X eth0 equal 1
+
+Set up flow steering, bearing in mind that queues are 0-indexed::
+
+  ethtool -N eth0 flow-type tcp6 ... action 1
+
+Setup io_uring
+--------------
+
+This section describes the low level io_uring kernel API. Please refer to
+liburing documentation for how to use the higher level API.
+
+Create an io_uring instance with the following required setup flags::
+
+  IORING_SETUP_SINGLE_ISSUER
+  IORING_SETUP_DEFER_TASKRUN
+  IORING_SETUP_CQE32
+
+Create memory area
+------------------
+
+Allocate userspace memory area for receiving zero copy data::
+
+  void *area_ptr = mmap(NULL, area_size,
+                        PROT_READ | PROT_WRITE,
+                        MAP_ANONYMOUS | MAP_PRIVATE,
+                        0, 0);
+
+Create refill ring
+------------------
+
+Allocate memory for a shared ringbuf used for returning consumed buffers::
+
+  void *ring_ptr = mmap(NULL, ring_size,
+                        PROT_READ | PROT_WRITE,
+                        MAP_ANONYMOUS | MAP_PRIVATE,
+                        0, 0);
+
+This refill ring consists of some space for the header, followed by an array of
+``struct io_uring_zcrx_rqe``::
+
+  size_t rq_entries = 4096;
+  size_t ring_size = rq_entries * sizeof(struct io_uring_zcrx_rqe) + PAGE_SIZE;
+  /* align to page size */
+  ring_size = (ring_size + (PAGE_SIZE - 1)) & ~(PAGE_SIZE - 1);
+
+Register ZC Rx
+--------------
+
+Fill in registration structs::
+
+  struct io_uring_zcrx_area_reg area_reg = {
+    .addr = (__u64)(unsigned long)area_ptr,
+    .len = area_size,
+    .flags = 0,
+  };
+
+  struct io_uring_region_desc region_reg = {
+    .user_addr = (__u64)(unsigned long)ring_ptr,
+    .size = ring_size,
+    .flags = IORING_MEM_REGION_TYPE_USER,
+  };
+
+  struct io_uring_zcrx_ifq_reg reg = {
+    .if_idx = if_nametoindex("eth0"),
+    /* this is the HW queue with desired flow steered into it */
+    .if_rxq = 1,
+    .rq_entries = rq_entries,
+    .area_ptr = (__u64)(unsigned long)&area_reg,
+    .region_ptr = (__u64)(unsigned long)&region_reg,
+  };
+
+Register with kernel::
+
+  io_uring_register_ifq(ring, &reg);
+
+Map refill ring
+---------------
+
+The kernel fills in fields for the refill ring in the registration ``struct
+io_uring_zcrx_ifq_reg``. Map it into userspace::
+
+  struct io_uring_zcrx_rq refill_ring;
+
+  refill_ring.khead = (unsigned *)((char *)ring_ptr + reg.offsets.head);
+  refill_ring.khead = (unsigned *)((char *)ring_ptr + reg.offsets.tail);
+  refill_ring.rqes =
+    (struct io_uring_zcrx_rqe *)((char *)ring_ptr + reg.offsets.rqes);
+  refill_ring.rq_tail = 0;
+  refill_ring.ring_ptr = ring_ptr;
+
+Receiving data
+--------------
+
+Prepare a zero copy recv request::
+
+  struct io_uring_sqe *sqe;
+
+  sqe = io_uring_get_sqe(ring);
+  io_uring_prep_rw(IORING_OP_RECV_ZC, sqe, fd, NULL, 0, 0);
+  sqe->ioprio |= IORING_RECV_MULTISHOT;
+
+Now, submit and wait::
+
+  io_uring_submit_and_wait(ring, 1);
+
+Finally, process completions::
+
+  struct io_uring_cqe *cqe;
+  unsigned int count = 0;
+  unsigned int head;
+
+  io_uring_for_each_cqe(ring, head, cqe) {
+    struct io_uring_zcrx_cqe *rcqe = (struct io_uring_zcrx_cqe *)(cqe + 1);
+
+    unsigned long mask = (1ULL << IORING_ZCRX_AREA_SHIFT) - 1;
+    unsigned char *data = area_ptr + (rcqe->off & mask);
+    /* do something with the data */
+
+    count++;
+  }
+  io_uring_cq_advance(ring, count);
+
+Recycling buffers
+-----------------
+
+Return buffers back to the kernel to be used again::
+
+  struct io_uring_zcrx_rqe *rqe;
+  unsigned mask = refill_ring.ring_entries - 1;
+  rqe = &refill_ring.rqes[refill_ring.rq_tail & mask];
+
+  unsigned long area_offset = rcqe->off & ~IORING_ZCRX_AREA_MASK;
+  rqe->off = area_offset | area_reg.rq_area_token;
+  rqe->len = cqe->res;
+  IO_URING_WRITE_ONCE(*refill_ring.ktail, ++refill_ring.rq_tail);
+
+Testing
+=======
+
+See ``tools/testing/selftests/drivers/net/hw/iou-zcrx.c``
-- 
2.43.5


