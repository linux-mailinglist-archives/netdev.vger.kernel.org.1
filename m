Return-Path: <netdev+bounces-276936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGNRD2qE12muPAgAu9opvQ
	(envelope-from <netdev+bounces-276936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AEC3C9488
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A4113015C82
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5663BED32;
	Thu,  9 Apr 2026 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwfcPWkk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DF3BE15E
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731794; cv=none; b=Z9zcmnlo4AQCC6oMhB9qwNM7OBkpGMAvitgAZuEtSsw/hrZ4X5d73WOye1F+c3e9A3CxdHB7w3ErRSLy/c31zQRV9YpWMNQWxlWUphXWJIWjwyCAqt78UbmMQ7khZguEBo6TbS66fJuoBZ8gHLsbIykgw0wzKXgtfwZildP24sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731794; c=relaxed/simple;
	bh=JNT33Wmq43E/C5jtUNTbbsnfLcnJM8zf0ttEv/gKCIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cm+Sif9YNwJJWR8ODMZwUSu1Bxl37H023vwXvFmu57gYXknjUQzJXfFcbk9iXMdlj9+8vevYlfOxn+UjxdE67WMSCsQMGkO1toEX7O5gzELR/ptwsxFppq0EuZCmXnlRZ/sNtNo4P+1OLDNK1tK4elL9wZLjfYwN8XZW3wJ+n4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwfcPWkk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d932cc948so573655a91.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775731791; x=1776336591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ukbyd6N1MhmvxaPd3moBUEUJpBd5mNCDxCGpsq2J5LA=;
        b=WwfcPWkkwJgxDug0ekTYyXrV/xouXrB9HBUMAfrkdkjELiDzkLUX2IODG1upfUYKYS
         jQg2msyCQT2bCu989fFE1Fo3LBhWrj24SXXnKNVBEmtaYBzici0xmgW4x7yUQCsmr4Ng
         dUmgiCYZ1N0VcOTT3NuU09Ox/EjbbNq2zYCgLagY68DHcXt8h5101pDtWyWLJ2Y2eZTH
         ocM91IvDxQV1T59o+yWxCbdcPLiSTgLfGp7zmk9TMjf8XsNpBs9AHYYkgyCui7svfK+N
         ZGGrjjL8LlptLrTzzzI2MmViOu5jDKgOZ1Jn38iEOLJY6o8poGqBvKW+pdqV+EAlDsw6
         1K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775731791; x=1776336591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ukbyd6N1MhmvxaPd3moBUEUJpBd5mNCDxCGpsq2J5LA=;
        b=hJEQCJ8ffGSHRPBW2L7D8hnaYD5FILP9qlJx/cEfUWDhZvKLhP4QZo1ETV0RdEi+90
         rO0jz1858Rfe2Tm/G9TwfyxBysN0NEzlcdMeY8hBVLbgp+fifJ6NxoyuYS10CYLiJUhE
         k+LZMTtCiSa4mkzbXtM0I1hVGOQFBsbXGeoLE8XUuxqnZX6KOgYrfmpGFK5oYghKjPVD
         49ZLHNZCLrH3XdmaTz+NALRAEdJMNTVS39vdGNuXmk1PAFA+6v23GW0LO0sgz/i+sWGY
         c9Xx8VAJ5soP7eOFZiatg36CGYoMaufdo8j8eEpu5unS6VsI8dWZRaJgsvo0e0PHx9wj
         ggpg==
X-Forwarded-Encrypted: i=1; AJvYcCUZZ2tExVvCT8sG15O9bjGBa3RZmy6WKAVGSACqOtty3s5FSYw7wXQ7/JXJyv+aW6SgfKLGkdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8vi8PdFREoFQDBrY/CqFvwoRNxc24RhV1bc9rl+kohO+FkuC
	jWfec8K2VTuQyXYsCdYX4AVYau91nJT/p+WpFmN5C6CTKnsuzc4r7VKn
X-Gm-Gg: AeBDiet4BrK0l+gRASjEHgj+UA04ZNok6BRPVYD2KsAowPbT2xSelrsJtuS0bVKiXdF
	GuuTKr9wPcVGPX2NTqTDPqXrAKh4O3+H406D6Ew3hTHTZEJBuc14luvpCfs4tBP9Kjqrc+g0Gcc
	knjp3xVKJ7EC9kdgf1TILb9n/PGU2VlBON654Lrpn78VccfVgHrl2/JCX1fPo2nSYpddSbyiWrE
	Y/QxT+nX2p6BOQIFoa5X+lIYcel+q0Jq4OdUDNtGr71Nx3m0xPFZvcACJtjoA0cxXsjWsmxzpAN
	EpdQEwUHbWHeUOtZRg1zoEyezNzJ5Fp9qIoHwwcDalausJ1TREGLdD4nLdXS/5WtjDbd/sPstf/
	9U6c3jpDGj4FpemJgwGi4rdfYnxRdarSkUaqOfi4/KoHy4j2PFXCoOi0mctdy6ReOiJSbHLR4Hq
	tscBOcO+4uAriiSMbSR0V3y0USOrnIm8k25kHCQMZbpswi40axfAuNrDmKDQ+bQpaWThk4mwOwJ
	Y+iFTnDp0Qi
X-Received: by 2002:a17:90b:5585:b0:355:35b0:8b78 with SMTP id 98e67ed59e1d1-35de69a6545mr23786223a91.27.1775731790627;
        Thu, 09 Apr 2026 03:49:50 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3503b278sm3724426a91.16.2026.04.09.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 03:49:50 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH v2] netfilter: nft_fwd_netdev: use recursion counter in neigh egress path
