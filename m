Return-Path: <netdev+bounces-212193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07097B1EABA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7711620EB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925827FB10;
	Fri,  8 Aug 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+R3Vqnm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6727E045;
	Fri,  8 Aug 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664814; cv=none; b=p/t93wsKKlSWsXTTRJiX+2L5iNTS/823L2qHQHlNVhfunwdm0czq2Pqw16IPduPO7pEvX3C9+eUFunYHrf8rYkOvd5f6ThM+KejPP+dgG+4vHflg+chVbSRgBtPmtcbHHZdmznmYhJITdWOS7+Tj8kx+6xiAwrcOCVBY7KiF9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664814; c=relaxed/simple;
	bh=ZvkHEOxCOQYBeQws4hYFN5dLr6EqcodX/P0Vq58n4tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3aFxSlFMD2iJBk7PHDWXgMgYMj0VVQBP4bLIQKp5VyKn1HSHtcZa6TengSIfJY27Ac9yOwd745IpsBQpnhlm+p0Ld3VEgwlWi33eXGxgzWopWydkYDkikhqx29b/Xa95g9Mglgk91EKCWFuMCDFofKc2bok9p0wvITxY3L8xXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+R3Vqnm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso21572105e9.2;
        Fri, 08 Aug 2025 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664811; x=1755269611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1HUT9lrN4D6R+nQ5EZMny3o16CfrPsaYFoHNsTBI74=;
        b=A+R3VqnmOC9UWNZ0n63lhaAU7oUFece44LYImJyhjW1eJEqRxv2dUcKNA4KRAhcSD0
         Bs0YexwsahUkruM24NUx+gvkJTZ+hgTyvVfms4xe8Jx6K2clNIIYbA6IqydCmrlF9YCN
         er6QMZQaUwRZXgdQazCql4hJTrHePTMcZuIMG5ui1Met7oHNzJlT3kkjUNDfY487doeE
         zqi2zaNpc1r0CReMdw7jWnyurofJrQ2Kc+tjA+Y8AKRgDWZfHQbKqcBtAyXJV37vA6KT
         5++Dfq+jhdwcS7jTH62Sp7/Ikbmj1OlfktVoajVu+AfegK0doNhBepq3vm4PHBalDhEU
         pBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664811; x=1755269611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1HUT9lrN4D6R+nQ5EZMny3o16CfrPsaYFoHNsTBI74=;
        b=QCtgRAGd8Z2G3a7f2iKmdQ2RUfhfwxAMzz4wB389mdoUvuE9JO4IHhrPHQWZefXZLE
         FAaK18mt+VftLlJd+ym/T5wGIcQMU5PUUVKnmRct++vZHbVUvqdwKXCRnQOxj0diVGTd
         QLwr0liK+EmBXBIziCxcQMHj/MAdZzjeowBeOu29idd/LpmJaiS4I1RM61cdEEnDQAaz
         6UQak3RRdiKtUtUselGmfHjx4GIU3l0oasXXrlykp0jmbPlUjbZ9gGuy5aZA8g3isIXt
         rXpCBB0bTwvFEmduTuLxSfVh0FE04dSTqRhN3dxGFOEyjwhIirACn+tjlIJoOjiPY5QJ
         p9mg==
X-Forwarded-Encrypted: i=1; AJvYcCWLGfe0JNcmnD+vhX5VCU3+DI9kaTApen0hTCOvLukcSi80NupQMy2CEfhgN9BVXKR1Qoa2wK4u@vger.kernel.org, AJvYcCXM951d4eYX/MxfvXEjwVRMr4O3yGpPMMhNmf83qm5iJQtvT02KjOu7GoWAUIid73r6a5/rQDRzhsPfkZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLiH+VkhiCreLIBwsBvtcy9tLsl+WKZ6o6IbxiOi2aKH+iNZ1
	TDnSEtzL5gChdS0/kiP/wZwEWcHhpojKBWPoHFbi1IiyM6+v9TyvV8gA
