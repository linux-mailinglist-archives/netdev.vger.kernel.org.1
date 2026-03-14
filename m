Return-Path: <netdev+bounces-267725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CBTKgpNtWmzywAAu9opvQ
	(envelope-from <netdev+bounces-267725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FE428CF47
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85EA330162B9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088092522BA;
	Sat, 14 Mar 2026 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4yP4OWX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694C48CFC
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489414; cv=none; b=kBsmQjfoMIJAnziWJxiZ5sDVBUq33tjDmZ8Q12M00WCx68gxsJ5Q/cEWM7RDQ4iSj2ljg3HLPurMvoFbZHBQC5EgrjS0espK7v00kSY2e3dx3oHfEHXPYjsxueKelziJ1eq15v5Gg6lwp2RtxAMNo3hZHqQh/X64EJDgbf9N1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489414; c=relaxed/simple;
	bh=pP75kO6vPv0MWx3b/jk5tZIik1MXV8W4LQvMd82xdxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cUlwG0UP/EZFgaMy2ns7RfSzkwRmsuQeVzaBMm2g8JtJiGsdArDoNIWY95rWiZi2ejy2ATE9UV54HaTgzgGv1FgMh1JidoKequUNeFz6weYNCLBxl/6kEgQsSG+cHl0A41gq+P163xbjKqGYrgyi2+CtSbRwKoNfSkZ/+itgQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4yP4OWX; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cd849cd562so1939506285a.0
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773489412; x=1774094212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LKBeBEoLcApOkEQBBetvKpB9SI2DjW3ITbfJc81y8lA=;
        b=C4yP4OWXbs8HgWjoeF3vOjwaawBsoGzTLab7ABceCH2+sDoGMDBpgMY1z9COScXLNj
         3JAGK7pFBZW2E6h8vyxOU8De6GS0QRm0QsRTxBX0lVN7jyO42Je0PWP6q6T0PhsnLle9
         GHfw+hrVEYlAwYFyR/6TP08ZmRKhR7q1yONzpPN4jzsxgXHzvJWLjPNYr4OQjQK2G9f3
         Q4NT96nDwcuoP4pn8uUnpllKYP9VedlUVDxu4RlEa1e90eCupWvcIUHc4EXPZVT+cgQ+
         8Ags+VSMDjz4yItq+0TPI/fPUWAL62+1TyrNB9BuKxWO6QKj4+CmzEFqedbuEja4lXUz
         Twig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773489412; x=1774094212;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LKBeBEoLcApOkEQBBetvKpB9SI2DjW3ITbfJc81y8lA=;
        b=YPaLNKX7peXqgK+4zZ+KpXiqgZATxtpXKVI3KLZhO0D4OslVyTujHdc/pZni+y2ih6
         w6B3nKRR2uVXoRBKLtnp4JaYDBTVQOj5hFQ/eRh0aCCXddkJvhy79QV3aG6OLy1IxZtB
         IOVJaaOQwEjkR/54VZ9FrqfFUgIqWTK5u66UZy9P/NJGbuVZZksEWTcHYzk1H3/sl+lZ
         RTdySehjYbZC7Qbd/pBelL+rIzjD3VyCWF+FeUBkRNib9zqkQWvhRbqwpHPAHpnJlNcw
         AMAP14mBCNcf78T9v5Lo2F9QLOluy7nIHIVi7zo2qUVPE86gTxSR5+9ZAcvNN6fzv+Kn
         a43Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRgejLgOO6eDaCiB3X0ZxlxcN2WyavKIeaJj68vwsGorEXek6BxH1gwJ6ezPPzDU4ab896+Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/9Mxc5b02UCR37nur47R7Zqvqia1oBgIIEPXkPBjoTdiYNZ6V
	ASDhYKKJCHgizciXLyF5FEz5qVFtjdKYvZrRcZyFQUtHTos7COycDu5Jb7GqJ6NsjHiWN5om2vd
	7KsTVbUIJzcAYAA==
X-Received: from qkkc21.prod.google.com ([2002:a05:620a:11b5:b0:8cd:86c4:1295])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46a9:b0:8c7:eb5:8528 with SMTP id af79cd13be357-8cdb5a4fad0mr889220485a.1.1773489412147;
 Sat, 14 Mar 2026 04:56:52 -0700 (PDT)
Date: Sat, 14 Mar 2026 11:56:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260314115650.3646361-1-edumazet@google.com>
Subject: [PATCH net] bonding: prevent potential infinite loop in bond_header_parse()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,shopee.com,jvosburgh.net,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267725-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 23FE428CF47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bond_header_parse() can loop if a stack of two bonding devices is setup,
because skb->dev always points to the hierarchy top.

Add new "const struct net_device *dev" parameter to
(struct header_ops)->parse() method to make sure the recursion
is bounded, and that the final leaf parse method is called.

Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/firewire/net.c          | 5 +++--
 drivers/net/bonding/bond_main.c | 8 +++++---
 include/linux/etherdevice.h     | 3 ++-
 include/linux/if_ether.h        | 3 ++-
 include/linux/netdevice.h       | 6 ++++--
 net/ethernet/eth.c              | 3 ++-
 net/ipv4/ip_gre.c               | 3 ++-
 net/mac802154/iface.c           | 4 +++-
 net/phonet/af_phonet.c          | 5 ++++-
 9 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/net.c b/drivers/firewire/net.c
index f1a2bee39bf113fe78f4640ba92a7b4e602c213a..82b3b6d9ed2df6423d5cb7a35282d01775e6cee5 100644
--- a/drivers/firewire/net.c
+++ b/drivers/firewire/net.c
@@ -257,9 +257,10 @@ static void fwnet_header_cache_update(struct hh_cache *hh,
 	memcpy((u8 *)hh->hh_data + HH_DATA_OFF(FWNET_HLEN), haddr, net->addr_len);
 }
 
-static int fwnet_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int fwnet_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+			      unsigned char *haddr)
 {
-	memcpy(haddr, skb->dev->dev_addr, FWNET_ALEN);
+	memcpy(haddr, dev->dev_addr, FWNET_ALEN);
 
 	return FWNET_ALEN;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 707419270ebf217a71b0593880c7a9a1481b7171..33f414d03ab913c58cf2406a4ab25e611c528159 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1530,9 +1530,11 @@ static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
 	return ret;
 }
 
