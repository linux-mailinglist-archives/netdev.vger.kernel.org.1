Return-Path: <netdev+bounces-147078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885199D756E
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 16:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B10C281A9B
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9AA2500BA;
	Sun, 24 Nov 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvgJAodM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5182500A8
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462879; cv=none; b=Ldf4H+QFjmi629hBBTwYdbdlQgGINPeCdTnkKnLCBM113+h4VaE9rOq2aoe1Ot7W88GfqnavplRcByxZR/kg+0rQgve276UVmp/Nz60jPHFATtPMUHrI590UP4smvZKcpNEemEx/ZEWXdLzhjKIMPglwfXovEmd3mGNXdgRDMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462879; c=relaxed/simple;
	bh=9kge41ycykT/5K/+bFAw+VkAwuhjcKqRCT7jd8uL1sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrO1xbi5TPPOVBQKKwSQ+FisuYgQMyC0QcJkZhny/qQ46ieo0a+SG6COBfgckj2RJpi/Yy9NYS2XHoNpEQvC5whVHpZaRgyghivw8z8VbAUs8cpDcDIbaeeSVjHbuRfMfEW5fOsgO3Y9S/OTZdSSats1Ij8rlPb/6tw9j4XoC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvgJAodM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732462876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0uS4d19/YPP/e1WqoOKVFItq0uiFJ3bpCHZxiI9/+k=;
	b=TvgJAodMuFdfS0UwgL8qOeHfGcETygXu0d646Jjy2oylk3NtFbwcK0Vah6uD26os7yR/MD
	uXMMoLbP4YlRuuN94HhrqkyGhg1DHL90ehxp/1BZrcTZP4c+jG+JMELi+CimIXhkQqxWp/
	JsHZxomFnrzr3Rj5j2CezlWm5XqAoE8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-Ae-VR1sPOqG6ve4rbNsowA-1; Sun,
 24 Nov 2024 10:41:12 -0500
X-MC-Unique: Ae-VR1sPOqG6ve4rbNsowA-1
X-Mimecast-MFC-AGG-ID: Ae-VR1sPOqG6ve4rbNsowA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D2101955F43;
	Sun, 24 Nov 2024 15:41:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69B891955F43;
	Sun, 24 Nov 2024 15:41:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v2 net 1/3] ipmr: add debug check for mr table cleanup
Date: Sun, 24 Nov 2024 16:40:56 +0100
Message-ID: <64f267b5c0dd74f5bc8795b4ff868b5b103741da.1732289799.git.pabeni@redhat.com>
In-Reply-To: <cover.1732289799.git.pabeni@redhat.com>
References: <cover.1732289799.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
v1 -> v2:
 - fix build errors with CONFIG_IP{,V6}_MROUTE_MULTIPLE_TABLES=n
---
 net/ipv4/ipmr.c  | 14 ++++++++++++++
 net/ipv6/ip6mr.c | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index c58dd78509a2..bac0776648e0 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -120,6 +120,11 @@ static void ipmr_expire_process(struct timer_list *t);
 				lockdep_rtnl_is_held() ||		\
 				list_empty(&net->ipv4.mr_tables))
 
+static bool ipmr_can_free_table(struct net *net)
+{
+	return !check_net(net) || !net->ipv4.mr_rules_ops;
+}
+
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
 					   struct mr_table *mrt)
 {
@@ -302,6 +307,11 @@ EXPORT_SYMBOL(ipmr_rule_default);
 #define ipmr_for_each_table(mrt, net) \
 	for (mrt = net->ipv4.mrt; mrt; mrt = NULL)
 
+static bool ipmr_can_free_table(struct net *net)
+{
+	return !check_net(net);
+}
+
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
 					   struct mr_table *mrt)
 {
@@ -413,6 +423,10 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 
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
index d66f58932a79..b80fca894916 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -108,6 +108,11 @@ static void ipmr_expire_process(struct timer_list *t);
 				lockdep_rtnl_is_held() || \
 				list_empty(&net->ipv6.mr6_tables))
 
+static bool ip6mr_can_free_table(struct net *net)
+{
+	return !check_net(net) || !net->ipv6.mr6_rules_ops;
+}
+
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
 {
@@ -291,6 +296,11 @@ EXPORT_SYMBOL(ip6mr_rule_default);
 #define ip6mr_for_each_table(mrt, net) \
 	for (mrt = net->ipv6.mrt6; mrt; mrt = NULL)
 
+static bool ip6mr_can_free_table(struct net *net)
+{
+	return !check_net(net);
+}
+
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
 {
@@ -392,6 +402,10 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 
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


