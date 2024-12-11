Return-Path: <netdev+bounces-151215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BA9ED86F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453B71888D6C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340691F2C40;
	Wed, 11 Dec 2024 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmqoNzRw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2F1EC4C0
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952045; cv=none; b=dLDonbvsRlsuOYL7iz4/UqEjCC8bS6Ny7U7rdlY0jLAG+GwKPdIGApwfPsAHjggPqsZ1vRgdzPZnN+TDgjj0JbiORDHmbNqnccghZoADEf5DiRvPIMnM4r0eWxpDuCHPjKcx/UT3db81exzuMp6WRpFwqdlQML5dm8wambpoZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952045; c=relaxed/simple;
	bh=9BNoKvvCDKbyXYRvGcmAgiOTx+VjuHH2W8Or3dRTMpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mVg7M4zQl0kIbmSBapaHyYwrd9bJvXiUBXaOZIhaZ8O5EeqLdt1wVz4WCh4LZH2pxEMPr9jV1umazzMmDNJ8dUxbO+8g+E/JJPVoR8xaLfxq+k+zU+ypqDjf7OVCTH7CBuuiKlRYyD2aBPUP6njOHtpV7mjVWahl3Dz8Hdm3uU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmqoNzRw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso3853015a91.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733952043; x=1734556843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=745mn/S2xe1Z43WeSOTvQvgzJ70pexQD0FqzrefhnYc=;
        b=CmqoNzRwnz58z4wKlWaK9VJkxia4k9usxdlLwfnj89aTSmvyfW6pbOXhjN6AgsT8dZ
         UDeNxuHPP5ykljoCbTmFcRC+aCWsVJYaQH/RHJZuqVPKgw7J0GmbJ1sZc37COOMZf5r2
         Q0ZrmcBDCgmXdjd7SU+N2yG1DFtowAH6IkwD20Gs+Wuiuky+8kKBXB7awyhDVqGSfwJo
         BjcOUoR2zVqCXEgJaDDw8a+cfTLgraLyMTqsSJfBtSEFcq2Rwb2JqlFCBSJZbjsw9Ejr
         jZ8bSQu0rYTqgKQVM7S0t0DjhmGJrsycFOTHpHOq4/DUKJnhjaInb28ywKZO8nTPpo+x
         VHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952043; x=1734556843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=745mn/S2xe1Z43WeSOTvQvgzJ70pexQD0FqzrefhnYc=;
        b=cR1HXS9B8PZJrfPmJ5vWpdv2XvCKRNn5SIngbLy4tM63/L+LIcplyytXq2i7GLlIgu
         TF/W/CVb5+AkIDuHh96RS3t2YvzHILQr3hoC7qeKrez03MnLFOK5RGC0EWA/qbR9686H
         5HBRLtM+aVpY32hwo4MiOzKHdJHPPFdt5mTqgE5ziphciNo1UnuVIDXC9SSxQXR8Itfj
         +olzdtSmxYuf4LG6O0UU+FcQChkUTyYcoZtetDigFfyzOAXvL2OFVbHE9F0ToMoolKsd
         aQYaRRwxXEoBBR69kywzH+eD3FEeDHGMKiumk/HmsR/fdXVRGcRg/pzVHZrJML1Mfh07
         /+6g==
X-Gm-Message-State: AOJu0YxvD20KzfrEuNSMGBXOtvjXEby1vLjbQCKu70+uhsOQ6ewfVs6F
	6zZJy2BaVtUGdA31pPd+KGfbYSKQRMMTUM+p8NSiG16mXX+Bn9H54Vm/sfrjEnzCetW1+Z01jz4
	hKOv/7kOw+ckWYTAiA83McDUinrBecyilTpP6gsZsYNwlwOjyn8JdhBv53zhDg2XeZCMrH9GZXe
	HjRjhunCcxpPeq/Zfm8J+0VNSWr6BEWWIxejkQAMeKq3oOVAUX4fIGp+QRtFs=
X-Google-Smtp-Source: AGHT+IF2uRXFUQriUo4tvi6x2FYHwsywKL7Zw3vDn+zO9RvFZ2JyJoMpQxG3APMIfW/ed/zYgqVVYVaPi7Sv7tAlhg==
X-Received: from pjbsp5.prod.google.com ([2002:a17:90b:52c5:b0:2ea:6b84:3849])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17ce:b0:2ee:b26c:10a3 with SMTP id 98e67ed59e1d1-2f139329035mr1977597a91.36.1733952042875;
 Wed, 11 Dec 2024 13:20:42 -0800 (PST)
Date: Wed, 11 Dec 2024 21:20:32 +0000
In-Reply-To: <20241211212033.1684197-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211212033.1684197-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211212033.1684197-6-almasrymina@google.com>
Subject: [PATCH net-next v4 5/5] net: Document netmem driver support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Document expectations from drivers looking to add support for device
memory tcp or other netmem based features.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v4:
- Address comments from Randy.
- Change docs to netmem focus (Jakub).
- Address comments from Jakub.

---
 Documentation/networking/index.rst  |  1 +
 Documentation/networking/netmem.rst | 62 +++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
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
index 000000000000..f9f03189c53c
--- /dev/null
+++ b/Documentation/networking/netmem.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Netmem
+================
+
+
+Introduction
+============
+
+Device memory TCP, and likely more upcoming features, are reliant on netmem
+support in the driver. This outlines what drivers need to do to support netmem.
+
+
+Driver support
+==============
+
+1. The driver must support page_pool. The driver must not do its own recycling
+   on top of page_pool.
+
+2. The driver must support the tcp-data-split ethtool option.
+
+3. The driver must use the page_pool netmem APIs. The netmem APIs are
+   currently 1-to-1 correspond with page APIs. Conversion to netmem should be
+   achievable by switching the page APIs to netmem APIs and tracking memory via
+   netmem_refs in the driver rather than struct page * :
+
+   - page_pool_alloc -> page_pool_alloc_netmem
+   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
+   - page_pool_put_page -> page_pool_put_netmem
+
+   Not all page APIs have netmem equivalents at the moment. If your driver
+   relies on a missing netmem API, feel free to add and propose to netdev@ or
+   reach out to almasrymina@google.com for help adding the netmem API.
+
+4. The driver must use the following PP_FLAGS:
+
+   - PP_FLAG_DMA_MAP: netmem is not dma-mappable by the driver. The driver
+     must delegate the dma mapping to the page_pool.
+   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
+     by the driver. The driver must delegate the dma syncing to the page_pool.
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
-- 
2.47.0.338.g60cca15819-goog


