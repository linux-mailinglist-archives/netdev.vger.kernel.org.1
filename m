Return-Path: <netdev+bounces-272602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBYvOJ6jxmnrMQUAu9opvQ
	(envelope-from <netdev+bounces-272602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:34:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B91EC346D3E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB7E930346D1
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48D314B6E;
	Fri, 27 Mar 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSaKYma4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05E2DF156
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625644; cv=none; b=QgUhimNUTwbB8HaUsHQ88+XiB35rCWQare1x9Xh0Qlpv+2e2RUGs0OpkeTH0pO3s+NqUFo5XIe3gBpR77wy5+EuTjwNOQgLSVi8XoK0Ipv9tbdrV2y3GqMwPgi2i5F66CcqA622MQUNIjK7HqqAXakXckO5BZSlQ3WNa8sksNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625644; c=relaxed/simple;
	bh=o3+d9UHxiI6zvg0auw9A95x0svAKTXZdoNsWwF48kQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UO82Ouv+0CpjQCdNgP42TMPMAvDhrCAvGirScp0Rd7TIO/p+13eJR2dHMOnDG1f5IOFn+luOxw5HMRqVU+XpkKrxpiZsI9CnbLOVSRjb8iCErOwISADmO6NuH4VOMUo77ClvSxiov2AtVfae+ABU4Yixz4mcWB4EiFd7WEU8H2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSaKYma4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab46931cf1so25240685ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 08:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774625642; x=1775230442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AcKc3gGZ7437lTSALjViPsBhwLBjsjChb2jRBX8x3t4=;
        b=NSaKYma4SrUQRsed6+VM7Eii28cmz8lnhbxZHJnN45Lc1J/Z1AyDvWWdvwrRHpub/Y
         +cR3mV7NixXMuI8FTyouXjkTzUSxVtVbnpoQQu5x/AiMXG9L6WXtoBa6nC9PqPN7qk7r
         PxWBbCgb9rSNt389ZGH1XJBg/H4roY5UTXWar8x6DIcn5vKzyc6xg8qU7dxivN3knnkv
         QrpWHur+gzhMNN/Z/pUFnXP4O6RuApTni1aBVGwvxppbj/84hKAsWh18iB9I68IQwDCd
         k4w7I1VyEOSxyGE2jpCg1vIN/mY+8ag3sSENGhDnuIsARY0MiPp5g6kp2gLrbIckXRrd
         53nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774625642; x=1775230442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcKc3gGZ7437lTSALjViPsBhwLBjsjChb2jRBX8x3t4=;
        b=eLaCxc7azzqy89ODqnmmTj5TNBqyzvFIkkRjX4ksjFnoHJqL1eO4Wrung3uKShKnno
         ErJivkYtE47FaHSoD23rQNq82GbP1nbfil29GKQXAj5R5NuJtHH0ZCCS6mmmA2vtZFCd
         3HQvfZ1rAxzg9HTRtQscu9IQHMIpa3PYWPAwWzcAcpY++p2S2+8il1mraAwrTB33IrqA
         rh40TCNuyirr2Hmnos5u6+sPbDuGdj5yhOjJEgBRcjzChyqKxXQRhQWHn7nQ7IqhjRIt
         U5jf0uqbmWtitYN7msSHTXNab2lyyQlTc859GuT6ntktoz7HIOXr+eW94M3++BW7+lKc
         ZlQg==
X-Gm-Message-State: AOJu0YyIPWtaN8rIvIXBZfKNiKRnjwCMxdDfpwUd9XnX/AkOJUN2Jhnl
	YURz/qp9vvvFSdJIVeC/VZamdz3J3NNe+7nW7cuBCCtNKKwMzTGbediW
X-Gm-Gg: ATEYQzzurjqbl3B3p1PN9IZV+uBt0kBRyJ3nPlGOJ4JUbExHIpqBW6eZpCnkktZkeAM
	U8OtQbyn8iKlIwZjRn1wy3fukLTpjhgh+sWlvKDrkR3BZ5KpVRRApQjDS9vc2WFSgSm3kusQPu1
	roQPP4fVevffWh/TeFP3wpqLzkiIZ4uGsmstiiQY5YUh0jnsPNijEpCTgIHo+Ibadt8MHBOqEB0
	6fnOudNIzeXDPEzMDzLWeIwXDoEuarDu5KGsiWrVSxTVRDs5m8aSuDrAtDA2YfTD8Yf4sNeiH7H
	BFOTGEDLwOY1szNQ7ZCSzv2sZJWTSCD0m6MIiGKbAw60ETdGBK6y+RjVOQp2AAVu1HpYJ9oRi6g
	wh4+w45zaicGYFHp1mpXz/BqMg2BbAHfsrKQribxFBzKtR7NpS3BJ1odL1VhpXEmUiauxjImfqW
	WT522LTVjzvNyifeAkGIvQSC5t+kE4MHgxLssk10a7omFT0CzOTNg9gs/feSk8HI20tQjAsZ0=
X-Received: by 2002:a17:903:b83:b0:2ae:cd8c:bd04 with SMTP id d9443c01a7336-2b0c485870amr64696105ad.10.1774625642069;
        Fri, 27 Mar 2026 08:34:02 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:1049:edd4:9cef:b3b5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76b936sm64108625ad.11.2026.03.27.08.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 08:34:01 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	stfomichev@gmail.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH v2 net-next] net: add sysctl to toggle napi_consume_skb() alien skb defer
Date: Fri, 27 Mar 2026 23:33:47 +0800
Message-Id: <20260327153347.98647-1-kerneljasonxing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272602-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,enp2s0f1:email]
X-Rspamd-Queue-Id: B91EC346D3E
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

This patch also avoids touching local_bh* pair(in kfree_skb_napi_cache())
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
V2
Link: https://lore.kernel.org/all/20260326144249.97213-1-kerneljasonxing@gmail.com/
1. reuse proc_do_static_key() (Eric)
2. add doc (Stan)
---
 Documentation/admin-guide/sysctl/net.rst | 13 +++++++++++++
 net/core/net-sysfs.h                     |  1 +
 net/core/skbuff.c                        |  5 ++++-
 net/core/sysctl_net_core.c               |  7 +++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 0724a793798f..42e06f93306f 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -368,6 +368,19 @@ by the cpu which allocated them.
 
 Default: 128
 
+napi_consume_skb_defer
+----------------------
+When set to 1 (default), napi_consume_skb() defers freeing SKBs whose
+allocation CPU differs from the current CPU via skb_attempt_defer_free().
+This reduces cross-NUMA SLUB spinlock contention for multi-queue workloads.
+
+Setting this to 0 disables the defer path in napi_consume_skb() only,
+allowing SKBs to be returned to the local napi_skb_cache immediately.
+This can benefit single-flow or few-flow workloads (e.g. AF_XDP TX)
+where the defer detour hurts the fast recycle path.
+
+Default: 1
+
 optmem_max
 ----------
 
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
index b508618bfc12..e85ce10afa1f 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -676,6 +676,13 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_do_skb_defer_max,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "napi_consume_skb_defer",
+		.data		= &napi_consume_skb_defer_key.key,
+		.maxlen		= sizeof(napi_consume_skb_defer_key),
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key,
+	},
 };
 
 static struct ctl_table netns_core_table[] = {
-- 
2.41.3


