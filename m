Return-Path: <netdev+bounces-174852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74366A61088
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6397F17EC3F
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C5A1FDA76;
	Fri, 14 Mar 2025 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="YK4uY8Si"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79051FE47D
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953668; cv=none; b=JU01x7TY2/V5dS5L+yZo5x3Ka6H1WrIllLlIIbb4+B+iy1RwsKKXLQrvB3RbS32eLRODa7VvF8t0sVB3sL9zUd+DwCshaOujrLjVw5GDg0yajJ6na9DzikLMmBrUlTMD14py5ru0lLCS6uOTODn8QLHYyD17t1HVa7/7QJwlESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953668; c=relaxed/simple;
	bh=b18UMJRvfo0LUJ0HY+cSESlLiDWA9MsGAeyS/qzO1RA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cxq7PL21EeROYTuiKFSSWwfYJKPOK1vcrMoXd2nJLymG3NxyFhnRdgqVraHjYzTieWtpxrxMQLtJFs/49yms28L6jOLsNzv8DADjeBIqV0yn328ovbfVCl2R402oTlOO6ysZtn3n2j6P4FRoqlDvl78Z+d+JNMoyt9aamsTINbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=YK4uY8Si; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (rtr-guestwired.meeting.ietf.org [31.133.144.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C5317200DB91;
	Fri, 14 Mar 2025 13:01:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C5317200DB91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1741953664;
	bh=b5fdA9EAkLiexYj+vQWIIIG1pENLs/bGS2pgO1nB+mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YK4uY8SisJO3FX8h8io4TMAsz14l+uEj0YA9wGLaOEnpskz0pNZ49aNPvMcRjL0St
	 vBVEpWFsNWpnPBIT391oggJu3ghO11rCs5cSVW8I8dmJMfcgxL3IhHcGkLfvTyra+z
	 CpQ5GKUQe1yqk/uq3X8qyR4Zr1+XKh2kwnHc4QGODGyIRvhOzroJquEnnhvYdkVem+
	 TwITk/uFpwkQWJXAr6ji6VtLJiHSU+U5JM5JpNZSbhP5JvmJf3lQPfxtWmc53EDiL6
	 o6l9eOrs35Mr9q5w8TK7XcbL5DYIRIjxTK3Ntumi5O8JjArIRuBL8m9PgT7pCslZRs
	 L6YUbfnlbm+ow==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
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
Subject: [PATCH net v2 1/3] net: lwtunnel: fix recursion loops
Date: Fri, 14 Mar 2025 13:00:46 +0100
Message-Id: <20250314120048.12569-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314120048.12569-1-justin.iurman@uliege.be>
References: <20250314120048.12569-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch acts as a parachute, catch all solution, by detecting
recursion loops in lwtunnel users and taking care of them (e.g., a loop
between routes, a loop within the same route, etc). In general, such
loops are the consequence of pathological configurations. Each lwtunnel
user is still free to catch such loops early and do whatever they want
with them. It will be the case in a separate patch for, e.g., seg6 and
seg6_local, in order to provide drop reasons and update statistics.
Another example of a lwtunnel user taking care of loops is ioam6, which
has valid use cases that include loops (e.g., inline mode), and which is
addressed by the next patch in this series. Overall, this patch acts as
a last resort to catch loops and drop packets, since we don't want to
leak something unintentionally because of a pathological configuration
in lwtunnels.

The solution in this patch reuses dev_xmit_recursion(),
dev_xmit_recursion_inc(), and dev_xmit_recursion_dec(), which seems fine
considering the context.

Closes: https://lore.kernel.org/netdev/2bc9e2079e864a9290561894d2a602d6@akamai.com/
Closes: https://lore.kernel.org/netdev/Z7NKYMY7fJT5cYWu@shredder/
Fixes: ffce41962ef6 ("lwtunnel: support dst output redirect function")
Fixes: 2536862311d2 ("lwt: Add support to redirect dst.input")
Fixes: 14972cbd34ff ("net: lwtunnel: Handle fragmentation")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>
Cc: Ahmed Abdelsalam <ahabdels.dev@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/core/lwtunnel.c | 65 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 711cd3b4347a..4417a18b3e95 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -23,6 +23,8 @@
 #include <net/ip6_fib.h>
 #include <net/rtnh.h>
 
+#include "dev.h"
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
+	if (dev_xmit_recursion()) {
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
+		dev_xmit_recursion_inc();
 		ret = ops->output(net, sk, skb);
+		dev_xmit_recursion_dec();
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
+	if (dev_xmit_recursion()) {
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
+		dev_xmit_recursion_inc();
 		ret = ops->xmit(skb);
+		dev_xmit_recursion_dec();
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
+	if (dev_xmit_recursion()) {
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
+		dev_xmit_recursion_inc();
 		ret = ops->input(skb);
+		dev_xmit_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
-- 
2.34.1


