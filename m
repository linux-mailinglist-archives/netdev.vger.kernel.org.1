Return-Path: <netdev+bounces-146788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFBF9D5DB1
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 12:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084621F248A1
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEEE1DE4C5;
	Fri, 22 Nov 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGsliCVl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBD81DB54C
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273373; cv=none; b=iKFR3PlGjII7pLnJ1zJughjB0IxOagwfXIxbPBbhHm5LQEXccjj/zqvvl5qk1p1ng+H2k1LVWYJV7wbVw5AuLcFPep3B7hI/YyKa0Tdg3KELoWFZm1Blivy9ojmjYkkmWyEvNMdwM6iJZtlT5i4ZM404Wm9tzEBBdSikyGKNUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273373; c=relaxed/simple;
	bh=yd9Ubw3zCZ8QSnt2QLBEAPTwFdiGu1OMFUDvukbElqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwBNHm8Wt0SH/g9l7muBY7G1AJIYbe+QWC2rQtpTrlc9vG0CPpNx5KqAzy313NVk8zCaftIzM3MT3d5lQuIjop7HB59irZidCB8YBagLsjREKh0Wd0zZb5n6PCHO0NkxP5y4Xig8crCf5CEDDqvQQboX6+f4PhOep6f0fLNpthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGsliCVl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfF0igLRrIMpyyyAmWqcuTSSUQ8gXG/Ey6rmjr/zO4k=;
	b=AGsliCVlJ3cViF/pd+H8tLjHgnVd5FfgabVe7dGZmLmfp75grNrNHA1mQe5TXvDsu6+xMT
	GwgUkhKAb0UKwnJa9huaiXhimmRy79a/sQtZuLRiF514CLU/DUqescgbGNiBPgWEYYINW8
	fwROs6aMxrh36ZrP9TopRxe7A6dNyVY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-U-i52wRiMlSKnW1XDU0tSQ-1; Fri,
 22 Nov 2024 06:02:44 -0500
X-MC-Unique: U-i52wRiMlSKnW1XDU0tSQ-1
X-Mimecast-MFC-AGG-ID: U-i52wRiMlSKnW1XDU0tSQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A46311955D4D;
	Fri, 22 Nov 2024 11:02:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A98E195E481;
	Fri, 22 Nov 2024 11:02:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com
Subject: [PATCH net 1/3] ipmr: add debug check for mr table cleanup
Date: Fri, 22 Nov 2024 12:02:14 +0100
Message-ID: <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>
In-Reply-To: <cover.1732270911.git.pabeni@redhat.com>
References: <cover.1732270911.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The multicast route tables lifecycle, for both ipv4 and ipv6, is
protected by RCU using the RTNL lock for write access. In many
places a table pointer escapes the RCU (or RTNL) protected critical
section, but such scenarios are actually safe because tables are
deleted only at namespace cleanup time or just after allocation, in
case of default rule creation failure.

Tables freed at namespace cleanup time are assured to be alive for the
whole netns lifetime; tables freed just after creation time are never
exposed to other possible users.

Ensure that the free conditions are respected in ip{,6}mr_free_table, to
document the locking schema and to prevent future possible introduction
of 'table del' operation from breaking it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/ipmr.c  | 9 +++++++++
 net/ipv6/ip6mr.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index c58dd78509a2..c6ad01dc8310 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -358,6 +358,11 @@ bool ipmr_rule_default(const struct fib_rule *rule)
 EXPORT_SYMBOL(ipmr_rule_default);
 #endif
 
+static bool ipmr_can_free_table(struct net *net)
+{
+	return !check_net(net) || !net->ipv4.mr_rules_ops;
+}
+
 static inline int ipmr_hash_cmp(struct rhashtable_compare_arg *arg,
 				const void *ptr)
 {
@@ -413,6 +418,10 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 
 static void ipmr_free_table(struct mr_table *mrt)
 {
+	struct net *net = read_pnet(&mrt->net);
+
+	DEBUG_NET_WARN_ON_ONCE(!ipmr_can_free_table(net));
+
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
 				 MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index d66f58932a79..275784a8f35b 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -341,6 +341,11 @@ static unsigned int ip6mr_rules_seq_read(const struct net *net)
 }
 #endif
 
+static bool ip6mr_can_free_table(struct net *net)
+{
+	return !check_net(net) || !net->ipv6.mr6_rules_ops;
+}
+
 static int ip6mr_hash_cmp(struct rhashtable_compare_arg *arg,
 			  const void *ptr)
 {
@@ -392,6 +397,10 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 
 static void ip6mr_free_table(struct mr_table *mrt)
 {
+	struct net *net = read_pnet(&mrt->net);
+
+	DEBUG_NET_WARN_ON_ONCE(!ip6mr_can_free_table(net));
+
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 				 MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
-- 
2.45.2


