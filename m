Return-Path: <netdev+bounces-274869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NQDEjc/z2kXuQYAu9opvQ
	(envelope-from <netdev+bounces-274869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:16:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F45390DC2
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FA7A304D168
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ACA328B56;
	Fri,  3 Apr 2026 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikRGuc3U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18921E098
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775189809; cv=none; b=asQoQRrFjockOUluN89JFTclbHF+MxPpK/JujF8kvpmnhsnIYGkJBTF+wMUnVMVHJc85bZVxQANx/dCpejnqqGsxrb2FuDq7pxpzugQUk3MFyyUji42xLSW+D6+CjYaEaothiK5c9kfrmP4AbUhFHxbOMb87J9EOEvvDmg4LQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775189809; c=relaxed/simple;
	bh=fnqr5UOuAfebwo8BpmSgyzILoSQtU6SG3QkUylLJMiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fCzgMVaY57yVHYFy/xNL+9Rpt7WMGrAO0EwRdUrsG2RP7DxUMs/auZhWd5/MGWfunFS+nIkE5bAcKQw7zjcnLJThpDQNNPeKA6mq7o9greOFTfRH0Cyo9VZbXvg7RjuFnAPMqh5TP7GEg1SQsgKq+J99vNYko0kV6doBvUKFWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikRGuc3U; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d99bae2ebso1418139a91.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775189807; x=1775794607; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXVZkuhBWXEwn4z3S43lrOQR7Q6avoG4dw9buzZLIB4=;
        b=ikRGuc3U001C6JBTy7FvD/UbWxSB7eEChvJKpsabxmHX0RY9U/nozHGiADjmlrzCX6
         Me3R+jTPsSVv2cmjlh1KjebJwZj1jtJxtSNI4YWn+EvNAeqQwcuO7ZrT/I/BcoA+9Dbj
         XR8twvgTV0MCY81AMy0lMxDw7ff906bVt1cuFV6XhoyESDUFP6BKYj/O/aTCNmmaSXzt
         KwsTrCVXijFJauhPIne/cilKjLy7w79TYdbm1QXnu2AL4pVrElv6sWBjgLTEVKTqLA8t
         Pcl6zLpbn4gKp0pg3GqW2JJqtl8IuosgwI0jWhxkwFX3UXzIonbJFxDUYnSfmmoOYf5N
         fqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775189807; x=1775794607;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXVZkuhBWXEwn4z3S43lrOQR7Q6avoG4dw9buzZLIB4=;
        b=Vq74ATn8+Yx1qsGmPUqDxCan2kBkU2WZr8jOtDnTYy8P5ktCFbDdMIIiK38YWGJJM3
         k55Gbg3QO2/8CKWoZLmg84qwCv9sP8a4epcSdKWjTzHAmadeUPzfJqjA9tb7qSnncWOH
         DmMApo2y7UobT+BHf4OH85JD1NTUGkxZ14JV2zj0HJnxGTrkNO08/mG0uqhfBsQ3ZQMZ
         1ivttaKyRZv/qm2WPBNPgBd5KwoqoepAPSIZUfzdR/bSNKX8L01PHivvWZkym9W2poZq
         S5g9A5hgA2RL/+1GoTLdp42GMYCqbgOVvidwybreU8Sy9tVo12OrPrn1D25YHbK0TpMO
         4K9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbrkZOik7q9rQwOq24OvHR8JC32IZanPUtzRgzTwmjM7GqdZR88nyyZ1aVsIUT0qCI33O6ZVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0+C/1oWWlx+L2N7XK6xJ7BRL5Zkk4l1sZs8scrFnUPF3qd/k
	76iy5CIOK+6fbYjtjvP9zuXfeNdauA0nb6bom/13TNw0YVPfQJNhYVEo
X-Gm-Gg: AeBDievTrZThRk2pXeAgFJobObbX0G0CXjSlqeGlJ+CxmewwRapmwZSVVCU7hd2OHXC
	tMJAeHmSG56KlRKW6zLD6eg9FKUgSQfYVdoH3hXTmOMd5AsS+ZH3qfu8x0ySmJePhXumaW6IXXn
	9Uc41UmwZ+Bg0AcwreWU5snQWHX/5EeRKmh/CDvpRTijiACAj6/jhss7BhXo936NKB4sTHMyv4L
	nKU/Xn6CnmjxnpsIpQuffjvehSQMM9mZMWY773TEEt49GJYmmSSjqEJxJA3INIVK9iL6la8+30H
	Mz8haLjHUPauJtAFgNrCRQ2fA9hgHZ5VnR+giuV9ymblNWafVZRW7a42NP0/c3vMxhWFWYVppH/
	GtLD+WegIlJ8KUEMfA1+Hq3QsJdnpzl2DXxTkm3K4IXl3c/s1wdpfMyCJ6/MCZo7lhQsBxCpd9W
	Gsa+vODX9thfts71JQVDU3EM+nJ1npgNs3R3zYenefozR4zL/u
X-Received: by 2002:a17:902:c942:b0:2b2:4e5a:9471 with SMTP id d9443c01a7336-2b281896db4mr19035675ad.22.1775189806940;
        Thu, 02 Apr 2026 21:16:46 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27475bc2asm48626315ad.19.2026.04.02.21.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 21:16:46 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Fri, 03 Apr 2026 12:16:38 +0800
Subject: [PATCH net] ipv6: add READ_ONCE() annotations to fib6_metrics
 reader paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-fib6_metric_read_once-v1-1-45de44912b24@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrBuIQ6rQq5QSkvinzqKxTEQE8
 e4Gl9/ivYMqVFDp1R2k2KTKUhr6R0dpDuULI1MzseXBOtubLHHwP6wqySvC5JeSYEbOHGN4umC
 ZWvtXZNnv75sKVvqc5wU2s4pZbAAAAA==
X-Change-ID: 20260401-fib6_metric_read_once-72f2bba54a02
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-274869-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: B0F45390DC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All reader paths that access fib6_metrics on a shared fib6_info need
READ_ONCE() annotations to prevent the compiler from reloading the
pointer and producing inconsistent views.

Without READ_ONCE() in the readers, the compiler may reload fib6_metrics
between two uses. For example, in rt6_set_from(), ip_dst_init_metrics()
is inlined and references fib_metrics twice. If the first load sees
&dst_default_metrics and a subsequent load sees the newly allocated
pointer p, dst->_metrics could end up incorrectly flagged, e.g.

  (&dst_default_metrics) | DST_METRICS_READ_ONLY | DST_METRICS_REFCOUNTED

Fix all reader paths on shared fib6_info objects:

Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 include/net/ip6_fib.h |  4 +++-
 net/ipv6/ip6_fib.c    |  6 ++++--
 net/ipv6/route.c      | 18 +++++++++++-------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 9f8b6814a96a..2dfb04fab5da 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -594,7 +594,9 @@ void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i);
 void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val);
 static inline bool fib6_metric_locked(struct fib6_info *f6i, int metric)
 {
-	return !!(f6i->fib6_metrics->metrics[RTAX_LOCK - 1] & (1 << metric));
+	struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
+
+	return !!(m->metrics[RTAX_LOCK - 1] & (1 << metric));
 }
 void fib6_info_hw_flags_set(struct net *net, struct fib6_info *f6i,
 			    bool offload, bool trap, bool offload_failed);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index dd26657b6a4a..3c96580c2a03 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1144,9 +1144,11 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 					iter->fib6_flags &= ~RTF_PREFIX_RT;
 				}
 
