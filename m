Return-Path: <netdev+bounces-235974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7D0C37A17
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F6D934E831
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBDC61FFE;
	Wed,  5 Nov 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO53bSTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D69322749
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373287; cv=none; b=pp0MirzKXPOo0ilxI/8o3iT8Et3yivXr+I3txgWGeADAX1vnK9PbjuhI2/1j1w8IYFBjFmlFYb8gbDzZiHRao+WLXveDYMhyXuRoQnwti0v7lc960SvD8dFeHXMMiTn355jDvTHXMKeh2jhHHOC/PDx+tqOoZPToEHkgFXtswgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373287; c=relaxed/simple;
	bh=IUDCyDWX/PpvMZk+l7VvkeUtKxYCTZU5DZ6jmwHq6Dc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R/dOWIXdj8zO4J/9GHW4H7d5a2HD2sKZ6Hw0V1sVqsNXU5DF7+PqLBlwKvzzB5kxBI9QdLgvyfGfXc0b+Fa7QdLkMAQOBsZNxSIy3rWTJMK+JJeUnF1PruD0Ko9VTDb/X0WLp6k427qFTuhqa94vmTQbYlmf3JbCL8lxCvkTMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KO53bSTh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7a9a8e76543so469351b3a.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762373285; x=1762978085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=weicUj8OP/KmpoTgZx1Z0prIlDsTNv9JhkK+b4dWd14=;
        b=KO53bSThb7zFPnhfwIEi4iFE7y1U5cUnfTFnm64rZDHkp8aNOnVQURp5Mz8ArT/uuF
         GkwchrQvCYWOYH/ByAN/IaAcoBNKJj34TKCN4i0pZYuetNjPdNYyuTg5CbtHtTXiZ1tK
         Q81IWr5bSKT5gfcQI6aQLGx9T1tZz7Jg89V0D92GrQ/rM+ydo6nFhwY+oKwXiIaBZSaU
         ybsxpxcURs9PCXqD9ECF5+HRBvIsyMEv1QX1srl5Mtj+geooltDuqfis5lhSGBsfUuxw
         ki7A3zhyccvk16eC/nd6uTEcld8fMqfzsKhsAz43KUi2Wix16OYGHRigrrMTwIfPPGIf
         eVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373285; x=1762978085;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weicUj8OP/KmpoTgZx1Z0prIlDsTNv9JhkK+b4dWd14=;
        b=U6SkNf1ubVaCwRHL/lh+8jrX+x+YIa/Mhmkx9y8GpRhnl3qh3C+443szz47wdv+p85
         3jzUxaNMJt3jrnoSigqJ1bYCquztOPYiNIZewmYCALgBSPE1DNSYgB4jeWSR5hRfLzCC
         N30Wc6xkyBUWBZjGwjlz5XUQWvwHjotmQzHr04dwYySHObXcC2pDvVS4NDvxhOVHVaLf
         BJYN9jpYUmzfVjzPBzvmA5TbbbHpjMDSDrey2Ap7J3xoZXJNxDo2a/noQ0jt5LLyqFyv
         Zk8oHf+g7w/r9sMGhD1ATXmk+wO64LqptGfkPSBnaJ0S6BX2os3wyNEXnwiF7vLCF+4d
         P9Xw==
X-Gm-Message-State: AOJu0Yxs2dGCEcMo2rNKypA7ltX4N61cwY9+5GKzU1L5iV4Yh/o4aOyD
	7Ql7MRI7XGjccZyvq9vSC2byjzQShTec7JE/YiOFW0ksfD9Vp1Ur5wtag0nev7dMclCNDmdE0hl
	6VNfFnvwG0Ozu+rQdYamdDxW+q3kkQi2hzFNBgFdkiYxjxUUEqUpTTX2jLi0ej7lsxqv2BXFUMd
	TW1oBikfFB/33vxZmRSXLxF/uDLrXm0lYOK0gIhB4yg1rol5tKLqEA0Woxp3zjlpg=
X-Google-Smtp-Source: AGHT+IG0g/e5dGxpq+IR+uIerlwWaRi2lWUg9hMpxhSx5vQJK7AsvVaMKNXcUsN7woUfxiWSFv5bJ/4fnSUJlTPQsA==
X-Received: from dlbut7.prod.google.com ([2002:a05:7022:7e07:b0:119:49ca:6bab])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d11:b0:334:8239:56dc with SMTP id adf61e73a8af0-34f865ff4e8mr6206196637.56.1762373285185;
 Wed, 05 Nov 2025 12:08:05 -0800 (PST)
Date: Wed,  5 Nov 2025 20:07:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251105200801.178381-1-almasrymina@google.com>
Subject: [PATCH net v1 1/2] page_pool: expose max page pool ring size
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Expose this as a constant so we can reuse it in drivers.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/page_pool/types.h | 2 ++
 net/core/page_pool.c          | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 1509a536cb85..5edba3122b10 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -58,6 +58,8 @@ struct pp_alloc_cache {
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
 };
 
+#define PAGE_POOL_MAX_RING_SIZE 16384
+
 /**
  * struct page_pool_params - page pool parameters
  * @fast:	params accessed frequently on hotpath
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..7b2808da294f 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -211,7 +211,7 @@ static int page_pool_init(struct page_pool *pool,
 		return -EINVAL;
 
 	if (pool->p.pool_size)
-		ring_qsize = min(pool->p.pool_size, 16384);
+		ring_qsize = min(pool->p.pool_size, PAGE_POOL_MAX_RING_SIZE);
 
 	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
 	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,

base-commit: 327c20c21d80e0d87834b392d83ae73c955ad8ff
-- 
2.51.2.1026.g39e6a42477-goog