Date: Thu,  9 Apr 2026 18:49:12 +0800
Message-ID: <20260409104911.722698-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nwl.cc,kernel.org,vger.kernel.org,netfilter.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-276936-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: D2AEC3C9488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nft_fwd_neigh can be used in egress chains (NF_NETDEV_EGRESS). When the
forwarding rule targets the same device or two devices forward to each
other, neigh_xmit() triggers dev_queue_xmit() which re-enters
nf_hook_egress(), causing infinite recursion and stack overflow.

Move the nf_get_nf_dup_skb_recursion() accessor and NF_RECURSION_LIMIT
to the shared header nf_dup_netdev.h as a static inline, so that
nft_fwd_netdev can use the recursion counter directly without exported
function call overhead. Guard neigh_xmit() with the same recursion
limit already used in nf_do_netdev_egress().

Fixes: f87b9464d152 ("netfilter: nft_fwd_netdev: Support egress hook")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 include/net/netfilter/nf_dup_netdev.h | 13 +++++++++++++
 net/netfilter/nf_dup_netdev.c         | 16 ----------------
 net/netfilter/nft_fwd_netdev.c        |  7 +++++++
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/net/netfilter/nf_dup_netdev.h b/include/net/netfilter/nf_dup_netdev.h
index b175d271aec9..609bcf422a9b 100644
--- a/include/net/netfilter/nf_dup_netdev.h
+++ b/include/net/netfilter/nf_dup_netdev.h
@@ -3,10 +3,23 @@
 #define _NF_DUP_NETDEV_H_
 
 #include <net/netfilter/nf_tables.h>
+#include <linux/netdevice.h>
+#include <linux/sched.h>
 
 void nf_dup_netdev_egress(const struct nft_pktinfo *pkt, int oif);
 void nf_fwd_netdev_egress(const struct nft_pktinfo *pkt, int oif);
 
+#define NF_RECURSION_LIMIT	2
+
+static inline u8 *nf_get_nf_dup_skb_recursion(void)
+{
+#ifndef CONFIG_PREEMPT_RT
+	return this_cpu_ptr(&softnet_data.xmit.nf_dup_skb_recursion);
+#else
+	return &current->net_xmit.nf_dup_skb_recursion;
+#endif
+}
+
 struct nft_offload_ctx;
 struct nft_flow_rule;
 
diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
index fab8b9011098..a958a1b0c5be 100644
--- a/net/netfilter/nf_dup_netdev.c
+++ b/net/netfilter/nf_dup_netdev.c
@@ -13,22 +13,6 @@
 #include <net/netfilter/nf_tables_offload.h>
 #include <net/netfilter/nf_dup_netdev.h>
 
-#define NF_RECURSION_LIMIT	2
-
-#ifndef CONFIG_PREEMPT_RT
-static u8 *nf_get_nf_dup_skb_recursion(void)
-{
-	return this_cpu_ptr(&softnet_data.xmit.nf_dup_skb_recursion);
-}
-#else
-
-static u8 *nf_get_nf_dup_skb_recursion(void)
-{
-	return &current->net_xmit.nf_dup_skb_recursion;
-}
-
-#endif
-
 static void nf_do_netdev_egress(struct sk_buff *skb, struct net_device *dev,
 				enum nf_dev_hooks hook)
 {
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 152a9fb4d23a..492bb599a499 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -141,13 +141,20 @@ static void nft_fwd_neigh_eval(const struct nft_expr *expr,
 		goto out;
 	}
 
+	if (*nf_get_nf_dup_skb_recursion() > NF_RECURSION_LIMIT) {
+		verdict = NF_DROP;
+		goto out;
+	}
+
 	dev = dev_get_by_index_rcu(nft_net(pkt), oif);
 	if (dev == NULL)
 		return;
 
 	skb->dev = dev;
 	skb_clear_tstamp(skb);
+	(*nf_get_nf_dup_skb_recursion())++;
 	neigh_xmit(neigh_table, dev, addr, skb);
+	(*nf_get_nf_dup_skb_recursion())--;
 out:
 	regs->verdict.code = verdict;
 }
-- 
2.43.0