-static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int bond_header_parse(const struct sk_buff *skb,
+			     const struct net_device *dev,
+			     unsigned char *haddr)
 {
-	struct bonding *bond = netdev_priv(skb->dev);
+	struct bonding *bond = netdev_priv(dev);
 	const struct header_ops *slave_ops;
 	struct slave *slave;
 	int ret = 0;
@@ -1542,7 +1544,7 @@ static int bond_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 	if (slave) {
 		slave_ops = READ_ONCE(slave->dev->header_ops);
 		if (slave_ops && slave_ops->parse)
-			ret = slave_ops->parse(skb, haddr);
+			ret = slave_ops->parse(skb, slave->dev, haddr);
 	}
 	rcu_read_unlock();
 	return ret;
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 9a1eacf35d37087ba8877bf31c017445929041ed..df8f88f63a7063fbd1df5248d2fc02c859a7bc74 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -42,7 +42,8 @@ extern const struct header_ops eth_header_ops;
 
 int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
 	       const void *daddr, const void *saddr, unsigned len);
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr);
 int eth_header_cache(const struct neighbour *neigh, struct hh_cache *hh,
 		     __be16 type);
 void eth_header_cache_update(struct hh_cache *hh, const struct net_device *dev,
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 61b7335aa037c7232a0caa45572043057c02dde3..ca9afa824aa4faf832658043bda6fb430633e476 100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -40,7 +40,8 @@ static inline struct ethhdr *inner_eth_hdr(const struct sk_buff *skb)
 	return (struct ethhdr *)skb_inner_mac_header(skb);
 }
 
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr);
 
 extern ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int len);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d7aac6f185bcab8a93a204c349272fc7c1b15ee7..7ca01eb3f7d2b22a188502583dc95121adff7cc9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -311,7 +311,9 @@ struct header_ops {
 	int	(*create) (struct sk_buff *skb, struct net_device *dev,
 			   unsigned short type, const void *daddr,
 			   const void *saddr, unsigned int len);
-	int	(*parse)(const struct sk_buff *skb, unsigned char *haddr);
+	int	(*parse)(const struct sk_buff *skb,
+			 const struct net_device *dev,
+			 unsigned char *haddr);
 	int	(*cache)(const struct neighbour *neigh, struct hh_cache *hh, __be16 type);
 	void	(*cache_update)(struct hh_cache *hh,
 				const struct net_device *dev,
@@ -3445,7 +3447,7 @@ static inline int dev_parse_header(const struct sk_buff *skb,
 
 	if (!dev->header_ops || !dev->header_ops->parse)
 		return 0;
-	return dev->header_ops->parse(skb, haddr);
+	return dev->header_ops->parse(skb, dev, haddr);
 }
 
 static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 13a63b48b7eeb896dfe98eb0070a261eed2c384b..9d159d1cc57d42747f794cdf43fe0ccaf04818b2 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -198,7 +198,8 @@ EXPORT_SYMBOL(eth_type_trans);
  * @skb: packet to extract header from
  * @haddr: destination buffer
  */
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+		     unsigned char *haddr)
 {
 	const struct ethhdr *eth = eth_hdr(skb);
 	memcpy(haddr, eth->h_source, ETH_ALEN);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e13244729ad8d5b1c2b9c483d25bff0e438134b5..35f0baa99d4092fd499a4795f7f52db33a1fe4e2 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -919,7 +919,8 @@ static int ipgre_header(struct sk_buff *skb, struct net_device *dev,
 	return -(t->hlen + sizeof(*iph));
 }
 
-static int ipgre_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int ipgre_header_parse(const struct sk_buff *skb, const struct net_device *dev,
+			      unsigned char *haddr)
 {
 	const struct iphdr *iph = (const struct iphdr *) skb_mac_header(skb);
 	memcpy(haddr, &iph->saddr, 4);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9e4631fade90c980887803f313727e9ff943bc73..000be60d9580343e40f33ff872ec0aff7daa41d0 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -469,7 +469,9 @@ static int mac802154_header_create(struct sk_buff *skb,
 }
 
 static int
-mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+mac802154_header_parse(const struct sk_buff *skb,
+		       const struct net_device *dev,
+		       unsigned char *haddr)
 {
 	struct ieee802154_hdr hdr;
 
diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index 238a9638d2b0f6a23070b0871515302d8cba864f..d89225d6bfd3bf7668edf3d0fe563f7bbc97de2c 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -129,9 +129,12 @@ static int pn_header_create(struct sk_buff *skb, struct net_device *dev,
 	return 1;
 }
 
-static int pn_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+static int pn_header_parse(const struct sk_buff *skb,
+			   const struct net_device *dev,
+			   unsigned char *haddr)
 {
 	const u8 *media = skb_mac_header(skb);
+
 	*haddr = *media;
 	return 1;
 }
-- 
2.53.0.851.ga537e3e6e9-goog


