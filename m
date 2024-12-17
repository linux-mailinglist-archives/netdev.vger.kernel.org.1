Return-Path: <netdev+bounces-152704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A59F575F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E061891DBA
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4115F14600D;
	Tue, 17 Dec 2024 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ng7MEfjH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B261F6671
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466330; cv=none; b=PN1IszYpJcxzmLfrrD83nTr8XKDHQ89QdwVM6a6dR0L0LQrFjOwAvV/ZJYYjy/bDqU+S82wKsD9CUjLkkJ6Wnp4HoS5/rO8bFi81arUwRjUb2c/Vk9S5zjgU6+cFceR7nuyIcIiWfSHdHVLIJcsZji6hsJKsfe6DEuSkH7hoLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466330; c=relaxed/simple;
	bh=pVImGNEmG/zX77a+vhzi+si5GDL8xTOF4zHCM6KYXyM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TVqVCaMUuL2Qhi19KP2G9JUIa631tH15N+kdRLM/rGACHZglRmRVIAhuSceObt9ALM2XLowdVc4OPVa/7UIi6YQDDRldIkseXwhmxGwSaHXr7WLePUQBZ60LXEkV5TKau3zc8pk1iMa/OB6nF/bBvMYjl2xWPYZS1cwWer5KA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ng7MEfjH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso5378188a91.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734466328; x=1735071128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7CI+KsjLDAbysY8RsQOlNWjMrZ9ZlwbSEe2N6sprvE=;
        b=ng7MEfjH0oSBi72ygWvouldAuy8iUY0x6KB5iS0dZi25HgOfR2vO2HaONKYkjl6cy3
         6C8dcZpxvDY5wJe4+HZyNSGEvKlDsDo+RZUsbOnRF8psusFKP68vn90TAE/cnNkVCCgj
         G6Nc0B9p/2kHRNMdlbxHM1OT+OLYq/U1hXxxQNxhKrVh/0lY/1ZUIYpswvONDQ+xC1aV
         NVoXZGr8g7HWEWNk6kbt0bGxAxerwgfWQ3U2POJh+Bs+YYm0wclldvMv45p2QVGrIAc/
         jEjKWNrYMTk1x6mcpPiB3JAbcnxidFRZUPkncdJbaJTiA2XD4x087A7mX3rTtwNizINp
         LjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734466328; x=1735071128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7CI+KsjLDAbysY8RsQOlNWjMrZ9ZlwbSEe2N6sprvE=;
        b=CD8wHJ28M0OYBewquoa2mT+tMPWGuemah3Re7TA8soY5zMOxc0F1mk/qDz+CKatYBR
         m3IJ1j+7dvdJAPpanyZ1Lxl+d9fAIpCpIu+W11rcjwTS3tQk3HCPGq1hyV8riS8s0wQP
         GUDnMt8/xECNuI4D/HAg8xBzxy4Ky/H0CahYq9TF8WWvYurnulEWDY0SqcLQF+7AI95o
         ukRin5GlN4I5Am5niR1r+GqtyFKzvy9DX49YFb61koFAnjvxrBl6HlsnN4zs2Gcifr7S
         urN93mbZnCLFSyZujEgRn2c1WOBmL4b/YnTQcVXoQ/WqHsVIiWRCQPTxZK3OtrzvaqIr
         asBg==
X-Gm-Message-State: AOJu0YzIyAznk2t5sAMyJM3z+r+Xa6x98ClIV5HxlWckQVsN3m8vuFU9
	3v0a/117c8kolZeGUkzqBYBmy2bbfQKsvy39VOjNQZ5jPr2zb2hJu143NlghkKm6RY9GlUJvlap
	16poTkkDgJ5NRyX0mf+NhdWkGNumlqZ/IZ33GVGX/99vppmRdGiKjTApFoa9upXTUMl9nfU2r0W
	jWvSposLa6VxopBwcgazBCI9Fm8PqXfk+XcB/8FV82J5Z7IMNuOwVlfdCRmog=
X-Google-Smtp-Source: AGHT+IFsiV1/4XtIWEL3oEqqXsvoAtV5761RQFgsgkc/U1ZC9rkOBZSzJ+H2Zb6WjBufhYhAwO1A6CIR7ORB52npuQ==
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:2ea:5469:76c2])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:51c4:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2f2e91a9815mr307291a91.6.1734466327882;
 Tue, 17 Dec 2024 12:12:07 -0800 (PST)
Date: Tue, 17 Dec 2024 20:12:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217201206.2360389-1-almasrymina@google.com>
Subject: [PATCH net-next v5] net: Document netmem driver support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"

