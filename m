Return-Path: <netdev+bounces-305884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wj/YD197TmqPNgIAu9opvQ
	(envelope-from <netdev+bounces-305884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:31:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 843E0728BAD
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:31:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=VW6X0Jv4;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305884-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305884-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8F99303642B
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF134FF55;
	Wed,  8 Jul 2026 16:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174C134FF74
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:04:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526660; cv=none; b=rZODo2bf6pzfjHoJdpmjGfEGcETl4ROJjHReXtJ4eeAVEiNSTtsDNcDM2Am9MfwArgrVf9K3+YsjZTH6cdm8ckwvKeiBbXkHGzRwUCoCMRhA/uBt9jvoU6vsjq85w1/qJgrRuX7FkWqWquWSfQ8ybETtGHsQk3pBuqMlmWrulYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526660; c=relaxed/simple;
	bh=W3MKV2X5BZwACmAW+St6pK8AHiCsrWT1pK48cFYL6mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yj88IysqyRvTiYmyOPrzDAT8ekzZnM5DeF6M0xgwvmzn8rlZSLr7uD4jQqYkXT8rm1N/Rp4yAQozw36SOKaT3IQKnsBlWeRzkWsvSMzhCQKMT1epWweK6e3sLHcE5R9qy5c/r12btoQo+fuQpAPwoyj/bXZ1q4BU6df+t97C5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VW6X0Jv4; arc=none smtp.client-ip=209.85.161.74
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-6a37685f41aso381405eaf.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783526657; x=1784131457; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACbwBZ7xseICal4S12Gyq8sfqukQgLkdjvSbyWtn0tc=;
        b=VW6X0Jv4G41Y8JpfMtuklFqywnjflLi/bq2RVX/xXVU58BkECSd050gsylRWlhCyJB
         Clnj9p7ABvVublGs9Vj5UgDTYMVf4FZvl5cBY1YIWCXopju8MTkD+e8KnvpZfYYpHxMZ
         lbPfkqeSdRpfa/fc4uo7GaXhMjQYZvwTWsycHqWdjZsO+42dS4OeQ9tVY6dC0RBbAx+F
         L0TeJb8VsRsrNSiZWoTH050OoVMVJLiSqiapHpWGQAvTVHoNOBpcdVOAJXfQGVThsiRK
         1TSQG0YNEe+hkPrYJlgFom9dvqTjwwnRJylGULIA+7tywYgZvckfJSKHatTdqQjQZw5R
         sgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526657; x=1784131457;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACbwBZ7xseICal4S12Gyq8sfqukQgLkdjvSbyWtn0tc=;
        b=s1hmx83qfl0OMjGojrf9t6Xdf3vc7OO6lcBOr3qtOlaSIxdaLY+jGRtSPwAYewGdmL
         UF8U3fwlt8oWcQ7oZ9Ot06RezEZ0lVoyVSwqQrRPL0k922UaEpcUlj1ZFEwoufkwJryc
         nhDeS06qM4nOpK0dAuQbFX96RfRgaNwk2DbSL6xLG6E04B7q9jPuzhNrCKCd7ARIWqrI
         XV0rXL7Csr3BJ1rR1lphVJwSYGkmGiQVzBXfPDtik2MowJyrL5f1J15Yeux47dYWgEE6
         eHCnUZRGvQng1p5OUNpw1q0NZroLdoDb4/hUj4fOiqPggNfjIfa2RmELu1UvMP+JgZ3K
         YUYA==
X-Forwarded-Encrypted: i=1; AFNElJ+2nGtzxJ9Tp+I1qET3ZKnLnL5asKqwDYvqIeosRdoLuLgqD/N8AmzLDJwH7oe0JSuC9G/Jr/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rNrix8XEb4NV68f67NO3hS+iKJBB2rTAwYElF3uQh1dEJqVx
	CFUHOw7g0ZEsNeWj4sja1WAJ24PPdUP46rU+IpniDhcnVgY7i+tckmNR7pTyV6dBWTg6to6gNvL
	3pZ60kTjmHxQrYQ==
X-Received: from qvbjx9.prod.google.com ([2002:a05:6214:2b09:b0:8dd:6cbd:afab])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:1787:b0:6a1:58d0:d395 with SMTP id 006d021491bc7-6a36da5ebb2mr2130986eaf.43.1783526656570;
 Wed, 08 Jul 2026 09:04:16 -0700 (PDT)
Date: Wed,  8 Jul 2026 16:04:09 +0000
In-Reply-To: <20260708160411.1355008-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708160411.1355008-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708160411.1355008-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] vxlan: pass vxlan_config pointer to helper functions
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305884-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,lunn.ch,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 843E0728BAD