X-Gm-Gg: ASbGnct4hHfEbi4Gr8Pkuu8Ilmfy/cB9BNmFGqbH/8yrjhopiRwgM2oIKnn4a/LLqb2
	UcGa1YHSX9DWAZ3wESk1Y3LKwf/T2tIZDQPXZpjgZsyYO1KhdDUJYfMEpip6E9WtL2gXLdSLegm
	jPMMr+mzv7+gCZVrrMz81oHYteuchlakaF2meek/bOK1paXNPg6fQlO1KCp1cq2jOAPIYD2nOKv
	+vCUySDMqo3WZV6mWt8TB2ttWlYwHK/2Limyh0guFo/381CviAqFFCpe+ryb3mSaOm36xDunNQ2
	7435bTMbgxRZHX/HDW7PfOiZ24U3IZyjoFppxvYRjytCnJf1XzSVlXFzyW64Ypwvci3xRcxLJLM
	CZLj2PCy2azbJDBd2
X-Google-Smtp-Source: AGHT+IHBHgSFWeKfmMH+01HfZ0GBKCyBkANtPgmia7vr4TlMunD02KCiGBmiUc5l9HDajEIhCKrlTA==
X-Received: by 2002:a05:600c:468b:b0:455:f59e:fdaa with SMTP id 5b1f17b1804b1-459f4f9b7e5mr21913375e9.21.1754664810233;
        Fri, 08 Aug 2025 07:53:30 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:29 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 00/24] Per queue configs and large rx buffer support for zcrx
Date: Fri,  8 Aug 2025 15:54:23 +0100
Message-ID: <cover.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements large rx buffer support for io_uring/zcrx on
top of Jakub's queue configuration changes, but it can also be used
by other memory providers. Large rx buffers can be drastically
beneficial with high-end hw-gro enabled cards that can coalesce traffic
into larger pages, reducing the number of frags traversing the network
stack and resuling in larger contiguous chunks of data for the
userspace. Benchamrks showed up to ~30% improvement in CPU util.

For example, for 200Gbit broadcom NIC, 4K vs 32K buffers, and napi and
userspace pinned to the same CPU:

packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.69    0.00    8.26   31.65    1.83   57.00    0.57

And for napi and userspace on different CPUs:

packets=10725082 (MB=1227388), rps=198285 (MB/s=22692)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.10    0.00    0.50    0.00    0.50   74.50    24.40
  1    4.51    0.00   44.33   47.22    2.08    1.85    0.00
packets=14026235 (MB=1605175), rps=198388 (MB/s=22703)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.10    0.00    0.70    0.00    1.00   43.78   54.42
  1    1.09    0.00   31.95   62.91    1.42    2.63    0.00

Patch 22 allows to pass queue config from a memory provider. Most
of necessary zcrx changes are already queued in a separate branch,
so the zcrx changes are contained in Patch 24 and are fairly
simple. The uAPI is simple and imperative, the buffer length is
passed in the zcrx registration structure, 

Patches 2-21 are taken from Jakub's series with per queue
configuration [1]. Quoting Jakub:

"... The direct motivation for the series is that zero-copy Rx queues would
like to use larger Rx buffers. Most modern high-speed NICs support HW-GRO,
and can coalesce payloads into pages much larger than than the MTU.
Enabling larger buffers globally is a bit precarious as it exposes us
to potentially very inefficient memory use. Also allocating large
buffers may not be easy or cheap under load. Zero-copy queues service
only select traffic and have pre-allocated memory so the concerns don't
apply as much.

The per-queue config has to address 3 problems:
- user API
- driver API
- memory provider API

For user API the main question is whether we expose the config via
ethtool or netdev nl. I picked the latter - via queue GET/SET, rather
than extending the ethtool RINGS_GET API. I worry slightly that queue
GET/SET will turn in a monster like SETLINK. OTOH the only per-queue
settings we have in ethtool which are not going via RINGS_SET is
IRQ coalescing.

My goal for the driver API was to avoid complexity in the drivers.
The queue management API has gained two ops, responsible for preparing
configuration for a given queue, and validating whether the config
is supported. The validating is used both for NIC-wide and per-queue
changes. Queue alloc/start ops have a new "config" argument which
contains the current config for a given queue (we use queue restart
to apply per-queue settings). Outside of queue reset paths drivers
can call netdev_queue_config() which returns the config for an arbitrary
queue. Long story short I anticipate it to be used during ndo_open.

