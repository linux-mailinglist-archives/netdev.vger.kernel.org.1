Return-Path: <netdev+bounces-129387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2739F98390D
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 23:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CEB1F22384
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D278C73;
	Mon, 23 Sep 2024 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="dM14rxXn"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0629745CB
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126573; cv=none; b=DrkVOGE0/iVDv6poJOcKSVxBSFmWLWGXz12sMD8NfJ3yhzXxdhauY53a4PXZ681H8sQmX61hY+B/GZl9stFtHUcV2xPYIrq/8BQbp5Qs/B/DBA59Hhb4NQc/5ElmR28rumXYyI1mSXwJFxNDYNUp9KLsJ3kns2vwZGfhPIWFsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126573; c=relaxed/simple;
	bh=YKSgJUNooT/zxXsPHOwp8JaXCPTqx5rP4Mo7+yjXOBg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZtLL6TUNtI73W68/Ck6+0sPYb9w7e0HF1pKpAkdZ6kfrogYCDwwqlnINB9lw2yb9Utdwp88MVKy1+7DlUcBS5H9yPTcqBWIpN4WSPn4/7u8UQEDixFVLOPLIhhmfc65xYMG9KW6F6foEGj+gXzEvT6Vm3LLJDe9rnb9qXbAWQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=dM14rxXn; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=QPBq4yCD532rP6/iKdtDoaqc/wl/evF9tp3pn6DYvTQ=; b=dM14rxXnp8Qw6Ata3lple/K+C2
	tmVtswpQRIH2jmevIy7E+ArmuMHa9ksV3+cVDNlZHWhiFyCkg4LY1+69hEq61dlvUcjXT7eoKMzaw
	JrOW0+SjRZf4RHul0GUR3nf5FMkOllQ+xXKoFyOnT6KEauvRe2foXhP7viIWMMUvQ50KTsqbh06hz
	ePSXZJcNuiMS1YjLMM3wHguAOZfLKxO8pnltBoWiW8ioPozYwVVX19lWkWWLpTObPa13H3qIf1wqI
	lqYURmuI98Dd8u31GLggd6x/ncAqMy6E5V1pPw41F2KCcTCNJhNn/8MGNbRgJuVemBb9ep0syg73O
	bDZD2FWg==;
Received: from 54.249.197.178.dynamic.cust.swisscom.net ([178.197.249.54] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ssqW3-0003Xv-8A
	for netdev@vger.kernel.org; Mon, 23 Sep 2024 23:22:43 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Subject: [PATCH net 1/2] net: Add netif_get_gro_max_size helper for GRO
Date: Mon, 23 Sep 2024 23:22:41 +0200
Message-Id: <20240923212242.15669-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27407/Mon Sep 23 10:31:24 2024)

Add a small netif_get_gro_max_size() helper which returns the maximum IPv4
or IPv6 GRO size of the netdevice.

We later add a netif_get_gso_max_size() equivalent as well for GSO, so that
these helpers can be used consistently instead of open-coded checks.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/netdevice.h | 9 +++++++++
 net/core/gro.c            | 9 ++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e87b5e488325..d571451638de 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5029,6 +5029,15 @@ void netif_set_tso_max_segs(struct net_device *dev, unsigned int segs);
 void netif_inherit_tso_max(struct net_device *to,
 			   const struct net_device *from);
 
+static inline unsigned int
+netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
+{
+	/* pairs with WRITE_ONCE() in netif_set_gro(_ipv4)_max_size() */
+	return skb->protocol == htons(ETH_P_IPV6) ?
+	       READ_ONCE(dev->gro_max_size) :
+	       READ_ONCE(dev->gro_ipv4_max_size);
+}
+
 static inline bool netif_is_macsec(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_MACSEC;
diff --git a/net/core/gro.c b/net/core/gro.c
index 802b4a062400..d1f44084e978 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -98,7 +98,6 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	unsigned int headlen = skb_headlen(skb);
 	unsigned int len = skb_gro_len(skb);
 	unsigned int delta_truesize;
-	unsigned int gro_max_size;
 	unsigned int new_truesize;
 	struct sk_buff *lp;
 	int segs;
@@ -112,12 +111,8 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	if (p->pp_recycle != skb->pp_recycle)
 		return -ETOOMANYREFS;
 
-	/* pairs with WRITE_ONCE() in netif_set_gro(_ipv4)_max_size() */
-	gro_max_size = p->protocol == htons(ETH_P_IPV6) ?
-			READ_ONCE(p->dev->gro_max_size) :
-			READ_ONCE(p->dev->gro_ipv4_max_size);
-
-	if (unlikely(p->len + len >= gro_max_size || NAPI_GRO_CB(skb)->flush))
+	if (unlikely(p->len + len >= netif_get_gro_max_size(p->dev, p) ||
+		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
-- 
2.43.0


