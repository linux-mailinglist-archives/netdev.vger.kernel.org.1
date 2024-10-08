Return-Path: <netdev+bounces-133141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D97199523C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29DBB25C61
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAAE1E0DE6;
	Tue,  8 Oct 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBt3Xidn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FA1DFD9C;
	Tue,  8 Oct 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397480; cv=none; b=VvAkFebo89qO5b1QMS49xz12HJvrTh2PJopogbcdZ1c8XDTs81SEXaxsGxNTYjuRYy9wF5bgel8QgHpsEQ6T+qUAkpAxNeuDgEgz26NuwZ10m2llWmRx6TvwCFqFdwgrsvSvRsL84PmBEzFDMH3KBLU0M4ZKyisUisYZp0qonpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397480; c=relaxed/simple;
	bh=0ZgJtJ+TjXiHcGPlxVYxhjDteuWSfgfQg0cBummbs2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRK8AXDW73kTSdGoPHUxsbR/0VWzRo7fEodxgdiQoNae68DaWHXXpTKT9bUHYRbe2Zzw6XAM8f5Dwz24IOG3reF1FItKef0xYOmcl3qRR2mD9oGmoxQgdDgkzZ7ukL3cklCP+2rGeJ7L9hox8OYrcNxotO7OPaBNSTuPjZXittc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBt3Xidn; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2e0a060f6e8so4099313a91.1;
        Tue, 08 Oct 2024 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397478; x=1729002278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDoqXpsFl8RNldAVAwpbrbVadRrwiVLnsOpDQV2p6FU=;
        b=jBt3XidnxzdAxtucOZYfomR1qAj4bVpYp7C6Mgp/YtF4GF1JVLEE/3bAXfcRS0TwZF
         Gmg74scEufNvVuKAPhvOJqNFeXxwlM08HmVHFgz2/FBizonMCvHt/qnCv/NyI4S10ylq
         2QVInAyif+xinD0f5HRJwgN/3pHgbQpIS7qqGnIjBgTVKYHBR8PCnVegxCwuT2txzzmE
         f+61gY2PxjfDj4GzAaAqmJAZI3tdbAKZ+czQd9kRHkQJ01j+yd4aR7HpC+j5aD1Q3eOY
         D/4PtC9nQQsyev+1rByl5y4oZ6yH0fmiUK+gPNHYlYUG+4n/jguxP4oIzHoRLeIYqDOm
         /jIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397478; x=1729002278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDoqXpsFl8RNldAVAwpbrbVadRrwiVLnsOpDQV2p6FU=;
        b=Lgf4zfguewOOgGTyduP6VaOdzv53JY4iyfOWWjXN14ZkzDUF0FBZXzxGXQ+RcCncB7
         mkr5QEBWu9dubnM1zrGV2UaNySvT+KAZB4pbRtE0tDlVO1N/xV12UfbqTRznOx8MAkA5
         H7CdJq/HNXdtqU+OaoADlNV/y5th7CU5Ja+sn43G5Du6Cw22o+dYxZDj/NP+1cA8j2Tg
         yMn81pJJXqU74+mPNoj0KlDfkpQ55LXxcRCdhZGDQr7ddKHZZLiulPsw/h1r4ZaSEzeA
         kcCzhWTg7lTKc6tTa6R7xBxgnAAQc4/uaWgkPC9j0j6360WhsCDJaaodny8+PYMXdIjf
         ltkA==
X-Forwarded-Encrypted: i=1; AJvYcCV8MJdyx5vUZhmD8B6RoAadb2s0DTEHjlWtZWftVXNHvjpUN98NvX27272eYrWhwD06UaLC2ZYK@vger.kernel.org, AJvYcCVaFERnQf+vvTJFmiRXqyySYgT6uvzWwxn3cA4rk2VIdS08MuwV8oPMw9ydwsAlgtf9Sifkv1WUykl9QZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtSJtb3kHDwlESaOuw/lqzdCs3GXpC55fB97UTn22gXmJINd2
	Pyg0PHHfYgOcHiDZWTpR+q6/gkAcXvT1bh3RfIHpx5I3H1n+b3yY