In preparation for converting vxlan->cfg to an RCU-protected pointer,
refactor internal helper functions in the RX, TX, MDB, VNIFILTER, and
OVS paths to accept a pointer to struct vxlan_config (or pass flags/
saddr_family where appropriate) rather than directly accessing
vxlan->cfg.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c      | 249 +++++++++++++++-------------
 drivers/net/vxlan/vxlan_mdb.c       |  20 ++-
 drivers/net/vxlan/vxlan_private.h   |   6 +-
 drivers/net/vxlan/vxlan_vnifilter.c |   5 +-
 net/openvswitch/vport-vxlan.c       |   7 +-
 5 files changed, 158 insertions(+), 129 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 67c367cc566233e809b0f70e0d939dd1c1ac0d9f..eb2608fb7139a18d905d9b1a5140f22a880818d6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -377,14 +377,15 @@ static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
 
 /* Look up Ethernet address in forwarding table */
 static struct vxlan_fdb *vxlan_find_mac_rcu(struct vxlan_dev *vxlan,
+					    const struct vxlan_config *cfg,
 					    const u8 *mac, __be32 vni)
 {
 	struct vxlan_fdb_key key;
 
 	memset(&key, 0, sizeof(key));
 	memcpy(key.eth_addr, mac, sizeof(key.eth_addr));
-	if (!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA))
-		key.vni = vxlan->default_dst.remote_vni;
+	if (!(cfg->flags & VXLAN_F_COLLECT_METADATA))
+		key.vni = cfg->vni;
 	else
 		key.vni = vni;
 
