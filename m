Return-Path: <netdev+bounces-272099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F06BENIxWkU8wQAu9opvQ
	(envelope-from <netdev+bounces-272099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:52:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A92633713A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670F83101F36
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A03FB055;
	Thu, 26 Mar 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHHvgLAt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46633FADEE
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536210; cv=none; b=kHTeg7aIxjFHtjIBBdOboMi5svmMh+1WmUU/dlbMipRUr0WeEZW8MzzaGP0BZ15BHwjg+VkoQRkm+WjubH/DvIoJ+tINYh6JSrLpFn9hq8nOuZa1vavNLS8RjUo+VKiQOKwwu/u0ym1xmtRpWEE3Q0CxEFz/Myn5mVseFpOjnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536210; c=relaxed/simple;
	bh=6Bm1CuoV6Oz7M5u5zTWYtsyXA7QQp5kmcuLOYHAba+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ncSYak5IVTV9NGCRTTrzz955sVafHFGkuYKl91NvDSTFxjfPG2HyuHc8d6Thv7NEgTnbwOIzpDXlwo24ipvm7kfW8ZCLuCXRvYPPicrX3ChQsrS1JUe/xIi5ykUJ9IkoCvd2PL7jmJFKSX3RjqINtczyOnkZGcl72gmMJSZl2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHHvgLAt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso691243a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 07:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774536208; x=1775141008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOcvCcwI2gRdxbs6Y2QbtvNq/WbGt3Iy0gRbsGAIHVY=;
        b=gHHvgLAt2pwdioAlslAZuh7eaz+CDSGLHJnKj6fNdJuZ7RI9O6vAQwOZxpNYxRqv9M
         5l4wzHNdJIYD0O7UYPSeQZJLc6mi3SSFubFX1MhM/+ne5aVgF/TGrHPl94EOuNYn6EwW
         GTVEbrIfjBetUDcooXBFNtQsxanM6ax8hnwR9D+IK04Neu6Knx3vsIi12uYVhn+d95vG
         Jjtyw1RnnT0/Q24FNlN4iqAWwJ/gZCA/IU0on302TKNgpm4Ca0EUGxUNj3XWVhjBPwRv
         NbZmGcoRY9JTMEX3S15Z4ioJEKG9rYubsXZ0VSpBa0qxY5Nuccgi87QCxiyEYcJAoNjr
         3ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774536208; x=1775141008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOcvCcwI2gRdxbs6Y2QbtvNq/WbGt3Iy0gRbsGAIHVY=;
        b=ZAFSvWAgVvl3NnqWfRZO1wfpyK86nPkT6z+PagdKaOaS440CbYenEV4nUpvq5CitTp
         5800/0HvMZvykKQtpv35VTEeAe13bq+2GqAmB7GB0or7Y9VJChXKCh8A6GKM68rbXdgq
         6hJZFxMiUFYI9lVvt7Yt819VVGfUm2LA8ahN1sHdJJE+Y6POovXKQqryicy06CEoH6jt
         avjSd9+EIYAAQZx7QcUhuLcyIOuwPL3EQi5nIGCEEARfCOHCxNIR33gbbRCN6zI9i07i
         yl/iCULHdw++U7KjVwOaTzhBIX0iyfzhSMIDtJRgkkskSW7xAvtxAVeYnvbGycQiegyn
         Qvrg==
X-Gm-Message-State: AOJu0YzY3oagJUIyw0DxMnpbVuGKUHd7vlLDSfcMjdioISseeU4Oc4eM
	A+YhK1r7LyxgtT8OJkLYaiXlJhk8rSoVZUh3B7+KE+UG5YQajOXp8SlZNesjVw==
X-Gm-Gg: ATEYQzzOdPQcBjqSiw6rUiKYxE0cteSJJ7zyO6fYgPx5IcBYp3mvvR4G9omKmUMvcUc
	1jJkWBw8Ezc5nwiysu0eYVN5y4BOlLNxqUa8Y6lK94LUy3pyDPTAYdVcZbQfqTVb1s55DZEcBzr
	RivVu3kv0JfaW9mldD9LMolZsIjsJE/UREOHN550xonUuyUlDnTP2HMeeAKfBmedFhKw2xQqJqn
	Q0DXKPlevh85unGZkNNjNJc5iES2hrw+NrOcxXVniFamga5IofGC5K1AmQCARJLZ0uTNjNccwrp
	g6X5npT6rVugTk8hcbpUmYy86voan5CUyBj/T8rbQxbVk7OVG5gVzqAnyyG4uKOPF9Yafggx7LS
	pbXnp02N2oRVM//IQrCXsW7i0KojqDRXpHupoe9GDONOmUsBQqKHqhWcn/ZNTGIwQIFIhc3/YA9
	Pnk/EQA+McmE7JpmffkOtSWPqjnzDOlTW9X2ABNvPAPK2ggvISSTdwySWaFEbuIXrpnvnbmT8=
X-Received: by 2002:a17:90b:2f87:b0:35b:cd3e:c4ab with SMTP id 98e67ed59e1d1-35c0dd0bae7mr6866880a91.14.1774536207747;
        Thu, 26 Mar 2026 07:43:27 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:81bf:8c66:a83d:7f05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22cba9f7sm2022117a91.11.2026.03.26.07.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 07:43:26 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next] net: add sysctl to toggle napi_consume_skb() alien skb defer
