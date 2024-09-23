Return-Path: <netdev+bounces-129388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8DE98390E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 23:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41C31F2264C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE38405D;
	Mon, 23 Sep 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nRlFs12r"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067E83A17
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727126574; cv=none; b=cuiuKROkMNIR/gGyPGIyztPRs4yYXAH51vr4Bmr1IGXdWJoaDLY1SLfd/nlL2aJEnBZuk37AbnIXNUCnyBWjhay9DhFmInumPW8Y5hGMspLfJHtp2C5/CYIm+OalE3sev9b7DOqsRI6vgznHXgd8+VhFTnbqxgR1GjeQsHJlb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727126574; c=relaxed/simple;
	bh=2wTrx9lQFBB1b6KfdtLtTygEOVcngGV+uW04FxN5LDs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alAKHLgGfStuuP+xL/41aSzdgNSpUkJ+vC7nmBeVqyiwrzqjGS2HW7xBqDmpyUh/9vomjgfC+ifloJIsiqZ5+U6ecLHUoi83IEVVtxvI/Qy5JUfUtCmbyYQTL05ebyOQVztNi93Gzj3jcTxeKKwpVdAh1eIDJfNb5xzw1TKcrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nRlFs12r; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/HHDv/Y9G1BmPis07pM+5E/ePPOl6ikOHXfeG9x/G5Q=; b=nRlFs12rX3uyRd64RgsH3fbmAn
	10YfWo8vo6pt0KYel4HEzQg6xq89iD90pavJ6STCgFfonuArRveROK7YZBtt+Vcw39HFiv4Tb1cyn
	Dfv+3IvNUxfYT3ncOzzEmDlFrllnPiGmYXq+wuZJCFBeWzey9cVlDNGa6MfFKVYgInqIbggHNaplK
	nM0CIIcFuyPFQ9Iiq/TIPfp4KJ2WDZFGb9A80JPnPzyRIfw/z5Gcs9rs1a0ykMZRtTsWJBb0Imxao
	IGMhb67Yj260JSHxR+GHiRgsLSjq+cdviSToX/nmWIy7bJe4nsQdLTVLHT2iLeWJo7dh20rji4POm
	MX9wMgOQ==;
Received: from 54.249.197.178.dynamic.cust.swisscom.net ([178.197.249.54] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ssqW3-0003Y1-Ju
	for netdev@vger.kernel.org; Mon, 23 Sep 2024 23:22:43 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Subject: [PATCH net 2/2] net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_size
Date: Mon, 23 Sep 2024 23:22:42 +0200
Message-Id: <20240923212242.15669-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923212242.15669-1-daniel@iogearbox.net>
References: <20240923212242.15669-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27407/Mon Sep 23 10:31:24 2024)

Commit 24ab059d2ebd ("net: check dev->gso_max_size in gso_features_check()")
added a dev->gso_max_size test to gso_features_check() in order to fall
back to GSO when needed.

This was added as it was noticed that some drivers could misbehave if TSO
packets get too big. However, the check doesn't respect dev->gso_ipv4_max_size
limit. For instance, a device could be configured with BIG TCP for IPv4,
but not IPv6.

Therefore, add a netif_get_gso_max_size() equivalent to netif_get_gro_max_size()
and use the helper to respect both limits before falling back to GSO engine.

Fixes: 24ab059d2ebd ("net: check dev->gso_max_size in gso_features_check()")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/netdevice.h | 9 +++++++++
 net/core/dev.c            | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d571451638de..4d20c776a4ff 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5038,6 +5038,15 @@ netif_get_gro_max_size(const struct net_device *dev, const struct sk_buff *skb)
 	       READ_ONCE(dev->gro_ipv4_max_size);
 }
 
+static inline unsigned int
+netif_get_gso_max_size(const struct net_device *dev, const struct sk_buff *skb)
+{
+	/* pairs with WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
+	return skb->protocol == htons(ETH_P_IPV6) ?
+	       READ_ONCE(dev->gso_max_size) :
+	       READ_ONCE(dev->gso_ipv4_max_size);
+}
+
 static inline bool netif_is_macsec(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_MACSEC;
diff --git a/net/core/dev.c b/net/core/dev.c
index cd479f5f22f6..74cf78a6b512 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3512,7 +3512,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	if (gso_segs > READ_ONCE(dev->gso_max_segs))
 		return features & ~NETIF_F_GSO_MASK;
 
-	if (unlikely(skb->len >= READ_ONCE(dev->gso_max_size)))
+	if (unlikely(skb->len >= netif_get_gso_max_size(dev, skb)))
 		return features & ~NETIF_F_GSO_MASK;
 
 	if (!skb_shinfo(skb)->gso_type) {
-- 
2.43.0