X-Google-Smtp-Source: AGHT+IG8MoHjjo51qBYhs4i8ZGQOZUrl13zdZKpODtG98tfAhVNGm6E4+o4ElDc1TrJLyHeklrMvEA==
X-Received: by 2002:a17:90a:1782:b0:2e2:92dc:6fd4 with SMTP id 98e67ed59e1d1-2e292dc72e0mr988941a91.23.1728397477813;
        Tue, 08 Oct 2024 07:24:37 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:37 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 06/12] net: vxlan: make vxlan_snoop() return drop reasons
Date: Tue,  8 Oct 2024 22:22:54 +0800
Message-Id: <20241008142300.236781-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the return type of vxlan_snoop() from bool to enum
skb_drop_reason. In this commit, two drop reasons are introduced:

  SKB_DROP_REASON_MAC_INVALID_SOURCE
  SKB_DROP_REASON_VXLAN_ENTRY_EXISTS

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v5:
- rename SKB_DROP_REASON_VXLAN_INVALID_SMAC to
  SKB_DROP_REASON_MAC_INVALID_SOURCE in the commit log
v4:
- rename SKB_DROP_REASON_VXLAN_INVALID_SMAC to
  SKB_DROP_REASON_MAC_INVALID_SOURCE
---
 drivers/net/vxlan/vxlan_core.c | 17 +++++++++--------
 include/net/dropreason-core.h  |  9 +++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 34b44755f663..1a81a3957327 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1437,9 +1437,10 @@ static int vxlan_fdb_get(struct sk_buff *skb,
  * and Tunnel endpoint.
  * Return true if packet is bogus and should be dropped.
  */
-static bool vxlan_snoop(struct net_device *dev,
-			union vxlan_addr *src_ip, const u8 *src_mac,
-			u32 src_ifindex, __be32 vni)
+static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
+					union vxlan_addr *src_ip,
+					const u8 *src_mac, u32 src_ifindex,
+					__be32 vni)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	struct vxlan_fdb *f;
@@ -1447,7 +1448,7 @@ static bool vxlan_snoop(struct net_device *dev,
 
 	/* Ignore packets from invalid src-address */
 	if (!is_valid_ether_addr(src_mac))
-		return true;
+		return SKB_DROP_REASON_MAC_INVALID_SOURCE;
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (src_ip->sa.sa_family == AF_INET6 &&
@@ -1461,15 +1462,15 @@ static bool vxlan_snoop(struct net_device *dev,
 
 		if (likely(vxlan_addr_equal(&rdst->remote_ip, src_ip) &&
 			   rdst->remote_ifindex == ifindex))
-			return false;
+			return SKB_NOT_DROPPED_YET;
 
 		/* Don't migrate static entries, drop packets */
 		if (f->state & (NUD_PERMANENT | NUD_NOARP))
-			return true;
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
 		/* Don't override an fdb with nexthop with a learnt entry */
 		if (rcu_access_pointer(f->nh))
-			return true;
+			return SKB_DROP_REASON_VXLAN_ENTRY_EXISTS;
 
 		if (net_ratelimit())
 			netdev_info(dev,
@@ -1497,7 +1498,7 @@ static bool vxlan_snoop(struct net_device *dev,
 		spin_unlock(&vxlan->hash_lock[hash_index]);
 	}
 
-	return false;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 98259d2b3e92..1cb8d7c953be 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -94,6 +94,8 @@
 	FN(TC_RECLASSIFY_LOOP)		\
 	FN(VXLAN_INVALID_HDR)		\
 	FN(VXLAN_VNI_NOT_FOUND)		\
+	FN(MAC_INVALID_SOURCE)		\
+	FN(VXLAN_ENTRY_EXISTS)		\
 	FN(IP_TUNNEL_ECN)		\
 	FNe(MAX)
 
@@ -429,6 +431,13 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_VXLAN_INVALID_HDR,
 	/** @SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND: no VXLAN device found for VNI */
 	SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND,
+	/** @SKB_DROP_REASON_MAC_INVALID_SOURCE: source mac is invalid */
+	SKB_DROP_REASON_MAC_INVALID_SOURCE,
+	/**
+	 * @SKB_DROP_REASON_VXLAN_ENTRY_EXISTS: trying to migrate a static
+	 * entry or an entry pointing to a nexthop.
+	 */
+	SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
 	/**
 	 * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
 	 * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
-- 
2.39.5


