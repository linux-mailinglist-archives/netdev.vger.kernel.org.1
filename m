Return-Path: <netdev+bounces-233425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDAC1311A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 07:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14B21AA638F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDADA27CCEE;
	Tue, 28 Oct 2025 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hj7wno27"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591971EEA5D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761631639; cv=none; b=WCsFu42Qnzu5LBwTrWFBSDJcVZlUB/3Xcs7NvjdX+1DZaE/QttOPWd4a7jx/zhvUzHx1w0ds8lGmkPtvcs9zZkoLD4Aq12S8C6DYOLCeF94lu1uGObNVs1RDbesSLGpnxkImBOUMTdvBH+u3wEcgrVBjlTLPvhLiT2cbSh/M4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761631639; c=relaxed/simple;
	bh=p/IVdnfV4khlgG8mt9Ek8HnxLb8gr48aIdEnvVgP9hQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lb+Dc4j+OHR9v6jNxCATzUozLBYtioqxCRU6VBY/CkXdvHVmOVrkQZ9rFnl2Qx9JtXb119UOUJfhlBk/zlDBRmGf1VxJjR9vP/CwhTNd0BdamYWj8LLoqTG1tc8ImFnLE2mUaVy8X6QBvU180ZlSZXQsT2ZrvAXNSJa8KNtKfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hj7wno27; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shivajikant.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32edda89a37so4170011a91.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 23:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761631638; x=1762236438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CmVDos/iiNyPPLnMuSui3gilQCZYPJzE6253FS771QE=;
        b=hj7wno27WLVbby/IkvcvFC5uZIcLVyIVF/5jgDm5BetlVfdHIaKtRJRlD5jeYP1oR/
         yJmRDcB1cHtOun8NaSZD3Mce8Gc1I7coEkJANgqC1TeSo4QgMJZgPfAVUQYNQ2lD4hEv
         KCtgUVgvGqJQTCar3/f15nHQYk3wuIaj9RiRCpcPoXSYXPjmfBEmccgnWwIQFgv8wiDc
         Ir2C7dbovrYlKxCfNI658JyAvcrvH0FIQjt8ojGHgojG/ZCNlJQC2TPNLAZILnDVsy1P
         1WvdF225OJv6pimAMnZ089QsrA4kpEXm7VJ0OpBfUHrszz+5Cvlx/cXnB6b0Z3rEOFk3
         ADkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761631638; x=1762236438;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmVDos/iiNyPPLnMuSui3gilQCZYPJzE6253FS771QE=;
        b=R7GtKLicdMgBeF1PjF2fXIHiIgG5C2mt3KP3ioWfwFNTvrtEp9b3UWrn+mbJGbNfPP
         /mOmg797os/9eGryaQZg/QhdCNXGY8hGOAmZ5intQ3xZm5kS0q6jYaF3hZf6LSEK2nva
         8+o8dLTypfttYgi8igIO4VKM4M7CVkwii2auogh+HgG2bS245es6Ir0mwnV//T6BwpRO
         oo3CQsRzjnZdpcv6toclTM0q+ewAHzNZigiHYVKxDjoqgK8AR+1MuhEd9CjH3T63WDqE
         LWDiMzhjigzWh6WQYShHGJIW4KwDzYpcI8JVzhNGwtHSXc064+K3QFGFybNhanKm6dWP
         yHag==
X-Gm-Message-State: AOJu0YzhgYxDDCnAuToZuXox1kJ5OwEaQ75ZVFmo/6Rr9f05k/9Q0hXT
	xMekX6ov87GcTidsqevcLNBfFMID1tFGTcgSSh86DO2UhhH68IhWQkmm4+PWD8VVgXyzohul9Cp
	evZPOY/aLXUyeUiP75vNq+vPElPdk1ZC7JoxWeiQ31tTZNcT8EUTyRH0jp7q5sYKjvHv7/e5x32
	IYy6kGP2bbSaVdQ4CkEb/nSnCFVSfakXZ9sp43B51x3GvuYXmoXz5QqLWKrwn6iYY=
X-Google-Smtp-Source: AGHT+IGaVX23m6aKz+/U14LyIgO7cVIrm3f/DehCigVoN0SlevRBtf9aNsZ3mCrLZB6fLV2k/xhHTuo3t/v+3wxW5A==
X-Received: from pjbch10.prod.google.com ([2002:a17:90a:f40a:b0:33b:ba24:b204])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:280c:b0:32b:bac7:5a41 with SMTP id 98e67ed59e1d1-34027c1c55cmr2663128a91.37.1761631637591;
 Mon, 27 Oct 2025 23:07:17 -0700 (PDT)
Date: Tue, 28 Oct 2025 06:07:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028060714.2970818-1-shivajikant@google.com>
Subject: [PATCH] net: devmem: Remove dst (ENODEV) check in net_devmem_get_binding
From: Shivaji Kant <shivajikant@google.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Pavel Begunkov <asml.silence@gmail.com>, Pranjal Shrivastava <praan@google.com>, 
	Shivaji Kant <shivajikant@google.com>, Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"

The Devmem TX binding lookup function, performs a strict
check against the socket's destination cache (`dst`) to
ensure the bound `dmabuf_id` corresponds to the correct
network device (`dst->dev->ifindex == binding->dev->ifindex`).

However, this check incorrectly fails and returns `-ENODEV`
if the socket's route cache entry (`dst`) is merely missing
or expired (`dst == NULL`). This scenario is observed during
network events, such as when flow steering rules are deleted,
leading to a temporary route cache invalidation.

The parent caller, `tcp_sendmsg_locked()`, is already
responsible for acquiring or validating the route (`dst_entry`).
If `dst` is `NULL`, `tcp_sendmsg_locked()` will correctly
derive the route before transmission.

This patch removes the `dst` validation from
`net_devmem_get_binding()`. The function now only validates
the existence of the binding and its TX vector, relying on the
calling context for device/route correctness. This allows
temporary route cache misses to be handled gracefully by the
TCP/IP stack without ENODEV error on the Devmem TX path.

Reported-by: Eric Dumazet <edumazet@google.com>
Reported-by: Vedant Mathur <vedantmathur@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Shivaji Kant <shivajikant@google.com>
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
2.51.1.838.g19442a804e-goog


