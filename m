Return-Path: <netdev+bounces-248495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C251D0A31C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B3073021E6E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCFA35BDA7;
	Fri,  9 Jan 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuVcdLLF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB535BDA5
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963975; cv=none; b=KxpKHRXVM1NPZUzRoh9KAqokrJ+zw6Ubm5INCgEUBIjlbhRDEkESsWaZQV6jflBaMyzsh1tta7Dl8PTyhoVRJceSGLlLZHofVXufHXu6IiSmLOiiuKgY6Q/olo4DIlDB9XGiKjEChKh/EBDdMQ6KFEECJ+3QyK0J7wm9kwE5OLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963975; c=relaxed/simple;
	bh=ME5RwYYeXnXNLbQ/Bkl/rSm+h34n/XlbEQhFl4FNSPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bH98Px8K4It7lEwQ4b3iBEd9He9INkCkSl/b8VV2YVxKYuBEDhB9AKQ3WtRK/tJtq+DnlojhxZ+8LC4rt1Llc+R1N6nzGd7s8GtITNtgdLtKJzRTrH4hpHxuO5bvJjKNNrDDiY2lbCanjrqjXg4DVGylpm/Ts/3PdzVDMMO7De4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuVcdLLF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64fabaf9133so7479192a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963973; x=1768568773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQi3F9taD578uKhb5WeGr8+LqFJi+cgMU9mJCgFH+JI=;
        b=RuVcdLLFWX0DbUjmxtERB4CBLBnP6RubT19y9HUxnKtPdRF6hzOqG4V60a9mFWCbDb
         RpD7bLl1h6PTB7L0jm8qGlmbAvLXg5aLTlqo2kP4/rJWeRLtMrOvMXyEtEOiDTj4bGIw
         I8IrUsaoKtJEKf1sxgSbftZdD1zTwa85THehjgQ6uAfhuzPHPBRVn+QMy15coZ9tkbTf
         LhMeAbUhhKxLZeB3grtemTIgNwIREl7rywJkux8mTVtKmTirUOnjORkrNHID4tm7LdHa
         eHkdHvjw02y/BkPhIFGcgC3BOoRlzGaBDPMqt2DFTsezyngQ6w4qTbWWARAUXLOCqlf0
         h1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963973; x=1768568773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQi3F9taD578uKhb5WeGr8+LqFJi+cgMU9mJCgFH+JI=;
        b=EH8aYbVHJblR9S2EAZnbeOOPMzchpnWQ4xylhOiKUCbr0gvOe9AvlzSOExL4gQNY/X
         Gi9C6galFLyakVTZqhLpKNzQOY2156ZABcYOAHaZOWRiiYohMn9rbjB6NA0zqSpQ5Oio
         qUhFyas8CajAa/vhW9mVAJNRizw6DZtBrhJQIWprPhmkCeuz8KXuDxarlF9Osg4MctMv
         1UWBYdREfwzos70tCUZQ99A/bjwdWAktGfjtd0O4LvGwP2Uxmep5KTD7x3h7gVoJD4JU
         WrbhezV7coq15P4759tk/3PrXfUJEgZ2RA5n0a9GqaNJDtI6haKOTr5qUVJIL6aB6O64
         N8Fg==
X-Gm-Message-State: AOJu0Yx0nlvg4z7rM77XzFAnBf7lXlqgqonHbxO/2LvBdowC+bhg3yVP
	r/n+Aexmxb0tUPFRZvJaFlH2fBVpk8J0hEqkBo+f/f77GfvSxc1dgSTK/EkxfA==
X-Gm-Gg: AY/fxX7eshcpFddCR3smKNVx40bT0WbqB0M5I1UKOPXOWVNlp1P/2kjL1sxM8uwLLty
	vQcYXFYAQ8EEkOH4wlbPRgCEq2i4dJ7gRx8W4DMCWXMTFUmvWUSybn6IE+xMZv2VJ4srUHrnEq4
	KW/KxSV6ahvz4L5ydJ+FiqHZ6WdSJXfGwInmQA6iRAa9UccdRaaLyougwbxlSTUIDybSK5GhohI
	Ab71HB5JwT7WNAkVZ8p+pi/KUiqM2ExztD0FqFYWYCme427MKmdbKEadvHrXsL5XAKmLbV03jbi
	FNG6c6LG31A3OyUSzNvovOQSPNxJOgDzHNt1ay8u5RyKSRg6UGPIo3jJECOYj/7nGOBYNmF4p31
	k4RyOrCgBLleSm1uETf6o4G4jkNTmZ4d8nifAg9z8K3KhI6wW6Ae92RW8cN3IWwXzS8DWDd3k9u
	6wv4CBbQuvbLmmexOTXezji/c3dGOcnv8PGmN6COgg/y25hC/odiy4TKBwbmBkC1HcXY3bGQ==
