Return-Path: <netdev+bounces-235975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F96C37A2C
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5EFA4F29BC
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E404824DCED;
	Wed,  5 Nov 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8352Edw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55003346A05
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373291; cv=none; b=tMWj3MewRIHGX8BxrXSnfemaknAVX48+YeW2FoW61MK+hj/eNtp2xQhowl9E3CShTz1Vr8kPQdennkXn0M6VffRYNqlQzdJzda6XsjZfwUyo5CJDaZC+zTm9OsEfzcxT7h+ah58J3wCjlszTMqxdjjNIU17P+xfMQzNsrcUPTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373291; c=relaxed/simple;
	bh=n3os+k4QqkzkjBHpscj0Pon1HDkYiwHI5oh2gSfO3eA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d6cPe+IvYmZd1/obYl6hOXAS2KhOSgVn6zMewXk9QrfXAf9DmRD29WGAjLQCw8WVFY0yjgj8FzKtLkp9+0UcZM7b0K5Iy84YgfCG+Q7UDhKw4Q2n1X82+bt14PPViPMvfiItcO7+HoVTrHbvN70tTvAHYatXdYExlopQoosNomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8352Edw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b9a72a43e42so134391a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762373289; x=1762978089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsYTHqHcd87Px6g2etcm588RqeZ8ybpTCrwlTD/0dmA=;
        b=m8352EdwkyOgg9FYO9mxPhyzcd9MSHAbuT3STBxALVeIKv0dZ1XHb+Qt4tBY5zm2sy
         El+mUKXyj/Rqr+VDmOIuRw/IAVxKJ09RuJK3IRA3wXrrOB0C8ljGV8XJqHu6xJUagnET
         VNfCWQ6Kcfx3J1fso/xpNfqhIaY5I65v0Q54SXGJrX3D9iTinIxrmf+vCro4AVrdggue
         EspaOU1I6GIMveX3JPmrgZ+1cFQMZnnJgexueAHKFFfxyHHsIIDW0voMqG93gfTG80w9
         LmCIQeSjOoLLicygkEL19hPMZQ4aOU8CWUCJRAXj6eLynt8LkklrmLjGCWd9jAA38F04
         lpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373289; x=1762978089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsYTHqHcd87Px6g2etcm588RqeZ8ybpTCrwlTD/0dmA=;
        b=qRw1qSv3ENXBm6kPEOIbjdWXRlbrwiMtqv8bIyrSVORQE2lCyz18DYe9/ylRwdX+QZ
         CJwa8jVmM++hCSJMNU3P3vb0G7eMjSKW42Uu0FxEK3DcL/Eea2+fsm009Cj4PAMil6kE
         wSqoUh0ASVTje8qfj01KijjQm+4WUWqtgOdAcO1L9+XXGo4W+XkNQPgHPL8L6yXLo+Fv
         hS0RmrNNmwtWJdAdFEA8SsXXuAbLOzccp0+zlxmiJdn4xwT6N5YsovTYgkP98JfdIo/P
         39xi0H1kKbiC+vAlMTZgrGeP94y0DGuOZ87w3Hy/JYuY3KnM95gBzYy9IurIF+dRN7Rq
         zPDg==
X-Gm-Message-State: AOJu0YzXW6UBgsBjlaDD4yTYex3kX7atse94tYtIQt8NcOjdGxKrCYW4
	PmleMdejyXpPbVhagEVylPPd1P9hzvPrdqsk4O/FuHLbSpkVMGURz5nQCjGxexEJeue0FkuNILz
	RbGXGTpxxkIYhNnxXUiRpN4JsoSlR7VlCLmxt73DsPnOaC1Sgl4hyU7ULYoT+fbGzQW4VjpsQ37
	kp//msHs2bEact88LqTxMnSYjNi5SxWF7ZBC8aGEqlB093+O1lDoT9Bx6zDNqbkho=
X-Google-Smtp-Source: AGHT+IFR7MYzatcpuTgTWfkgPeCwao/117d57DT7xFMktke+9nyy2N6IlS6Pz9VEWT8DicmLcYidcojAwE94zXXYMw==
X-Received: from dlbvg6.prod.google.com ([2002:a05:7022:7f06:b0:119:96ef:3b41])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2729:b0:340:cc06:9514 with SMTP id adf61e73a8af0-34f86e0bb65mr4218111637.57.1762373289217;
 Wed, 05 Nov 2025 12:08:09 -0800 (PST)
Date: Wed,  5 Nov 2025 20:07:58 +0000
In-Reply-To: <20251105200801.178381-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251105200801.178381-2-almasrymina@google.com>
Subject: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"

NCCL workloads with NCCL_P2P_PXN_LEVEL=2 or 1 are very slow with the
current gve devmem tcp configuration.

Root causing showed that this particular workload results in a very
bursty pattern of devmem allocations and frees, exhausting the page_pool
ring buffer. This results in sock_devmem_dontneed taking up to 5ms to
free a batch of 128 netmems, as each free does not find an available
entry in the pp->ring, and going all the way down to the (slow) gen_pool,
and gve_alloc_buffer running into a burst of successive allocations
which also don't find entries in the pp->ring (not dontneed'd yet,
presumably), each allocation taking up to 100us, slowing down the napi
poll loop.

From there, the slowness of the napi poll loop results, I suspect,
in the rx buffers not being processed in time, and packet drops
detected by tcpdump. The total sum of all this badness results in this
workload running at around 0.5 GB/s, when expected perf is around 12
GB/s.

This entire behavior can be avoided by increasing the pp->ring size to the
max allowed 16384. This makes the pp able to handle the bursty
alloc/frees of this particular workload. AFACT there should be no
negative side effect of arbitrarily increasing the pp->ring size in this
manner for ZC configs - the memory is prealloced and pinned by the
memory provider anyway.

Tested by running AllToAll PXN=2 workload. Before:

Avg bus bandwidth    : 0.434191

After:

Avg bus bandwidth    : 12.5494

Note that there is more we can do to optimize this path, such as bulk
netmem dontneeds, bulk netmem pp refills, and possibly taking a page
from the iouring zcrx playbook and replacing the gen_pool with a simpler
fixed-size array based allocator, but this seems sufficient to fix these
critcal workloads.

With thanks to Willem and Eric for helping root cause this,

Cc: ziweixiao@google.com
Fixes: 62d7f40503bc ("gve: support unreadable netmem")
Reported-by: Vedant Mathur <vedantmathur@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 0e2b703c673a..f63ffdd3b3ba 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -8,6 +8,8 @@
 #include "gve.h"
 #include "gve_utils.h"
 
+#include "net/netdev_queues.h"
+
 int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
 {
 	return page_count(bs->page_info.page) - bs->page_info.pagecnt_bias;
@@ -263,6 +265,8 @@ struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
 	if (priv->header_split_enabled) {
 		pp.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 		pp.queue_idx = rx->q_num;
+		if  (netif_rxq_has_unreadable_mp(priv->dev, rx->q_num))
+			pp.pool_size = PAGE_POOL_MAX_RING_SIZE;
 	}
 
 	return page_pool_create(&pp);
-- 
2.51.2.1026.g39e6a42477-goog


