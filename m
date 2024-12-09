Return-Path: <netdev+bounces-150296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5FB9E9CF8
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC7B280C9B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699991F0E34;
	Mon,  9 Dec 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ek74C0ud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37D1E9B26
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765001; cv=none; b=rrXhNCQfnJ4L1IzJmhMZcERp8APESTtcaQC6SO4xvvnB+Wpy+t8u3pJCGYelmO2D1/GqEvBksUf7mV8ccbVlpxLr3GHcpm9LWTBUesVL87+cHSyuXelCnDyJhKRmrcjkfHwtVOoiUE+6Z5UH+IsX4rrU8y4ZqUuA+v81OZIUff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765001; c=relaxed/simple;
	bh=bFEBgpIHiRCRmFB13zC6eRwjOnKNB5aS9cu/gmZUysw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PpLN61+6Mc4WHpq8UPgfvCFJmBICtMuUtquR5f0rzen2YgQyVbKuHSVpZqRB6NcF7LmQ8rE0VNiKUwPRXLLw1scjsa/yMeEQ+A/aRsDS1B2FNRnrDmPUqWJJL4CbPIdOp9J71+fSphwHKMYPpCdcJzFfuuDvhTkf8yQoXHkU60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ek74C0ud; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725f4b412ecso750332b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733764999; x=1734369799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQM2k5Y0cRnDWnUVVFZNmxP5ATTgTt6xLxZwaHOB548=;
        b=Ek74C0udRt0UTgoKRR9I3IQWjcvoCd0RQhaxTKY/aMxU+mqN6VRcsb9EM1tswTsdlS
         q5qPIDVj9K7MRqNKw1eVQRtlmpNU2XG+kuwFVu1giljiagxxGpiPAmeo1ovUExb+rA6L
         b+JD0jAQITs4blc8MTaD0VUELa5iVgnWpEKSZ2SDPnMn4Bf0nat/gwAkEVx9BXMW8Swy
         /au6ElFrnJ1fRzUBynm5M0j3+Guiqc9ArUc+Hbuaj29GMLv0f10uL8aa5sRYLIO4HJKb
         jrLEz72M6eenORG4lMJAxZ43iB0uzLeM1u8xPw/6jBKm1Bel+P3+ERmu5XYVrLn9FxxJ
         xkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764999; x=1734369799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQM2k5Y0cRnDWnUVVFZNmxP5ATTgTt6xLxZwaHOB548=;
        b=X6FyRdMPenkJzp2+daO5JOZ3GaxUNM1JqWGExvsf42KbmBc1BBobZJqihpEbDxEAC1
         5jwU3dol+updhlKDPfYWSquXE2JOwxaxmHJTkJ1p6IjL8TzyWOQeIAh645/hIArn6iVK
         1AGHI94to+X7i77ADWWJN6CglIz/0pMe4qXOwfH0B0frzTiM+DIwr6iBLbmr2aYAm2jp
         PiwYlmqfrQ/Dh1q5pFVbgMCd1g/72zn/YKQfSOk1khHuhe9rLk6DivLR1T04CF/E8Hwq
         2l8qxPfrh25kgfvx55RbBFLTRQp6+3WSRr5/3yLzKTRUiAPjBbfiOpYHpSNzZNIhM180
         AMLA==
X-Gm-Message-State: AOJu0YyQI4RuIN1xI/wUtoxuKykrUaoxrh2qLdB6zvPdVCyQDhKwTVOs
	NtswFNJpXyJn1/jZb6ZcHo8WrdjKvJ/vYK19QWwN+ukh5MmxWyqhGxmemo1xvvgJ8YGTlrgcFgS
	K36Kyp3/hoqX89XZfANWLbwxpzZJ2YFmrIbYOvHDv23k1iLMgRhxXkMKGoY0S/q6jCZ/tvjUoT6
	0VIUH1xtP7WElgqyfjFfjEyuuUlVcABvfvZQYD3wGUHYTaFq6fJtX8wgyWudI=
X-Google-Smtp-Source: AGHT+IHhNfJnVxuwnv9R4A+XXQzrx5pGpdsPzg0HIN1/IqhP/Lrmy6fFprFKab30nIaRS6AD+E2szGiPyRTX4XDhXA==
X-Received: from pfbc2.prod.google.com ([2002:a05:6a00:ad02:b0:725:b17b:24bd])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:22c6:b0:725:9edd:dc30 with SMTP id d2e1a72fcca58-7273cb1af91mr1635221b3a.12.1733764999141;
 Mon, 09 Dec 2024 09:23:19 -0800 (PST)
Date: Mon,  9 Dec 2024 17:23:08 +0000
In-Reply-To: <20241209172308.1212819-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209172308.1212819-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209172308.1212819-6-almasrymina@google.com>
Subject: [PATCH net-next v3 5/5] net: Document memory provider driver support
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Document expectations from drivers looking to add support for device
memory tcp or other memory provider based features.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 Documentation/networking/index.rst           |  1 +
 Documentation/networking/memory-provider.rst | 52 ++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/networking/memory-provider.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 46c178e564b3..c184e86a6ce1 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -73,6 +73,7 @@ Contents:
    l2tp
    lapb-module
    mac80211-injection
+   memory-provider
    mctp
    mpls-sysctl
    mptcp
diff --git a/Documentation/networking/memory-provider.rst b/Documentation/networking/memory-provider.rst
new file mode 100644
index 000000000000..4eee3b01eb18
--- /dev/null
+++ b/Documentation/networking/memory-provider.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Memory providers
+================
+
+
+Intro
+=====
+
+Device memory TCP, and likely more upcoming features, are reliant in memory
+provider support in the driver.
+
+
+Driver support
+==============
+
+1. The driver must support page_pool. The driver must not do its own recycling
+   on top of page_pool.
+
+2. The driver must support tcp-data-split ethtool option.
+
+3. The driver must use the page_pool netmem APIs. The netmem APIs are
+   currently 1-to-1 mapped with page APIs. Conversion to netmem should be
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
+   - PP_FLAG_DMA_MAP: netmem is not dma mappable by the driver. The driver
+     must delegate the dma mapping to the page_pool.
+   - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncable
+     by the driver. The driver must delegate the dma syncing to the page_pool.
+   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag iff
+     tcp-data-split is enabled. In this case the netmem allocated by the
+     page_pool may be unreadable, and netmem_address() will return NULL to
+     indicate that. The driver must not assume that the netmem is readable.
+
+5. The driver must use page_pool_dma_sync_netmem_for_cpu() in lieu of
+   dma_sync_single_range_for_cpu(). For some memory providers, dma_syncing for
+   CPU will be done by the page_pool, for others (particularly dmabuf memory
+   provider), dma syncing for CPU is the responsibility of the userspace using
+   dmabuf APIs. The driver must delegate the entire dma-syncing operation to
+   the page_pool which will do it correctly.
-- 
2.47.0.338.g60cca15819-goog