-				if (rt->fib6_pmtu)
+				u32 pmtu = READ_ONCE(rt->fib6_pmtu);
+
+				if (pmtu)
 					fib6_metric_set(iter, RTAX_MTU,
-							rt->fib6_pmtu);
+							pmtu);
 				return -EEXIST;
 			}
 			/* If we have the same destination and the same metric,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index cb521700cee7..002a7cda9f6b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1163,7 +1163,7 @@ static void rt6_set_from(struct rt6_info *rt, struct fib6_info *from)
 {
 	rt->rt6i_flags &= ~RTF_EXPIRES;
 	rcu_assign_pointer(rt->from, from);
-	ip_dst_init_metrics(&rt->dst, from->fib6_metrics);
+	ip_dst_init_metrics(&rt->dst, READ_ONCE(from->fib6_metrics));
 }
 
 /* Caller must already hold reference to f6i in result */
@@ -1635,11 +1635,12 @@ __rt6_find_exception_rcu(struct rt6_exception_bucket **bucket,
 static unsigned int fib6_mtu(const struct fib6_result *res)
 {
 	const struct fib6_nh *nh = res->nh;
+	struct dst_metrics *m;
 	unsigned int mtu;
 
-	if (res->f6i->fib6_pmtu) {
-		mtu = res->f6i->fib6_pmtu;
-	} else {
+	m = READ_ONCE(res->f6i->fib6_metrics);
+	mtu = READ_ONCE(m->metrics[RTAX_MTU - 1]);
+	if (!mtu) {
 		struct net_device *dev = nh->fib_nh_dev;
 		struct inet6_dev *idev;
 
@@ -3300,7 +3301,9 @@ u32 ip6_mtu_from_fib6(const struct fib6_result *res,
 	u32 mtu = 0;
 
 	if (unlikely(fib6_metric_locked(f6i, RTAX_MTU))) {
-		mtu = f6i->fib6_pmtu;
+		struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
+
+		mtu = READ_ONCE(m->metrics[RTAX_MTU - 1]);
 		if (mtu)
 			goto out;
 	}
@@ -5037,7 +5040,8 @@ static int fib6_nh_mtu_change(struct fib6_nh *nh, void *_arg)
 	 */
 	if (nh->fib_nh_dev == arg->dev) {
 		struct inet6_dev *idev = __in6_dev_get(arg->dev);
-		u32 mtu = f6i->fib6_pmtu;
+		struct dst_metrics *m = READ_ONCE(f6i->fib6_metrics);
+		u32 mtu = READ_ONCE(m->metrics[RTAX_MTU - 1]);
 
 		if (mtu >= arg->mtu ||
 		    (mtu < arg->mtu && mtu == idev->cnf.mtu6))
@@ -5844,7 +5848,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 			goto nla_put_failure;
 	}
 
-	pmetrics = dst ? dst_metrics_ptr(dst) : rt->fib6_metrics->metrics;
+	pmetrics = dst ? dst_metrics_ptr(dst) : READ_ONCE(rt->fib6_metrics)->metrics;
 	if (rtnetlink_put_metrics(skb, pmetrics) < 0)
 		goto nla_put_failure;
 

---
base-commit: 48b3cd69265f346f64b93064723492da46206e9b
change-id: 20260401-fib6_metric_read_once-72f2bba54a02

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


