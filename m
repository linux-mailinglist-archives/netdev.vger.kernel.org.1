Return-Path: <netdev+bounces-151210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE4C9ED85B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306211886DCF
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A98D1DE4DA;
	Wed, 11 Dec 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjLc36TE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EE1C07E4
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952036; cv=none; b=QsUEVCUyc7TEr/rRlU8hihuN9U6igfdaz7tmeMBvph3WEZ2iSRqbGQkpryjlHLj9XFiAoLl+hyxT3bd/DNp/kgBg/vz/VucS5FZABFzRR7Tru6M/ojUFqqwUMDK7aOhVCIvrHv5yStrZgrg4pYs8fN5XFiC/qZfVHCT32esV3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952036; c=relaxed/simple;
	bh=6T9WrpL4sqWT331e0Yh7xF8mqS2u1I1S/1pC0eC7IDs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kqndJgGuA9xIxo2srwC1xbppeXpV+DlyEjKoiTLm68SC68RlfLr0P1tIItU4IfOj/p5hOWY5up1j11Fri+HkRdVD/upNFbuD3i8IVl5ab0GvEJTKyyEdFn42YRycYoxls+lW8F5vDsqga7PlTSBNJFnNpeT1fV81+UlCFXJzUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjLc36TE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163a2a1ec2so61077825ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733952034; x=1734556834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a0zEciK8O4GHG3RCZ1UR9AOhZgRfwuZKEj0A7rDFXoI=;
        b=pjLc36TEPLga+guztOmngHcrYVhpy6fekS/9ftqU5sXIJqIwuCqgD3UWkS6+dAIVUV
         IT0af5paGr0ygA77+2L8QlQ62xaO80HqURPKwxMSLKjqQQJXNEamHXPJxPFeGAAugXyh
         X90enqzNSevMTxgbbTZhWn432F2/q1PPepXTvnjxmgYbAHxEBPOSyc88MxZqJlFzRFfB
         bIqMIq9ttlZ09rNPKXibrXAgFgEqHj3+Cz4xGIEcwC24RQJunEtwUZZb3MPGh2HU6q8d
         SV6jKMyCQiUZMrttHKKgxm6Al4lgYNiITkaxvPIex20UvUi0CvC08Pdku0oNuAmny1BU
         QV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952034; x=1734556834;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0zEciK8O4GHG3RCZ1UR9AOhZgRfwuZKEj0A7rDFXoI=;
        b=ia4ruLq6aUKgJJmyD75KJNdT04I70ZouuoePqX3Hm/CtecjXOBmASAa38r4Q5/WtKk
         8ArmZLm7l3LTKo3/EB69P7m08w9e5l8KN/fZSc0GTbteH2Eu4vU498ybmzeLQdPQN/vi
         5v27ozFsyI80O3LCMV839q2XphZfjJjNsqhLQWoOSTw7V8ihsIazKgnjCY44AGfI8T5J
         +qu/DLayJauXWVxqgsdCFoeS3lzN873e4ypKoQ2EFg+yFO2AnLBjIGaM+GFbxexZ4sPK
         RP528S/SlPKGHq2moWbNBGQhdYJ0YCaC/XvmButTl4R44fY7c3lq54NuNmnGzCHezLDz
         9oOQ==
X-Gm-Message-State: AOJu0Yy8ISOVmcJy/3VxZLNeZySb/5PuUSNll0F9x766JGDpnUwvPUvW
	IJH+DbGdYqFV0Zm69dlQq5uiqCJ88SY/PQ3FORWP5e0DTqv+grZqBLsLDwDT4SrTojtl0sXRYpF
	r/XgsjpuSLPPvXQ3nQQHRJ3dK0Ab2tyz7W2xGCxA/u2BEOQ0v+NKgDk7OlLbbDWJI2J0MDsUNhy
	VMWiohjo+h+U95D8IAh6Giqeg2XOw930Y1IFv/3IzupCjyKvTw9IcMdfiX168=
X-Google-Smtp-Source: AGHT+IEhZ4/EYttELWP5/7DRwp/CXzwOZCI+gW47lGqaelEIwVvcTRJAGh8rjR/entYUOVYt+EKxjcrjy2FJmMYXaQ==
X-Received: from plbme11.prod.google.com ([2002:a17:902:fc4b:b0:216:1543:196d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db05:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-2178aeefc4fmr18775445ad.41.1733952034481;
 Wed, 11 Dec 2024 13:20:34 -0800 (PST)
Date: Wed, 11 Dec 2024 21:20:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211212033.1684197-1-almasrymina@google.com>
Subject: [PATCH net-next v4 0/5] devmem TCP fixes
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

Couple unrelated devmem TCP fixes bundled in a series for some
convenience.

- fix naming and provide page_pool_alloc_netmem for fragged
netmem.

- fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

---

v3:
- Add documentation patch for memory providers. (Jakub)
- Drop netmem_prefetch helper (Jakub)

v2:
- Fork off the syzbot fixes to net tree, resubmit the rest here.


Mina Almasry (4):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  net: Document netmem driver support

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 Documentation/networking/index.rst  |  1 +
 Documentation/networking/netmem.rst | 62 +++++++++++++++++++++++++++++
 include/net/page_pool/helpers.h     | 60 +++++++++++++++++++++-------
 include/net/page_pool/types.h       |  5 ++-
 net/core/devmem.c                   | 10 ++---
 net/core/page_pool.c                | 12 ++++--
 6 files changed, 125 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/networking/netmem.rst

-- 
2.47.0.338.g60cca15819-goog