@@ -393,11 +394,12 @@ static struct vxlan_fdb *vxlan_find_mac_rcu(struct vxlan_dev *vxlan,
 }
 
 static struct vxlan_fdb *vxlan_find_mac_tx(struct vxlan_dev *vxlan,
+					   const struct vxlan_config *cfg,
 					   const u8 *mac, __be32 vni)
 {
 	struct vxlan_fdb *f;
 
-	f = vxlan_find_mac_rcu(vxlan, mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, cfg, mac, vni);
 	if (f) {
 		unsigned long now = jiffies;
 
@@ -416,7 +418,7 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	lockdep_assert_held_once(&vxlan->hash_lock);
 
 	rcu_read_lock();
-	f = vxlan_find_mac_rcu(vxlan, mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, mac, vni);
 	rcu_read_unlock();
 
 	return f;
@@ -457,7 +459,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, eth_addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, eth_addr, vni);
 	if (f)
 		rdst = first_remote_rcu(f);
 	if (!rdst) {
@@ -1405,7 +1407,7 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 
 	rcu_read_lock();
 
-	f = vxlan_find_mac_rcu(vxlan, addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, &vxlan->cfg, addr, vni);
 	if (!f) {
 		NL_SET_ERR_MSG(extack, "Fdb entry not found");
 		err = -ENOENT;
@@ -1423,6 +1425,7 @@ static int vxlan_fdb_get(struct sk_buff *skb,
  * and Tunnel endpoint.
  */
 static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
+					const struct vxlan_config *cfg,
 					union vxlan_addr *src_ip,
 					const u8 *src_mac, u32 src_ifindex,
 					__be32 vni)
@@ -1441,7 +1444,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		ifindex = src_ifindex;
 #endif
 
-	f = vxlan_find_mac_rcu(vxlan, src_mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, cfg, src_mac, vni);
 	if (likely(f)) {
 		struct vxlan_rdst *rdst = first_remote_rcu(f);
 		unsigned long now = jiffies;
@@ -1477,9 +1480,9 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 			vxlan_fdb_update(vxlan, src_mac, src_ip,
 					 NUD_REACHABLE,
 					 NLM_F_EXCL|NLM_F_CREATE,
-					 vxlan->cfg.dst_port,
+					 cfg->dst_port,
 					 vni,
-					 vxlan->default_dst.remote_vni,
+					 cfg->vni,
 					 ifindex, NTF_SELF, 0, true, NULL);
 		spin_unlock(&vxlan->hash_lock);
 	}
@@ -1587,6 +1590,7 @@ static void vxlan_parse_gbp_hdr(struct sk_buff *skb, u32 vxflags,
 }
 
 static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
+					  const struct vxlan_config *cfg,
 					  struct vxlan_sock *vs,
 					  struct sk_buff *skb, __be32 vni)
 {
@@ -1612,10 +1616,10 @@ static enum skb_drop_reason vxlan_set_mac(struct vxlan_dev *vxlan,
 #endif
 	}
 
-	if (!(vxlan->cfg.flags & VXLAN_F_LEARN))
+	if (!(cfg->flags & VXLAN_F_LEARN))
 		return SKB_NOT_DROPPED_YET;
 
-	return vxlan_snoop(skb->dev, &saddr, eth_hdr(skb)->h_source,
+	return vxlan_snoop(skb->dev, cfg, &saddr, eth_hdr(skb)->h_source,
 			   ifindex, vni);
 }
 
@@ -1646,18 +1650,20 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_vni_node *vninode = NULL;
-	const struct vxlanhdr *vh;
-	struct vxlan_dev *vxlan;
-	struct vxlan_sock *vs;
-	struct vxlan_metadata _md;
-	struct vxlan_metadata *md = &_md;
 	__be16 protocol = htons(ETH_P_TEB);
 	enum skb_drop_reason reason;
+	const struct vxlanhdr *vh;
+	struct vxlan_metadata *md;
+	struct vxlan_metadata _md;
+	struct vxlan_dev *vxlan;
 	bool raw_proto = false;
-	void *oiph;
+	struct vxlan_sock *vs;
 	__be32 vni = 0;
+	void *oiph;
 	int nh;
 
+	md = &_md;
+
 	/* Need UDP and VXLAN header to be present */
 	reason = pskb_may_pull_reason(skb, VXLAN_HLEN);
 	if (reason)
@@ -1698,7 +1704,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, vni, vninode,
+		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
@@ -1748,7 +1754,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 */
 
 	if (!raw_proto) {
-		reason = vxlan_set_mac(vxlan, vs, skb, vni);
+		reason = vxlan_set_mac(vxlan, &vxlan->cfg, vs, skb, vni);
 		if (reason)
 			goto drop;
 	} else {
@@ -1769,7 +1775,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (reason) {
 		DEV_STATS_INC(vxlan->dev, rx_length_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, vni, vninode,
+		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
@@ -1781,7 +1787,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
-		vxlan_vnifilter_count(vxlan, vni, vninode,
+		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
 	}
@@ -1791,14 +1797,14 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
 		rcu_read_unlock();
 		dev_dstats_rx_dropped(vxlan->dev);
-		vxlan_vnifilter_count(vxlan, vni, vninode,
+		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 		reason = SKB_DROP_REASON_DEV_READY;
 		goto drop;
 	}
 
 	dev_dstats_rx_add(vxlan->dev, skb->len);
-	vxlan_vnifilter_count(vxlan, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
+	vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
 	gro_cells_receive(&vxlan->gro_cells, skb);
 
 	rcu_read_unlock();
@@ -1839,7 +1845,7 @@ static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
+static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct arphdr *parp;
@@ -1852,7 +1858,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
 		dev_dstats_tx_dropped(dev);
-		vxlan_vnifilter_count(vxlan, vni, NULL,
+		vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
 		goto out;
 	}
@@ -1890,7 +1896,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		}
 
 		rcu_read_lock();
-		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
+		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, n->ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -1916,11 +1922,11 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 		if (netif_rx(reply) == NET_RX_DROP) {
 			dev_dstats_rx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, vni, NULL,
+			vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
 
-	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
+	} else if (flags & VXLAN_F_L3MISS) {
 		union vxlan_addr ipa = {
 			.sin.sin_addr.s_addr = tip,
 			.sin.sin_family = AF_INET,
@@ -2027,7 +2033,7 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	return reply;
 }
 
-static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
+static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni, u32 flags)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	const struct in6_addr *daddr;
@@ -2059,7 +2065,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 		}
 
-		f = vxlan_find_mac_tx(vxlan, n->ha, vni);
+		f = vxlan_find_mac_tx(vxlan, &vxlan->cfg, n->ha, vni);
 		if (f)
 			rdst = first_remote_rcu(f);
 		if (rdst && vxlan_addr_any(&rdst->remote_ip)) {
@@ -2078,10 +2084,10 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 
 		if (netif_rx(reply) == NET_RX_DROP) {
 			dev_dstats_rx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, vni, NULL,
+			vxlan_vnifilter_count(vxlan, &vxlan->cfg, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
-	} else if (vxlan->cfg.flags & VXLAN_F_L3MISS) {
+	} else if (flags & VXLAN_F_L3MISS) {
 		union vxlan_addr ipa = {
 			.sin6.sin6_addr = msg->target,
 			.sin6.sin6_family = AF_INET6,
@@ -2097,9 +2103,9 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 }
 #endif
 
-static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
+static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb,
+			       const struct vxlan_config *cfg)
 {
-	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct neighbour *n;
 
 	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
@@ -2115,7 +2121,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 			return false;
 		pip = ip_hdr(skb);
 		n = neigh_lookup(&arp_tbl, &pip->daddr, dev);
-		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
+		if (!n && (cfg->flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin.sin_addr.s_addr = pip->daddr,
 				.sin.sin_family = AF_INET,
@@ -2141,7 +2147,7 @@ static bool route_shortcircuit(struct net_device *dev, struct sk_buff *skb)
 			return false;
 		pip6 = ipv6_hdr(skb);
 		n = neigh_lookup(&nd_tbl, &pip6->daddr, dev);
-		if (!n && (vxlan->cfg.flags & VXLAN_F_L3MISS)) {
+		if (!n && (cfg->flags & VXLAN_F_L3MISS)) {
 			union vxlan_addr ipa = {
 				.sin6.sin6_addr = pip6->daddr,
 				.sin6.sin6_family = AF_INET6,
@@ -2253,20 +2259,20 @@ static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
 
 /* Bypass encapsulation if the destination is local */
 static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
-			       struct vxlan_dev *dst_vxlan, __be32 vni,
-			       bool snoop)
+			       struct vxlan_dev *dst_vxlan,
+			       const struct vxlan_config *cfg,
+			       __be32 vni, bool snoop)
 {
 	union vxlan_addr loopback;
-	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
 	unsigned int len = skb->len;
-	struct net_device *dev;
+	struct net_device *dev = dst_vxlan->dev;
 
 	skb->pkt_type = PACKET_HOST;
 	skb->encapsulation = 0;
-	skb->dev = dst_vxlan->dev;
+	skb->dev = dev;
 	__skb_pull(skb, skb_network_offset(skb));
 
-	if (remote_ip->sa.sa_family == AF_INET) {
+	if (cfg->remote_ip.sa.sa_family == AF_INET) {
 		loopback.sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 		loopback.sa.sa_family =  AF_INET;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2277,26 +2283,25 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	}
 
 	rcu_read_lock();
-	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
 		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
-		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
+	if ((cfg->flags & VXLAN_F_LEARN) && snoop)
+		vxlan_snoop(dev, cfg, &loopback, eth_hdr(skb)->h_source, 0, vni);
 
 	dev_dstats_tx_add(src_vxlan->dev, len);
-	vxlan_vnifilter_count(src_vxlan, vni, NULL, VXLAN_VNI_STATS_TX, len);
+	vxlan_vnifilter_count(src_vxlan, cfg, vni, NULL, VXLAN_VNI_STATS_TX, len);
 
 	if (__netif_rx(skb) == NET_RX_SUCCESS) {
 		dev_dstats_rx_add(dst_vxlan->dev, len);
-		vxlan_vnifilter_count(dst_vxlan, vni, NULL, VXLAN_VNI_STATS_RX,
+		vxlan_vnifilter_count(dst_vxlan, cfg, vni, NULL, VXLAN_VNI_STATS_RX,
 				      len);
 	} else {
 drop:
 		dev_dstats_rx_dropped(dev);
-		vxlan_vnifilter_count(dst_vxlan, vni, NULL,
+		vxlan_vnifilter_count(dst_vxlan, cfg, vni, NULL,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 	}
 	rcu_read_unlock();
@@ -2304,6 +2309,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 
 static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 				 struct vxlan_dev *vxlan,
+				 const struct vxlan_config *cfg,
 				 int addr_family,
 				 __be16 dst_port, int dst_ifindex, __be32 vni,
 				 struct dst_entry *dst,
@@ -2319,22 +2325,22 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 	/* Bypass encapsulation if the destination is local */
 	if (rt_flags & RTCF_LOCAL &&
 	    !(rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST)) &&
-	    vxlan->cfg.flags & VXLAN_F_LOCALBYPASS) {
+	    cfg->flags & VXLAN_F_LOCALBYPASS) {
 		struct vxlan_dev *dst_vxlan;
 
 		dst_release(dst);
 		dst_vxlan = vxlan_find_vni(vxlan->net, dst_ifindex, vni,
 					   addr_family, dst_port,
-					   vxlan->cfg.flags);
+					   cfg->flags);
 		if (!dst_vxlan) {
 			DEV_STATS_INC(dev, tx_errors);
-			vxlan_vnifilter_count(vxlan, vni, NULL,
+			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
 			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND);
 
 			return -ENOENT;
 		}
-		vxlan_encap_bypass(skb, vxlan, dst_vxlan, vni, true);
+		vxlan_encap_bypass(skb, vxlan, dst_vxlan, cfg, vni, true);
 		return 1;
 	}
 
@@ -2342,30 +2348,35 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 }
 
 void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
+		    const struct vxlan_config *cfg,
 		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc)
 {
+	unsigned int pkt_len = skb->len;
+	__be16 src_port = 0, dst_port;
+	struct dst_entry *ndst = NULL;
+	enum skb_drop_reason reason;
+	struct vxlan_dev *vxlan;
 	struct dst_cache *dst_cache;
+	const struct iphdr *old_iph;
 	struct ip_tunnel_info *info;
 	struct ip_tunnel_key *pkey;
-	struct ip_tunnel_key key;
-	struct vxlan_dev *vxlan = netdev_priv(dev);
-	const struct iphdr *old_iph;
+	struct vxlan_metadata *md;
 	struct vxlan_metadata _md;
-	struct vxlan_metadata *md = &_md;
-	unsigned int pkt_len = skb->len;
-	__be16 src_port = 0, dst_port;
-	struct dst_entry *ndst = NULL;
+	struct ip_tunnel_key key;
+	u32 flags = cfg->flags;
+	bool udp_sum = false;
+	bool no_eth_encap;
 	int addr_family;
+	bool use_cache;
+	__be32 vni = 0;
+	bool xnet;
 	__u8 tos, ttl;
 	int ifindex;
 	int err = 0;
-	u32 flags = vxlan->cfg.flags;
-	bool use_cache;
-	bool udp_sum = false;
-	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
-	enum skb_drop_reason reason;
-	bool no_eth_encap;
-	__be32 vni = 0;
+
+	vxlan = netdev_priv(dev);
+	xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
+	md = &_md;
 
 	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
 	reason = skb_vlan_inet_prepare(skb, no_eth_encap);
@@ -2385,23 +2396,23 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (vxlan_addr_any(&rdst->remote_ip)) {
 			if (did_rsc) {
 				/* short-circuited back to local bridge */
-				vxlan_encap_bypass(skb, vxlan, vxlan,
+				vxlan_encap_bypass(skb, vxlan, vxlan, cfg,
 						   default_vni, true);
 				return;
 			}
 			goto drop;
 		}
 
-		addr_family = vxlan->cfg.saddr.sa.sa_family;
-		dst_port = rdst->remote_port ? rdst->remote_port : vxlan->cfg.dst_port;
+		addr_family = cfg->saddr.sa.sa_family;
+		dst_port = rdst->remote_port ? rdst->remote_port : cfg->dst_port;
 		vni = (rdst->remote_vni) ? : default_vni;
 		ifindex = rdst->remote_ifindex;
 
 		if (addr_family == AF_INET) {
-			key.u.ipv4.src = vxlan->cfg.saddr.sin.sin_addr.s_addr;
+			key.u.ipv4.src = cfg->saddr.sin.sin_addr.s_addr;
 			key.u.ipv4.dst = rdst->remote_ip.sin.sin_addr.s_addr;
 		} else {
-			key.u.ipv6.src = vxlan->cfg.saddr.sin6.sin6_addr;
+			key.u.ipv6.src = cfg->saddr.sin6.sin6_addr;
 			key.u.ipv6.dst = rdst->remote_ip.sin6.sin6_addr;
 		}
 
@@ -2410,11 +2421,11 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (flags & VXLAN_F_TTL_INHERIT) {
 			ttl = ip_tunnel_get_ttl(old_iph, skb);
 		} else {
-			ttl = vxlan->cfg.ttl;
+			ttl = cfg->ttl;
 			if (!ttl && vxlan_addr_multicast(&rdst->remote_ip))
 				ttl = 1;
 		}
-		tos = vxlan->cfg.tos;
+		tos = cfg->tos;
 		if (tos == 1)
 			tos = ip_tunnel_get_dsfield(old_iph, skb);
 		if (tos && !info)
@@ -2425,9 +2436,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		else
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
 #if IS_ENABLED(CONFIG_IPV6)
-		switch (vxlan->cfg.label_policy) {
+		switch (cfg->label_policy) {
 		case VXLAN_LABEL_FIXED:
-			key.label = vxlan->cfg.label;
+			key.label = cfg->label;
 			break;
 		case VXLAN_LABEL_INHERIT:
 			key.label = ip_tunnel_get_flowlabel(old_iph, skb);
@@ -2445,7 +2456,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 		pkey = &info->key;
 		addr_family = ip_tunnel_info_af(info);
-		dst_port = info->key.tp_dst ? : vxlan->cfg.dst_port;
+		dst_port = info->key.tp_dst ? : cfg->dst_port;
 		vni = tunnel_id_to_key32(info->key.tun_id);
 		ifindex = 0;
 		dst_cache = &info->dst_cache;
@@ -2458,8 +2469,8 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		tos = info->key.tos;
 		udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
 	}
-	src_port = udp_flow_src_port(dev_net(dev), skb, vxlan->cfg.port_min,
-				     vxlan->cfg.port_max, true);
+	src_port = udp_flow_src_port(dev_net(dev), skb, cfg->port_min,
+				     cfg->port_max, true);
 
 	rcu_read_lock();
 	if (addr_family == AF_INET) {
@@ -2492,15 +2503,15 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 		if (!info) {
 			/* Bypass encapsulation if the destination is local */
-			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
+			err = encap_bypass_if_local(skb, dev, vxlan, cfg, AF_INET,
 						    dst_port, ifindex, vni,
 						    &rt->dst, rt->rt_flags);
 			if (err)
 				goto out_unlock;
 
-			if (vxlan->cfg.df == VXLAN_DF_SET) {
+			if (cfg->df == VXLAN_DF_SET) {
 				df = htons(IP_DF);
-			} else if (vxlan->cfg.df == VXLAN_DF_INHERIT) {
+			} else if (cfg->df == VXLAN_DF_INHERIT) {
 				struct ethhdr *eth = eth_hdr(skb);
 
 				if (ntohs(eth->h_proto) == ETH_P_IPV6 ||
@@ -2529,7 +2540,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				unclone->key.u.ipv4.src = pkey->u.ipv4.dst;
 				unclone->key.u.ipv4.dst = saddr;
 			}
-			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
+			vxlan_encap_bypass(skb, vxlan, vxlan, cfg, vni, false);
 			dst_release(ndst);
 			goto out_unlock;
 		}
@@ -2579,7 +2590,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (!info) {
 			u32 rt6i_flags = dst_rt6_info(ndst)->rt6i_flags;
 
-			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
+			err = encap_bypass_if_local(skb, dev, vxlan, cfg, AF_INET6,
 						    dst_port, ifindex, vni,
 						    ndst, rt6i_flags);
 			if (err)
@@ -2603,7 +2614,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				unclone->key.u.ipv6.dst = saddr;
 			}
 
-			vxlan_encap_bypass(skb, vxlan, vxlan, vni, false);
+			vxlan_encap_bypass(skb, vxlan, vxlan, cfg, vni, false);
 			dst_release(ndst);
 			goto out_unlock;
 		}
@@ -2624,14 +2635,14 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				     ip6cb_flags);
 #endif
 	}
-	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
+	vxlan_vnifilter_count(vxlan, cfg, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
 out_unlock:
 	rcu_read_unlock();
 	return;
 
 drop:
 	dev_dstats_tx_dropped(dev);
-	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
+	vxlan_vnifilter_count(vxlan, cfg, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
 	kfree_skb_reason(skb, reason);
 	return;
 
@@ -2643,11 +2654,12 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
-	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
+	vxlan_vnifilter_count(vxlan, cfg, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
 	kfree_skb_reason(skb, reason);
 }
 
 static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
+			  const struct vxlan_config *cfg,
 			  struct vxlan_fdb *f, __be32 vni, bool did_rsc)
 {
 	struct vxlan_rdst nh_rdst;
@@ -2664,7 +2676,7 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
 
 	if (likely(do_xmit))
-		vxlan_xmit_one(skb, dev, vni, &nh_rdst, did_rsc);
+		vxlan_xmit_one(skb, dev, cfg, vni, &nh_rdst, did_rsc);
 	else
 		goto drop;
 
@@ -2672,15 +2684,15 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 
 drop:
 	dev_dstats_tx_dropped(dev);
-	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
+	vxlan_vnifilter_count(netdev_priv(dev), cfg, vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
 }
 
 static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
-				   u32 nhid, __be32 vni)
+				   u32 nhid, __be32 vni, int saddr_family,
+				   const struct vxlan_config *cfg)
 {
-	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst nh_rdst;
 	struct nexthop *nh;
 	bool do_xmit;
@@ -2698,11 +2710,11 @@ static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
 	do_xmit = vxlan_fdb_nh_path_select(nh, hash, &nh_rdst);
 	rcu_read_unlock();
 
-	if (vxlan->cfg.saddr.sa.sa_family != nh_rdst.remote_ip.sa.sa_family)
+	if (saddr_family != nh_rdst.remote_ip.sa.sa_family)
 		goto drop;
 
 	if (likely(do_xmit))
-		vxlan_xmit_one(skb, dev, vni, &nh_rdst, false);
+		vxlan_xmit_one(skb, dev, cfg, vni, &nh_rdst, false);
 	else
 		goto drop;
 
@@ -2710,7 +2722,7 @@ static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
 
 drop:
 	dev_dstats_tx_dropped(dev);
-	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
+	vxlan_vnifilter_count(netdev_priv(dev), cfg, vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
 	return NETDEV_TX_OK;
@@ -2727,34 +2739,43 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_rdst *rdst, *fdst = NULL;
 	const struct ip_tunnel_info *info;
+	const struct vxlan_config *cfg;
+	__be32 default_vni;
 	struct vxlan_fdb *f;
 	struct ethhdr *eth;
+	int saddr_family;
 	__be32 vni = 0;
-	u32 nhid = 0;
 	bool did_rsc;
+	u32 nhid = 0;
+	u32 flags;
+
+	cfg = &vxlan->cfg;
+	flags = cfg->flags;
+	default_vni = cfg->vni;
+	saddr_family = cfg->saddr.sa.sa_family;
 
 	info = skb_tunnel_info(skb);
 
 	skb_reset_mac_header(skb);
 
-	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
+	if (flags & VXLAN_F_COLLECT_METADATA) {
 		if (info && info->mode & IP_TUNNEL_INFO_BRIDGE &&
 		    info->mode & IP_TUNNEL_INFO_TX) {
 			vni = tunnel_id_to_key32(info->key.tun_id);
 			nhid = info->key.nhid;
 		} else {
 			if (info && info->mode & IP_TUNNEL_INFO_TX)
-				vxlan_xmit_one(skb, dev, vni, NULL, false);
+				vxlan_xmit_one(skb, dev, cfg, vni, NULL, false);
 			else
 				kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_TXINFO);
 			return NETDEV_TX_OK;
 		}
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_PROXY) {
+	if (flags & VXLAN_F_PROXY) {
 		eth = eth_hdr(skb);
 		if (ntohs(eth->h_proto) == ETH_P_ARP)
-			return arp_reduce(dev, skb, vni);
+			return arp_reduce(dev, skb, vni, flags);
 #if IS_ENABLED(CONFIG_IPV6)
 		else if (ntohs(eth->h_proto) == ETH_P_IPV6 &&
 			 pskb_may_pull(skb, sizeof(struct ipv6hdr) +
@@ -2764,15 +2785,15 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 			if (m->icmph.icmp6_code == 0 &&
 			    m->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
-				return neigh_reduce(dev, skb, vni);
+				return neigh_reduce(dev, skb, vni, flags);
 		}
 #endif
 	}
 
 	if (nhid)
-		return vxlan_xmit_nhid(skb, dev, nhid, vni);
+		return vxlan_xmit_nhid(skb, dev, nhid, vni, saddr_family, cfg);
 
-	if (vxlan->cfg.flags & VXLAN_F_MDB) {
+	if (flags & VXLAN_F_MDB) {
 		struct vxlan_mdb_entry *mdb_entry;
 
 		rcu_read_lock();
@@ -2789,26 +2810,26 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	eth = eth_hdr(skb);
 	rcu_read_lock();
-	f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
+	f = vxlan_find_mac_tx(vxlan, cfg, eth->h_dest, vni);
 	did_rsc = false;
 
-	if (f && (f->flags & NTF_ROUTER) && (vxlan->cfg.flags & VXLAN_F_RSC) &&
+	if (f && (f->flags & NTF_ROUTER) && (flags & VXLAN_F_RSC) &&
 	    (ntohs(eth->h_proto) == ETH_P_IP ||
 	     ntohs(eth->h_proto) == ETH_P_IPV6)) {
-		did_rsc = route_shortcircuit(dev, skb);
+		did_rsc = route_shortcircuit(dev, skb, cfg);
 		if (did_rsc)
-			f = vxlan_find_mac_tx(vxlan, eth->h_dest, vni);
+			f = vxlan_find_mac_tx(vxlan, cfg, eth->h_dest, vni);
 	}
 
 	if (f == NULL) {
-		f = vxlan_find_mac_tx(vxlan, all_zeros_mac, vni);
+		f = vxlan_find_mac_tx(vxlan, cfg, all_zeros_mac, vni);
 		if (f == NULL) {
-			if ((vxlan->cfg.flags & VXLAN_F_L2MISS) &&
+			if ((flags & VXLAN_F_L2MISS) &&
 			    !is_multicast_ether_addr(eth->h_dest))
 				vxlan_fdb_miss(vxlan, eth->h_dest);
 
 			dev_dstats_tx_dropped(dev);
-			vxlan_vnifilter_count(vxlan, vni, NULL,
+			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
 			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 			goto out;
@@ -2816,8 +2837,8 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	if (rcu_access_pointer(f->nh)) {
-		vxlan_xmit_nh(skb, dev, f,
-			      (vni ? : vxlan->default_dst.remote_vni), did_rsc);
+		vxlan_xmit_nh(skb, dev, cfg, f,
+			      (vni ? : default_vni), did_rsc);
 	} else {
 		list_for_each_entry_rcu(rdst, &f->remotes, list) {
 			struct sk_buff *skb1;
@@ -2828,10 +2849,10 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			}
 			skb1 = skb_clone(skb, GFP_ATOMIC);
 			if (skb1)
-				vxlan_xmit_one(skb1, dev, vni, rdst, did_rsc);
+				vxlan_xmit_one(skb1, dev, cfg, vni, rdst, did_rsc);
 		}
 		if (fdst)
-			vxlan_xmit_one(skb, dev, vni, fdst, did_rsc);
+			vxlan_xmit_one(skb, dev, cfg, vni, fdst, did_rsc);
 		else
 			kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
 	}
@@ -3701,7 +3722,7 @@ static int vxlan_sock_add(struct vxlan_dev *vxlan)
 }
 
 int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
-		     struct vxlan_config *conf, __be32 vni)
+		     const struct vxlan_config *conf, __be32 vni)
 {
 	struct vxlan_net *vn = net_generic(src_net, vxlan_net_id);
 	struct vxlan_dev *tmp;
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 055a4969f593c9a949399242298d3a1e44e43988..c92217906d5ee90c92f3da50ca9a276793ed9aca 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -164,6 +164,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 				     const struct vxlan_mdb_entry *mdb_entry,
 				     const struct vxlan_mdb_remote *remote)
 {
+	const struct vxlan_config *cfg = &vxlan->cfg;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	struct br_mdb_entry e;
 	struct nlattr *nest;
@@ -188,7 +189,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 	    vxlan_nla_put_addr(skb, MDBA_MDB_EATTR_DST, &rd->remote_ip))
 		goto nest_err;
 
-	if (rd->remote_port && rd->remote_port != vxlan->cfg.dst_port &&
+	if (rd->remote_port && rd->remote_port != cfg->dst_port &&
 	    nla_put_u16(skb, MDBA_MDB_EATTR_DST_PORT,
 			be16_to_cpu(rd->remote_port)))
 		goto nest_err;
@@ -201,7 +202,7 @@ static int vxlan_mdb_entry_info_fill(const struct vxlan_dev *vxlan,
 	    nla_put_u32(skb, MDBA_MDB_EATTR_IFINDEX, rd->remote_ifindex))
 		goto nest_err;
 
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) &&
+	if ((cfg->flags & VXLAN_F_COLLECT_METADATA) &&
 	    mdb_entry->key.vni && nla_put_u32(skb, MDBA_MDB_EATTR_SRC_VNI,
 					      be32_to_cpu(mdb_entry->key.vni)))
 		goto nest_err;
@@ -604,6 +605,7 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 {
 	struct br_mdb_entry *entry = nla_data(tb[MDBA_SET_ENTRY]);
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	const struct vxlan_config *vcfg = &vxlan->cfg;
 
 	memset(cfg, 0, sizeof(*cfg));
 	cfg->vxlan = vxlan;
@@ -613,7 +615,7 @@ static int vxlan_mdb_config_init(struct vxlan_mdb_config *cfg,
 	cfg->filter_mode = MCAST_EXCLUDE;
 	cfg->rt_protocol = RTPROT_STATIC;
 	cfg->remote_vni = vxlan->default_dst.remote_vni;
-	cfg->remote_port = vxlan->cfg.dst_port;
+	cfg->remote_port = vcfg->dst_port;
 
 	if (entry->ifindex != dev->ifindex) {
 		NL_SET_ERR_MSG_MOD(extack, "Port net device must be the VXLAN net device");
@@ -938,6 +940,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 			    const struct vxlan_mdb_entry *mdb_entry,
 			    const struct vxlan_mdb_remote *remote)
 {
+	const struct vxlan_config *cfg = &vxlan->cfg;
 	const struct vxlan_mdb_entry_key *group = &mdb_entry->key;
 	struct vxlan_rdst *rd = rtnl_dereference(remote->rd);
 	size_t nlmsg_size;
@@ -959,7 +962,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 	/* MDBA_MDB_EATTR_DST */
 	nlmsg_size += nla_total_size(vxlan_addr_size(&rd->remote_ip));
 	/* MDBA_MDB_EATTR_DST_PORT */
-	if (rd->remote_port && rd->remote_port != vxlan->cfg.dst_port)
+	if (rd->remote_port && rd->remote_port != cfg->dst_port)
 		nlmsg_size += nla_total_size(sizeof(u16));
 	/* MDBA_MDB_EATTR_VNI */
 	if (rd->remote_vni != vxlan->default_dst.remote_vni)
@@ -968,7 +971,7 @@ vxlan_mdb_nlmsg_remote_size(const struct vxlan_dev *vxlan,
 	if (rd->remote_ifindex)
 		nlmsg_size += nla_total_size(sizeof(u32));
 	/* MDBA_MDB_EATTR_SRC_VNI */
-	if ((vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) && group->vni)
+	if ((cfg->flags & VXLAN_F_COLLECT_METADATA) && group->vni)
 		nlmsg_size += nla_total_size(sizeof(u32));
 
 	return nlmsg_size;
@@ -1607,6 +1610,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 						struct sk_buff *skb,
 						__be32 src_vni)
 {
+	const struct vxlan_config *cfg = &vxlan->cfg;
 	struct vxlan_mdb_entry *mdb_entry;
 	struct vxlan_mdb_entry_key group;
 
@@ -1617,7 +1621,7 @@ struct vxlan_mdb_entry *vxlan_mdb_entry_skb_get(struct vxlan_dev *vxlan,
 	/* When not in collect metadata mode, 'src_vni' is zero, but MDB
 	 * entries are stored with the VNI of the VXLAN device.
 	 */
-	if (!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA))
+	if (!(cfg->flags & VXLAN_F_COLLECT_METADATA))
 		src_vni = vxlan->default_dst.remote_vni;
 
 	memset(&group, 0, sizeof(group));
@@ -1704,12 +1708,12 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 
 		skb1 = skb_clone(skb, GFP_ATOMIC);
 		if (skb1)
-			vxlan_xmit_one(skb1, vxlan->dev, src_vni,
+			vxlan_xmit_one(skb1, vxlan->dev, &vxlan->cfg, src_vni,
 				       rcu_dereference(remote->rd), false);
 	}
 
 	if (fremote)
-		vxlan_xmit_one(skb, vxlan->dev, src_vni,
+		vxlan_xmit_one(skb, vxlan->dev, &vxlan->cfg, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
 		kfree_skb_reason(skb, SKB_DROP_REASON_NO_TX_TARGET);
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index b1eec221636088aa1c1674221d5ef0f13698b53f..3d5f21c11ab4ff55ae6c47f8dabdc21331d37290 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -195,9 +195,10 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 		     __u32 ifindex, __u16 ndm_flags, u32 nhid,
 		     bool swdev_notify, struct netlink_ext_ack *extack);
 void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
+		    const struct vxlan_config *cfg,
 		    __be32 default_vni, struct vxlan_rdst *rdst, bool did_rsc);
 int vxlan_vni_in_use(struct net *src_net, struct vxlan_dev *vxlan,
-		     struct vxlan_config *conf, __be32 vni);
+		     const struct vxlan_config *conf, __be32 vni);
 
 /* vxlan_vnifilter.c */
 int vxlan_vnigroup_init(struct vxlan_dev *vxlan);
@@ -205,7 +206,8 @@ void vxlan_vnigroup_uninit(struct vxlan_dev *vxlan);
 
 int vxlan_vnifilter_init(void);
 void vxlan_vnifilter_uninit(void);
-void vxlan_vnifilter_count(struct vxlan_dev *vxlan, __be32 vni,
+void vxlan_vnifilter_count(struct vxlan_dev *vxlan,
+			   const struct vxlan_config *cfg, __be32 vni,
 			   struct vxlan_vni_node *vninode,
 			   int type, unsigned int len);
 
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 3e76f4e210944ffecd35e872c7b7ce36923117b5..3674dec5a59ae4cdb94319c8789826fbb9f0104c 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -171,13 +171,14 @@ static void vxlan_vnifilter_stats_add(struct vxlan_vni_node *vninode,
 	u64_stats_update_end(&pstats->syncp);
 }
 
-void vxlan_vnifilter_count(struct vxlan_dev *vxlan, __be32 vni,
+void vxlan_vnifilter_count(struct vxlan_dev *vxlan,
+			   const struct vxlan_config *cfg, __be32 vni,
 			   struct vxlan_vni_node *vninode,
 			   int type, unsigned int len)
 {
 	struct vxlan_vni_node *vnode;
 
-	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
+	if (!cfg || !(cfg->flags & VXLAN_F_VNIFILTER))
 		return;
 
 	if (vninode) {
diff --git a/net/openvswitch/vport-vxlan.c b/net/openvswitch/vport-vxlan.c
index c1b37b50d29e15540f22787d0dcdb12da181a5fd..b0a084864a858453715d8e51b3e95cc7b2d9370f 100644
--- a/net/openvswitch/vport-vxlan.c
+++ b/net/openvswitch/vport-vxlan.c
@@ -22,19 +22,20 @@ static struct vport_ops ovs_vxlan_netdev_vport_ops;
 static int vxlan_get_options(const struct vport *vport, struct sk_buff *skb)
 {
 	struct vxlan_dev *vxlan = netdev_priv(vport->dev);
-	__be16 dst_port = vxlan->cfg.dst_port;
+	const struct vxlan_config *cfg = &vxlan->cfg;
+	__be16 dst_port = cfg->dst_port;
 
 	if (nla_put_u16(skb, OVS_TUNNEL_ATTR_DST_PORT, ntohs(dst_port)))
 		return -EMSGSIZE;
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP) {
+	if (cfg->flags & VXLAN_F_GBP) {
 		struct nlattr *exts;
 
 		exts = nla_nest_start_noflag(skb, OVS_TUNNEL_ATTR_EXTENSION);
 		if (!exts)
 			return -EMSGSIZE;
 
-		if (vxlan->cfg.flags & VXLAN_F_GBP &&
+		if (cfg->flags & VXLAN_F_GBP &&
 		    nla_put_flag(skb, OVS_VXLAN_EXT_GBP))
 			return -EMSGSIZE;
 
-- 
2.55.0.795.g602f6c329a-goog