Date: Thu, 26 Mar 2026 22:42:49 +0800
Message-Id: <20260326144249.97213-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272099-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A92633713A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit e20dfbad8aab ("net: fix napi_consume_skb() with alien skbs")
defers freeing of alien SKBs (alloc_cpu != current cpu) via
skb_attempt_defer_free() on the TX completion path to reduce cross-NUMA
SLUB spinlock contention to improve multi-queue UDP workloads.

However, this unconditionally impacts the napi_skb_cache fast recycle
path for single-flow / few-flow workloads (e.g. AF_XDP benchmarks[1]):
when the TX completion NAPI CPU differs from the SKB allocation CPU,
SKBs are deferred instead of being returned to the local napi_skb_cache,
forcing RX allocations back to the slow slab path.

The existing net.core.skb_defer_max=0 could disable this, but it is a
global switch that also disables the defer mechanism in TCP/UDP/MPTCP
recvmsg paths, losing its positive SLUB locality benefits there. AF_XDP
can co-exist with other protocols. That's the reason why I gave up
reusing skb_defer_disable_key. Besides, if the defer path is disabled,
that means TCP/UDP/MPTCP in process path will trigger directly freeing
skb with enabling/disabling bottom half(in kfree_skb_napi_cache())
which could affect others. So my thinking is not to touch this path.

Add a dedicated sysctl net.core.napi_consume_skb_defer backed by a
static key to selectively control the alien skb defer feature. Let
users decide which is the best fit for their own requirements.

This patch also avoids touching local_bh* pair(in
kfree_skb_napi_cache())
to minimize the overhead.

[1]: taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
1) sysctl -w net.core.napi_consume_skb_defer=1 (as default)
 sock0@enp2s0f1:1 txonly xdp-skb
                   pps            pkts           1.00
rx                 0              0
tx                 1,851,950      20,397,952

2)sysctl -w net.core.napi_consume_skb_defer=0
 sock0@enp2s0f1:1 txonly xdp-skb
                   pps            pkts           1.00
rx                 0              0
tx                 1,985,067      25,530,432

For AF_XDP scenario, it turns out to be around 6.6% improvement.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/net-sysfs.h       |  1 +
 net/core/skbuff.c          |  5 ++++-
 net/core/sysctl_net_core.c | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
index 38e2e3ffd0bd..a026f757867e 100644
--- a/net/core/net-sysfs.h
+++ b/net/core/net-sysfs.h
@@ -14,4 +14,5 @@ int netdev_change_owner(struct net_device *, const struct net *net_old,
 extern struct mutex rps_default_mask_mutex;
 
 DECLARE_STATIC_KEY_FALSE(skb_defer_disable_key);
+DECLARE_STATIC_KEY_TRUE(napi_consume_skb_defer_key);
 #endif
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3d6978dd0aa8..3db90a9aa61d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -94,6 +94,7 @@
 
 #include "dev.h"
 #include "devmem.h"
+#include "net-sysfs.h"
 #include "netmem_priv.h"
 #include "sock_destructor.h"
 
@@ -1519,7 +1520,8 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 
 	DEBUG_NET_WARN_ON_ONCE(!in_softirq());
 
-	if (skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
+	if (static_branch_likely(&napi_consume_skb_defer_key) &&
+	    skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
 		skb_release_head_state(skb);
 		return skb_attempt_defer_free(skb);
 	}
@@ -7257,6 +7259,7 @@ static void kfree_skb_napi_cache(struct sk_buff *skb)
 }
 
 DEFINE_STATIC_KEY_FALSE(skb_defer_disable_key);
+DEFINE_STATIC_KEY_TRUE(napi_consume_skb_defer_key);
 
 /**
  * skb_attempt_defer_free - queue skb for remote freeing
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b508618bfc12..33e8217ee1ce 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -372,6 +372,35 @@ static int proc_do_skb_defer_max(const struct ctl_table *table, int write,
 	return ret;
 }
 
+static int proc_do_napi_consume_skb_defer(const struct ctl_table *table,
+					  int write, void *buffer,
+					  size_t *lenp, loff_t *ppos)
+{
+	static DEFINE_MUTEX(napi_consume_skb_defer_mutex);
+	int val, ret;
+
+	mutex_lock(&napi_consume_skb_defer_mutex);
+
+	val = static_key_enabled(&napi_consume_skb_defer_key);
+	struct ctl_table tmp = {
+		.data	= &val,
+		.maxlen	= sizeof(val),
+		.extra1	= SYSCTL_ZERO,
+		.extra2	= SYSCTL_ONE,
+	};
+
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		if (val)
+			static_branch_enable(&napi_consume_skb_defer_key);
+		else
+			static_branch_disable(&napi_consume_skb_defer_key);
+	}
+
+	mutex_unlock(&napi_consume_skb_defer_mutex);
+	return ret;
+}
+
 #ifdef CONFIG_BPF_JIT
 static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table, int write,
 					   void *buffer, size_t *lenp,
@@ -676,6 +705,12 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_do_skb_defer_max,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "napi_consume_skb_defer",
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_do_napi_consume_skb_defer,
+	},
 };
 
 static struct ctl_table netns_core_table[] = {
-- 
2.41.3