X-Google-Smtp-Source: AGHT+IHEu00dTqymHYnWX3YB9+V+M0g0pVj0f65C6gXQXrOLC70cW7LkbUbrjcu3dFBefYWTWksRNQ==
X-Received: by 2002:a05:600c:4fc6:b0:477:a21c:2066 with SMTP id 5b1f17b1804b1-47d84b0a902mr94022565e9.5.1767958133975;
        Fri, 09 Jan 2026 03:28:53 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:28:52 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 0/9] Add support for providers with large rx buffer
Date: Fri,  9 Jan 2026 11:28:39 +0000
Message-ID: <cover.1767819709.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: it's net/ only bits and doesn't include changes, which shoulf be
merged separately and are posted separately. The full branch for
convenience is at [1], and the patch is here:

https://lore.kernel.org/io-uring/7486ab32e99be1f614b3ef8d0e9bc77015b173f7.1764265323.git.asml.silence@gmail.com

Many modern NICs support configurable receive buffer lengths, and zcrx and
memory providers can use buffers larger than 4K to improve performance. When
paired with hw-gro larger rx buffer sizes can drastically reduce the number
of buffers traversing the stack and save a lot of processing time. It also
allows to give to users larger contiguous chunks of data. The idea was first
floated around by Saeed during netdev conf 2024 and was asked about by a few
folks.

Single stream benchmarks showed up to ~30% CPU util improvement.
E.g. comparison for 4K vs 32K buffers using a 200Gbit NIC:

packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.69    0.00    8.26   31.65    1.83   57.00    0.57

This series adds net infrastructure for memory providers configuring
the size and implements it for bnxt. It's an opt-in feature for drivers,
they should advertise support for the parameter in the qops and must check
if the hardware supports the given size. It's limited to memory providers
as it drastically simplifies implementation. It doesn't affect the fast
path zcrx uAPI, and the user exposed parameter is defined in zcrx terms,
which allows it to be flexible and adjusted in the future.

A liburing example can be found at [2]

full branch:
[1] https://github.com/isilence/linux.git zcrx/large-buffers-v8
Liburing example:
[2] https://github.com/isilence/liburing.git zcrx/rx-buf-len

---

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  https://github.com/isilence/linux.git tags/net-queue-rx-buf-len-v8

for you to fetch changes up to 37f5abe6929963fc6086777056b59ecb034d0e19:

  io_uring/zcrx: document area chunking parameter (2026-01-08 11:35:20 +0000)


v8: - Add stripped down qcfg
    - Retain the page size across resets for bnxt

v7: - Add xa_destroy
    - Rebase

v6: - Update docs and add a selftest

v5: https://lore.kernel.org/netdev/cover.1760440268.git.asml.silence@gmail.com/
    - Remove all unnecessary bits like configuration via netlink, and
      multi-stage queue configuration.

v4: https://lore.kernel.org/all/cover.1760364551.git.asml.silence@gmail.com/
    - Update fbnic qops
    - Propagate max buf len for hns3
    - Use configured buf size in __bnxt_alloc_rx_netmem
    - Minor stylistic changes
v3: https://lore.kernel.org/all/cover.1755499375.git.asml.silence@gmail.com/
    - Rebased, excluded zcrx specific patches
    - Set agg_size_fac to 1 on warning
v2: https://lore.kernel.org/all/cover.1754657711.git.asml.silence@gmail.com/
    - Add MAX_PAGE_ORDER check on pp init
    - Applied comments rewording
    - Adjust pp.max_len based on order
    - Patch up mlx5 queue callbacks after rebase
    - Minor ->queue_mgmt_ops refactoring
    - Rebased to account for both fill level and agg_size_fac
    - Pass providers buf length in struct pp_memory_provider_params and
      apply it in __netdev_queue_confi().
    - Use ->supported_ring_params to validate drivers support of set
      qcfg parameters.

Jakub Kicinski (2):
  net: reduce indent of struct netdev_queue_mgmt_ops members
  eth: bnxt: adjust the fill level of agg queues with larger buffers

Pavel Begunkov (7):
  net: memzero mp params when closing a queue
  net: add bare bone queue configs
  net: pass queue rx page size from memory provider
  eth: bnxt: store rx buffer size per queue
  eth: bnxt: support qcfg provided rx page size
  selftests: iou-zcrx: test large chunk sizes
  io_uring/zcrx: document area chunking parameter

 Documentation/networking/iou-zcrx.rst         |  20 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 126 ++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |   8 +-
 drivers/net/netdevsim/netdev.c                |   7 +-
 include/net/netdev_queues.h                   |  47 +++++--
 include/net/netdev_rx_queue.h                 |   2 +
 include/net/page_pool/types.h                 |   1 +
 net/core/dev.c                                |  17 +++
 net/core/netdev_rx_queue.c                    |  31 +++--
 .../selftests/drivers/net/hw/iou-zcrx.c       |  72 ++++++++--
 .../selftests/drivers/net/hw/iou-zcrx.py      |  37 +++++
 16 files changed, 318 insertions(+), 79 deletions(-)

-- 
2.52.0