In the core I extended struct netdev_config with per queue settings.
All in all this isn't too far from what was there in my "queue API
prototype" a few years ago ..."

Kernel branch with all dependencies: 
git: https://github.com/isilence/linux.git zcrx/large-buffers-v2
url: https://github.com/isilence/linux/tree/zcrx/large-buffers-v2

Per queue configuration series:
[1] https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/

v2: - Add MAX_PAGE_ORDER check on pp init (Patch 1)
    - Applied comments rewording (Patch 2)
    - Adjust pp.max_len based on order (Patch 8)
    - Patch up mlx5 queue callbacks after rebase (Patch 12)
    - Minor ->queue_mgmt_ops refactoring (Patch 15)
    - Rebased to account for both fill level and agg_size_fac (Patch 17)
    - Pass providers buf length in struct pp_memory_provider_params and
      apply it in __netdev_queue_confi(). (Patch 22)
    - Use ->supported_ring_params to validate drivers support of set
      qcfg parameters. (Patch 23)

Jakub Kicinski (20):
  docs: ethtool: document that rx_buf_len must control payload lengths
  net: ethtool: report max value for rx-buf-len
  net: use zero value to restore rx_buf_len to default
  net: clarify the meaning of netdev_config members
  net: add rx_buf_len to netdev config
  eth: bnxt: read the page size from the adapter struct
  eth: bnxt: set page pool page order based on rx_page_size
  eth: bnxt: support setting size of agg buffers via ethtool
  net: move netdev_config manipulation to dedicated helpers
  net: reduce indent of struct netdev_queue_mgmt_ops members
  net: allocate per-queue config structs and pass them thru the queue
    API
  net: pass extack to netdev_rx_queue_restart()
  net: add queue config validation callback
  eth: bnxt: always set the queue mgmt ops
  eth: bnxt: store the rx buf size per queue
  eth: bnxt: adjust the fill level of agg queues with larger buffers
  netdev: add support for setting rx-buf-len per queue
  net: wipe the setting of deactived queues
  eth: bnxt: use queue op config validate
  eth: bnxt: support per queue configuration of rx-buf-len

Pavel Begunkov (4):
  net: page_pool: sanitise allocation order
  net: let pp memory provider to specify rx buf len
  net: validate driver supports passed qcfg params
  io_uring/zcrx: implement large rx buffer support

 Documentation/netlink/specs/ethtool.yaml      |   4 +
 Documentation/netlink/specs/netdev.yaml       |  15 ++
 Documentation/networking/ethtool-netlink.rst  |   7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 142 +++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   5 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   9 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   9 +-
 drivers/net/netdevsim/netdev.c                |   8 +-
 include/linux/ethtool.h                       |   3 +
 include/net/netdev_queues.h                   |  84 ++++++--
 include/net/netdev_rx_queue.h                 |   3 +-
 include/net/netlink.h                         |  19 ++
 include/net/page_pool/types.h                 |   1 +
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 include/uapi/linux/io_uring.h                 |   2 +-
 include/uapi/linux/netdev.h                   |   2 +
 io_uring/zcrx.c                               |  36 +++-
 net/core/Makefile                             |   2 +-
 net/core/dev.c                                |  12 +-
 net/core/dev.h                                |  15 ++
 net/core/netdev-genl-gen.c                    |  15 ++
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  92 +++++++++
 net/core/netdev_config.c                      | 183 ++++++++++++++++++
 net/core/netdev_rx_queue.c                    |  22 ++-
 net/core/page_pool.c                          |   3 +
 net/ethtool/common.c                          |   4 +-
 net/ethtool/netlink.c                         |  14 +-
 net/ethtool/rings.c                           |  14 +-
 tools/include/uapi/linux/netdev.h             |   2 +
 34 files changed, 662 insertions(+), 90 deletions(-)
 create mode 100644 net/core/netdev_config.c

-- 
2.49.0