Document expectations from drivers looking to add support for device
memory tcp or other netmem based features.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v5 (forked from the merged series):
- Describe benefits of netmem (Shannon).
- Specify that netmem is for payload pages (Jakub).
- Clarify what  recycling the driver can do (Jakub).
- Clarify why the driver needs to use DMA_SYNC and DMA_MAP pp flags
  (Shannon).

v4:
- Address comments from Randy.
- Change docs to netmem focus (Jakub).
- Address comments from Jakub.

---
 Documentation/networking/index.rst  |  1 +
 Documentation/networking/netmem.rst | 79 +++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/networking/netmem.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 46c178e564b3..058193ed2eeb 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -86,6 +86,7 @@ Contents:
    netdevices
    netfilter-sysctl
    netif-msg
+   netmem
    nexthop-group-resilient
    nf_conntrack-sysctl
    nf_flowtable
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
new file mode 100644
index 000000000000..7de21ddb5412
--- /dev/null
+++ b/Documentation/networking/netmem.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Netmem Support for Network Drivers
+==================================
+
+This document outlines the requirements for network drivers to support netmem,
+an abstract memory type that enables features like device memory TCP. By
+supporting netmem, drivers can work with various underlying memory types
+with little to no modification.
+
+Benefits of Netmem :
+
+* Flexibility: Netmem can be backed by different memory types (e.g., struct
+  page, DMA-buf), allowing drivers to support various use cases such as device
+  memory TCP.
+* Future-proof: Drivers with netmem support are ready for upcoming
+  features that rely on it.
+* Simplified Development: Drivers interact with a consistent API,
+  regardless of the underlying memory implementation.
+
+Driver Requirements
+===================
+
+1. The driver must support page_pool.
+
+2. The driver must support the tcp-data-split ethtool option.
+
+3. The driver must use the page_pool netmem APIs for payload memory. The netmem
+   APIs currently 1-to-1 correspond with page APIs. Conversion to netmem should
+   be achievable by switching the page APIs to netmem APIs and tracking memory
+   via netmem_refs in the driver rather than struct page * :
+
+   - page_pool_alloc -> page_pool_alloc_netmem
+   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
+   - page_pool_put_page -> page_pool_put_netmem
+
+   Not all page APIs have netmem equivalents at the moment. If your driver
+   relies on a missing netmem API, feel free to add and propose to netdev@, or
+   reach out to the maintainers and/or almasrymina@google.com for help adding
+   the netmem API.
+
+4. The driver must use the following PP_FLAGS:
+
+   - PP_FLAG_DMA_MAP: netmem is not dma-mappable by the driver. The driver
+     must delegate the dma mapping to the page_pool, which knows when
+     dma-mapping is (or is not) appropriate.
+   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
+     by the driver. The driver must delegate the dma syncing to the page_pool,
+     which knows when dma-syncing is (or is not) appropriate.
+   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
+     tcp-data-split is enabled.
+
+5. The driver must not assume the netmem is readable and/or backed by pages.
+   The netmem returned by the page_pool may be unreadable, in which case
+   netmem_address() will return NULL. The driver must correctly handle
+   unreadable netmem, i.e. don't attempt to handle its contents when
+   netmem_address() is NULL.
+
+   Ideally, drivers should not have to check the underlying netmem type via
+   helpers like netmem_is_net_iov() or convert the netmem to any of its
+   underlying types via netmem_to_page() or netmem_to_net_iov(). In most cases,
+   netmem or page_pool helpers that abstract this complexity are provided
+   (and more can be added).
+
+6. The driver must use page_pool_dma_sync_netmem_for_cpu() in lieu of
+   dma_sync_single_range_for_cpu(). For some memory providers, dma_syncing for
+   CPU will be done by the page_pool, for others (particularly dmabuf memory
+   provider), dma syncing for CPU is the responsibility of the userspace using
+   dmabuf APIs. The driver must delegate the entire dma-syncing operation to
+   the page_pool which will do it correctly.
+
+7. Avoid implementing driver-specific recycling on top of the page_pool. Drivers
+   cannot hold onto a struct page to do their own recycling as the netmem may
+   not be backed by a struct page. However, you may hold onto a page_pool
+   reference with page_pool_fragment_netmem() or page_pool_ref_netmem() for
+   that purpose, but be mindful that some netmem types might have longer
+   circulation times, such as when userspace holds a reference in zerocopy
+   scenarios.
-- 
2.47.1.613.gc27f4b7a9f-goog


