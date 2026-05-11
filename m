Return-Path: <netdev+bounces-286472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOKINOB/AWqkbQEAu9opvQ
	(envelope-from <netdev+bounces-286472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:06:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E2D508DBA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF624301750B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8230DED0;
	Mon, 11 May 2026 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQE66NPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65330C62E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482972; cv=none; b=pDy9wE6SKfqBjM32yIC0Dp8sJhL2Z/Db34P/O+o6VrcORliLc9zlMHB66Nm6WQT8jAn1gBYIT8SzRwtjN89mxYeXWR28jMQZRX5mIGarMvqrK4P8LoffwO7kFNKM2jcTPoiX3vRicOLcMPBtEGTOwOtmdUfiN6EIFNCU3hDqy6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482972; c=relaxed/simple;
	bh=Ch5/B4rT94h5k8/2yZE7pgcAeyUIqOXwNgF4XaeWrng=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VtgNiRhGqfdW4HGjrsLkjxDpKcP1wmcVciyKdzAAYmZoLYkEXdzfQ9fIY8xSCX6vdOMqoYjC1sHlqyVFJ/GeaHmruTngdPb5daXhk0d2+3PCamCz/dOeqWTfC76PP8ssfxWttPs6tpznfGQ3TKtDS7JxChFiKVDN8bggChN4phM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQE66NPj; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-6333021c63fso1123752137.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778482970; x=1779087770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3sGtaunMrhU4W4AhyR5JREDg4vVNc14dY6L9nQ8yW3s=;
        b=MQE66NPjnO5JuOY0wZS0F7K34rzo211/9emXD3u68xuLU/ZQpns1IGE5YkICGBA99V
         D1oINRGLYAMCnHlmPH1fNB1nCD+xwYYNyA7muK47sL1Dnxu1Bq83qzrbnk1lDi+0umpR
         oz9lucCO+vamghg0ZooskjlV7nyndi/7p3Zfq57zn+1fYZVulAZCJKfHGM2O01fpaabx
         lfljhNFFi5Gr7ssEQyEay3vrWKQN5xQxcYxcOzfWtsUMCuJjcX1NX4rH8CUdU2DbYNK0
         D/wQIGBgxSDOIEZnmB+dVpVHrj3LQWdgSFwFgl7/bRidQlDcvpwKlfMDpFBkCgERCBrN
         gwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482970; x=1779087770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3sGtaunMrhU4W4AhyR5JREDg4vVNc14dY6L9nQ8yW3s=;
        b=Om/vbxfzSqv5d2UV/i0OsEK7LnFxH767bgHexLip5RGFCq9q3YAkyDFMiyT/8a7/TG
         I+vd8PMG1Hxwz3dhsOKz3PQb5JBWL6omY385RYA1d0EIiho/t3Kv4owu274fat0BtPcV
         dc14OEChTshIT+ZpgG89won1+EmGthqbfwuxrbr8NshhFFWDWpqSKFrm2UlT6xiEwgN+
         nfG8YqdMVeAKSB1d1kusSY4s+NBL/5IXBtdUi0LSAw+/mxzbFpcQBUPuzels9wt9nhM7
         +FeWRtNrLvY1+niSRitbEYkX/eKkRVYRi2plVzBhw3XdIBijreQEw71q13Yd3pt9u395
         EMDQ==
X-Forwarded-Encrypted: i=1; AFNElJ96jEUZDqHwzhiKOqbOeGV3mr0yZw/8YTzJ1qD4uh44pBB4KnPGAkBPq6xQRmO/2Lnq0Yweogk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZaIdhKFJrVFCbkPd4EebbYs75XREWzn2Ivx7CJMqdP0SmSAs
	6OE0zWCXHbGSwRkBr52aOKZZTR3h0fZlhmZTmrXM82PoaSUnbMwVZiLGbP2DGfjDwPQW1zz8yD0
	PW+WFvsJ5ZIeCZQ==
X-Received: from uaax25-n2.prod.google.com ([2002:a05:6130:84d9:20b0:95d:2d4e:1839])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:84d5:20b0:631:3bbb:f25f with SMTP id ada2fe7eead31-6313bbbfecdmr4288580137.15.1778482969597;
 Mon, 11 May 2026 00:02:49 -0700 (PDT)
Date: Mon, 11 May 2026 07:02:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511070244.971028-1-edumazet@google.com>
Subject: [PATCH v2 net-next] rtnetlink: add RTEXT_FILTER_NAME_ONLY support
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 51E2D508DBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286472-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

iproute2 can spend considerable amount of time in ll_init_map()
or ll_link_get() to dump verbose netdev attributes, contributing
to RTNL pressure.

Add RTEXT_FILTER_NAME_ONLY new flag so that rtnl_fill_ifinfo()
limits its output to:

- struct nlmsghdr
- IFLA_IFNAME
- IFLA_PROP_LIST (alternate names)

We can later avoid using RTNL when RTEXT_FILTER_NAME_ONLY
is requested, as none of these attributes need RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: use RTEXT_FILTER_NAME_ONLY instead of  RTEXT_FILTER_TERSE_DUMP (Jakub)

 include/uapi/linux/rtnetlink.h |  1 +
 net/core/rtnetlink.c           | 31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index dab9493c791b8465c6476990f42c4ee5ae82da2d..27265fd31e5fc99c312b42f3b1f072419b56ee0b 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -840,6 +840,7 @@ enum {
 #define RTEXT_FILTER_CFM_CONFIG	(1 << 5)
 #define RTEXT_FILTER_CFM_STATUS	(1 << 6)
 #define RTEXT_FILTER_MST	(1 << 7)
+#define RTEXT_FILTER_NAME_ONLY	(1 << 8)
 
 /* End of information exported to user level */
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index df042da422ef3137ed67efaf8d243cc6b1fec6c7..70fde922b3718d753caf4874047d0b55ec649ef2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1295,7 +1295,12 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 
 	size = NLMSG_ALIGN(sizeof(struct ifinfomsg))
 	       + nla_total_size(IFNAMSIZ) /* IFLA_IFNAME */
-	       + nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
+	       + rtnl_prop_list_size(dev);
+
+	if (ext_filter_mask & RTEXT_FILTER_NAME_ONLY)
+		return size;
+
+	size += nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
 	       + nla_total_size(IFNAMSIZ) /* IFLA_QDISC */
 	       + nla_total_size_64bit(sizeof(struct rtnl_link_ifmap))
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_ADDRESS */
@@ -1342,7 +1347,6 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(4)  /* IFLA_CARRIER_DOWN_COUNT */
 	       + nla_total_size(4)  /* IFLA_MIN_MTU */
 	       + nla_total_size(4)  /* IFLA_MAX_MTU */
-	       + rtnl_prop_list_size(dev)
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_PERM_ADDRESS */
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size(dev)
@@ -1941,15 +1945,18 @@ static int rtnl_fill_alt_ifnames(struct sk_buff *skb,
 	struct netdev_name_node *name_node;
 	int count = 0;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(name_node, &dev->name_node->list, list) {
-		if (nla_put_string(skb, IFLA_ALT_IFNAME, name_node->name))
+		if (nla_put_string(skb, IFLA_ALT_IFNAME, name_node->name)) {
+			rcu_read_unlock();
 			return -EMSGSIZE;
+		}
 		count++;
 	}
+	rcu_read_unlock();
 	return count;
 }
 
-/* RCU protected. */
 static int rtnl_fill_prop_list(struct sk_buff *skb,
 			       const struct net_device *dev)
 {
@@ -2072,13 +2079,20 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	ifm->ifi_flags = netif_get_flags(dev);
 	ifm->ifi_change = change;
 
-	if (tgt_netnsid >= 0 && nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
-		goto nla_put_failure;
-
 	netdev_copy_name(dev, devname);
 	if (nla_put_string(skb, IFLA_IFNAME, devname))
 		goto nla_put_failure;
 
+	if (rtnl_fill_prop_list(skb, dev))
+		goto nla_put_failure;
+
+	if (ext_filter_mask & RTEXT_FILTER_NAME_ONLY)
+		goto end;
+
+	if (tgt_netnsid >= 0 &&
+	    nla_put_s32(skb, IFLA_TARGET_NETNSID, tgt_netnsid))
+		goto nla_put_failure;
+
 	if (nla_put_u32(skb, IFLA_TXQLEN, READ_ONCE(dev->tx_queue_len)) ||
 	    nla_put_u8(skb, IFLA_OPERSTATE,
 		       netif_running(dev) ? READ_ONCE(dev->operstate) :
@@ -2191,8 +2205,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 		goto nla_put_failure_rcu;
 	if (rtnl_fill_link_ifmap(skb, dev))
 		goto nla_put_failure_rcu;
-	if (rtnl_fill_prop_list(skb, dev))
-		goto nla_put_failure_rcu;
 	rcu_read_unlock();
 
 	if (dev->dev.parent &&
@@ -2211,6 +2223,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (rtnl_fill_dpll_pin(skb, dev))
 		goto nla_put_failure;
 
+end:
 	nlmsg_end(skb, nlh);
 	return 0;
 
-- 
2.54.0.563.g4f69b47b94-goog


