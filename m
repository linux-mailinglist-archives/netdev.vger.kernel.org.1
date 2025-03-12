Return-Path: <netdev+bounces-174160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFFBA5DA76
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AE83B04C9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1E723E25B;
	Wed, 12 Mar 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="ryYVo2lu"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66525235C16
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775581; cv=none; b=XsN2rUfbl2jsQ56MO7HkyI8pgevEqnF35GmLZyfzx7Uq4fAi5pXK9ZluMOGplEzfINiz5n9ICFMieYaaN+H6GjlOjqBt86ucMOkpKzVGUxmf+0w43tSnAc15KNwJ+s3fnhms5JGp1uXVyNugWqVxK9JvTU+eRc/WZv/+zSMpOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775581; c=relaxed/simple;
	bh=z+s+saa5berrbBkqU43r8VHMLvOgwJZQCJIAKyTrZ/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O4zE2D1YnYRF4eUBw0ylS69/SBHP4TfBucOCoRCxAKFDH9sNllSs3uuQJ2oDLjxpWfvrntjwfXf2TI+OGy07V9a857kSL5nCIG+QtijysDD+xUW5KtaV34I1hR7u4Ewc4D/VErB+7iThQFy7lzmbzo/DogFxHw0POH0oDCijWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=ryYVo2lu; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (unknown [195.29.54.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 890172012344;
	Wed, 12 Mar 2025 11:32:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 890172012344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741775576;
	bh=j+1HTuKxdXo54g0/bf2lu7FB150OdD/nQWHVE2IbmXg=;
	h=From:To:Cc:Subject:Date:From;
	b=ryYVo2lu2Y7RYB5uYXslFleRDgiqyyCHM/aFPXZDaXXR+bdRripBw6OvQsQbaVKQ8
	 cvGIsQ3gFLQwPBitQiSryBpUOlYZY2OTR3PkxXdKEjiKcB8pz7p1nlUE40UAek+LNY
	 w7Doqy165gaYtpmYZDmS6W8noMAopM1cbT5oIwUYtr4KGrwPgLO9NF9xAND8hDe9h8
	 XbL1L/RnFYnGfhCmwf7219qMpA3Op3NoSPa3Lb20OjTtd6VA+Goxmhf4lfkAC0K5/n
	 JSbWCTEWKC1sknAGxtEzp2uJhSQsuX+Gefiw7eJdbndUWa8o137aviUpz5d41ipfsk
	 ztySHExfHmyUQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@uliege.be,
	Roopa Prabhu <roopa@nvidia.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] net: lwtunnel: fix recursion loops
Date: Wed, 12 Mar 2025 11:32:46 +0100
Message-Id: <20250312103246.16206-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different kind of loops in most of lwtunnel users were fixed by some
recent patches. This patch acts as a parachute, catch all solution, by
detecting any use cases with recursion and taking care of them (e.g., a
loop between routes). This is applied to lwtunnel_input(),
lwtunnel_output(), and lwtunnel_xmit().

Fixes: ffce41962ef6 ("lwtunnel: support dst output redirect function")
Fixes: 2536862311d2 ("lwt: Add support to redirect dst.input")
Fixes: 14972cbd34ff ("net: lwtunnel: Handle fragmentation")
Closes: https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>
Cc: Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/core/lwtunnel.c | 65 ++++++++++++++++++++++++++++++++++++---------
 net/core/lwtunnel.h | 42 +++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 12 deletions(-)
 create mode 100644 net/core/lwtunnel.h

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 711cd3b4347a..0954783e36ce 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -23,6 +23,8 @@
 #include <net/ip6_fib.h>
 #include <net/rtnh.h>
 
+#include "lwtunnel.h"
+
 DEFINE_STATIC_KEY_FALSE(nf_hooks_lwtunnel_enabled);
 EXPORT_SYMBOL_GPL(nf_hooks_lwtunnel_enabled);
 
@@ -325,13 +327,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_cmp_encap);
 
 int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
+
+	if (lwtunnel_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
+		goto drop;
+	}
 
-	if (!dst)
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
 		goto drop;
+	}
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
@@ -341,8 +353,11 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->output))
+	if (likely(ops && ops->output)) {
+		lwtunnel_recursion_inc();
 		ret = ops->output(net, sk, skb);
+		lwtunnel_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
@@ -359,13 +374,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_output);
 
 int lwtunnel_xmit(struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
+
+	if (lwtunnel_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
+		goto drop;
+	}
 
-	if (!dst)
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
 		goto drop;
+	}
 
 	lwtstate = dst->lwtstate;
 
@@ -376,8 +401,11 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->xmit))
+	if (likely(ops && ops->xmit)) {
+		lwtunnel_recursion_inc();
 		ret = ops->xmit(skb);
+		lwtunnel_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
@@ -394,13 +422,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_xmit);
 
 int lwtunnel_input(struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
 
-	if (!dst)
+	if (lwtunnel_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
 		goto drop;
+	}
+
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
+		goto drop;
+	}
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
@@ -410,8 +448,11 @@ int lwtunnel_input(struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->input))
+	if (likely(ops && ops->input)) {
+		lwtunnel_recursion_inc();
 		ret = ops->input(skb);
+		lwtunnel_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
diff --git a/net/core/lwtunnel.h b/net/core/lwtunnel.h
new file mode 100644
index 000000000000..32880ecdd8bb
--- /dev/null
+++ b/net/core/lwtunnel.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _NET_CORE_LWTUNNEL_H
+#define _NET_CORE_LWTUNNEL_H
+
+#include <linux/netdevice.h>
+
+#define LWTUNNEL_RECURSION_LIMIT 8
+
+#ifndef CONFIG_PREEMPT_RT
+static inline bool lwtunnel_recursion(void)
+{
+	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
+			LWTUNNEL_RECURSION_LIMIT);
+}
+
+static inline void lwtunnel_recursion_inc(void)
+{
+	__this_cpu_inc(softnet_data.xmit.recursion);
+}
+
+static inline void lwtunnel_recursion_dec(void)
+{
+	__this_cpu_dec(softnet_data.xmit.recursion);
+}
+#else
+static inline bool lwtunnel_recursion(void)
+{
+	return unlikely(current->net_xmit.recursion > LWTUNNEL_RECURSION_LIMIT);
+}
+
+static inline void lwtunnel_recursion_inc(void)
+{
+	current->net_xmit.recursion++;
+}
+
+static inline void lwtunnel_recursion_dec(void)
+{
+	current->net_xmit.recursion--;
+}
+#endif
+
+#endif /* _NET_CORE_LWTUNNEL_H */
-- 
2.34.1


