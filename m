Return-Path: <netdev+bounces-233793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47020C188E5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB015189BDC7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04AA30B52B;
	Wed, 29 Oct 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmd1lTif"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256430B526
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720866; cv=none; b=M+DVDeoX8HzTflflwDbwmzNxWaeVyT82/5NoIfC4XhTmEiAiAx5oSknO3dEVJJuqeARS2FZQCw5FpUiB4pbT4+ahAB+mgsZM6dCWcJp3s5PdOb+a6BLaMIMV3w/wHDI2Jn830Q0hA15qq9M7BrKJoF0xrtylbQTqvbxhgzRG/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720866; c=relaxed/simple;
	bh=/YijMjlE2vWiw2UXTGzGnWn1QC2iSvLdrJWg7msXoMI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mi0V2VdyH1vnwly5VzjsAbI0ltOfP60sbBGL5ydX2mfftxVi00GVwWilY6cvYxOZN6ujP6gEx+68Mqbi74rMGDK4rUQqRJgWfIbRgteoRuzY2jXn9aLgNB+Unmqj6AY5Mdd7TNeZj9G83KVg7I92q19SoPhC+ZoS3rzmwoLKbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmd1lTif; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290b13c5877so138758705ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761720864; x=1762325664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CDj7jmhJVOkaR2dbH09y572vZCI8Dh5xWwGXXOtX7e8=;
        b=gmd1lTifXOpVPgX2FfTFVXPgyvmQRBtu6ZpVjh6hjBfUZi8W60Is7F7/pWbQQn2xS8
         VsEtzIAMCy0HjIG9m8G5+W356KEm6q93rOq5fGVkqX5nXu9/EU40OAAEgJOJ5NE9K8es
         3MixPeUh/wu0qZePDpDnRyUtzEiNp+LebV0Z+06Ra3RtEpCjWiyFrSOaEaTjgBjEWdvr
         6u5HXswyBqpm2hPPkzUkBajPRbEVsu1J/4x6bOz5ur0WfTi/TpXvRMilqcWXDQfurcs+
         wRaraVYKVFTIhwK5oaCWOFnAfnCKMrKPSwcGIihLBqFxlJ7D66zuD5vBrrHtsEkaUL32
         0m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761720864; x=1762325664;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDj7jmhJVOkaR2dbH09y572vZCI8Dh5xWwGXXOtX7e8=;
        b=UoRx1d5atZXXr1dz6jWgtO7Sg5XTmTVUfU+F1kea6keoK30mIWb0YgYN0342xxv7Ep
         i2enJwGkAzacsKf6rS25m3x3NyNprxC0Uc1btVttYIfsX6dU/MWbhij3gGJV3QzaO3ET
         A6ZyDae2SUmx+Gm/lLdCSm/j6h8MEQnoh5A139BaltHV0PBYgV4mFWbvaqKOhBqRophr
         u8TBs8Stcym6N5nMw+FI/MHm5rzKQuapGkj7D7m7ZdmnpQPCBd2vzjpMfKgeuCPMPtad
         o05M5mheouzvU0++kW/PCGOQG6qNILaXfs9U/UDBO6dtbVZyb1Fxm3LsRFXpZvGXsGox
         Z/Qg==
X-Gm-Message-State: AOJu0YzZTf/ndYsOlk/pAG8Mfe9M/lxf0WG+0KqmZvQNj25J+xqK54/4
	hRxxCiCsaRtGtr2aoNpuZDAfowpRObSlBIpBRJAiWy2keiV02ZbjV5fDD8JyG8SuwHro1NBmdV1
	x9SC1lIby69TVfU5M6XaCQRIuH5/gFYkU5Hjj7GrCpjX/pia/8GefOiwO9NJH4eGHgj8pMFy0RH
	RBdVr6FVJ1f0ovcCTSjcslE8HAPSz8JK2e9FSudpG7EdqP4s32fSZn1HlKRkmkccA=
X-Google-Smtp-Source: AGHT+IEzYsfJZiUS4uonDVfQfLjRNfV4gNO9JSsRtvp4TQDnzuDUBpCLvqAtZVOn0jTeDyGTElJ2zlsExatC7mFeNQ==
X-Received: from plrs15.prod.google.com ([2002:a17:902:b18f:b0:290:28e2:ce44])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c411:b0:26b:da03:60db with SMTP id d9443c01a7336-294dedf453bmr22768025ad.13.1761720864089;
 Tue, 28 Oct 2025 23:54:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 06:54:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029065420.3489943-1-shivajikant@google.com>
Subject: [PATCH net v2] net: devmem: refresh devmem TX dst in case of route invalidation
From: Shivaji Kant <shivajikant@google.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Pranjal Shrivastava <praan@google.com>, 
	Shivaji Kant <shivajikant@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"

The zero-copy Device Memory (Devmem) transmit path
relies on the socket's route cache (`dst_entry`) to
validate that the packet is being sent via the network
device to which the DMA buffer was bound.

However, this check incorrectly fails and returns `-ENODEV`
if the socket's route cache entry (`dst`) is merely missing
or expired (`dst == NULL`). This scenario is observed during
network events, such as when flow steering rules are deleted,
leading to a temporary route cache invalidation.

This patch fixes -ENODEV error for `net_devmem_get_binding()`
by doing the following:

1.  It attempts to rebuild the route via `rebuild_header()`
if the route is initially missing (`dst == NULL`). This
allows the TCP/IP stack to recover from transient route
cache misses.
2.  It uses `rcu_read_lock()` and `dst_dev_rcu()` to safely
access the network device pointer (`dst_dev`) from the
route, preventing use-after-free conditions if the
device is concurrently removed.
3.  It maintains the critical safety check by validating
that the retrieved destination device (`dst_dev`) is
exactly the device registered in the Devmem binding
(`binding->dev`).

These changes prevent unnecessary ENODEV failures while
maintaining the critical safety requirement that the
Devmem resources are only used on the bound network device.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Reported-by: Vedant Mathur <vedantmathur@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Shivaji Kant <shivajikant@google.com>
---
v2:
  - Updated the patch description
  - Added Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
v1: https://lore.kernel.org/netdev/20251028060714.2970818-1-shivajikant@google.com/
---
 net/core/devmem.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index d9de31a6cc7f..1d04754bc756 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -17,6 +17,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/sock.h>
+#include <net/tcp.h>
 #include <trace/events/page_pool.h>
 
 #include "devmem.h"
@@ -357,7 +358,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 							 unsigned int dmabuf_id)
 {
 	struct net_devmem_dmabuf_binding *binding;
-	struct dst_entry *dst = __sk_dst_get(sk);
+	struct net_device *dst_dev;
+	struct dst_entry *dst;
 	int err = 0;
 
 	binding = net_devmem_lookup_dmabuf(dmabuf_id);
@@ -366,16 +368,35 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 		goto out_err;
 	}
 
+	rcu_read_lock();
+	dst = __sk_dst_get(sk);
+	/* If dst is NULL (route expired), attempt to rebuild it. */
+	if (unlikely(!dst)) {
+		if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk)) {
+			err = -EHOSTUNREACH;
+			goto out_unlock;
+		}
+		dst = __sk_dst_get(sk);
+		if (unlikely(!dst)) {
+			err = -ENODEV;
+			goto out_unlock;
+		}
+	}
+
 	/* The dma-addrs in this binding are only reachable to the corresponding
 	 * net_device.
 	 */
-	if (!dst || !dst->dev || dst->dev->ifindex != binding->dev->ifindex) {
+	dst_dev = dst_dev_rcu(dst);
+	if (unlikely(!dst_dev) || unlikely(dst_dev != binding->dev)) {
 		err = -ENODEV;
-		goto out_err;
+		goto out_unlock;
 	}
 
+	rcu_read_unlock();
 	return binding;
 
+out_unlock:
+	rcu_read_unlock();
 out_err:
 	if (binding)
 		net_devmem_dmabuf_binding_put(binding);
-- 
2.51.1.851.g4ebd6896fd-goog


