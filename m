Return-Path: <netdev+bounces-235775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D17E4C35542
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66A6B4F7637
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0622F5332;
	Wed,  5 Nov 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kZZ8piDj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013D309EF9
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341614; cv=none; b=HUGyQTG1+oq8nk9d6U+h9Ydk7miPK4DTZ1+yI1XJLlobVFOZKVU0/ruAUDmjr0taH1riA9603YxyCGlYErbIM4/tCXcSPIjOMZwapBwi5F22pWqkQ7scqgbYb3hkV+ZPHBJxpq6OYsbylhkXhLHS6LS62PvovYKuWmpnHYKQtfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341614; c=relaxed/simple;
	bh=2ZqPgpPiPHrS92JfBz+aBJWUDxgtCMKCK+HjZxs5CD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tj/J5eQX2LJnpH/MrZz9conl7tI26N+qy9it7pWM8vMwDObXKOKh/Yn+38w1mQg6cft0XSC2wxAIqPoshVNbd+JcdWEwYBWgCMwsNM8tZThT9raUrZcl2o6jPp2IiqTk8kQy+N00YWNpk1mLvDJ2V46gXsT4EmCqZk5GKy+a/vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kZZ8piDj; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b719ca8cb8dso391191166b.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 03:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762341611; x=1762946411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMKJnQ1D1xmyer3aTvAUN3eT/mrH4zICFOPCjbHYI/I=;
        b=kZZ8piDjv/KOmW6bmwsh2czPE12MbTSa4oEszlKwiLBFX5nX6H9FzSFsZXVug9+JkC
         xMcj4BMr0/oC0R7GKYd2caWWB+saYjAUE4z703IteV0F0vEjJAqnK2t0qPtj7pOJnogc
         K5Q1yL5x/5NcJPu+P5RnLgXXsQzjq7fVOTCJvopT3q/R0N/u9tbwF4+Qtq1bWpnXSIeI
         7YLBW7ijn8G3S7mImAXFLZZw842H7BRIMWtw10ffzbGE+eCbMqUHKW+aw53JG4lEmZp1
         egQ5zL/fT2Gx019eF6iH7uIWFOzyiZhRohrGFH6hsjSM/Cj5KMuQ4Qns5oZmp3JSB6F5
         l13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341611; x=1762946411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMKJnQ1D1xmyer3aTvAUN3eT/mrH4zICFOPCjbHYI/I=;
        b=KB2MuLGZeRueMynu45fCcBpNm1MwzVkRicCBkQ+8ZdDYVdMbb8F6IxV2i9LUVUK9b8
         lWVdnvufip+Gr5ZnupFFmlvcPhWQKisuYUkJXSMyQxa9hRm3QsazH2VAuk+AowMieqha
         sWS8bxKiKCLPg6Ob6EDrglnJEUSSf1RJw9AC2IjNcMzIubLwX+8SisOV2kIYhvZCEn9K
         deDsplnnpUWbwiLNXB4GdFVJRbYRmRT9P0DofS1fH9LheGv3u/nNFvE3ACfVfQkXilSU
         zF3jyHpoTlIjypzmBOeIac7PZb8regkD9ylcVbNPLN3IJxVK5FCf6ZmQOXKkvnddnnkk
         NN5g==
X-Gm-Message-State: AOJu0YyoHyJ7331xwW88C2Q9IWbejCuD+0wdz1ZaZNDczwlmm7UBumat
	61HlBrStYIxsqzriJV05PCzOS4S8lgFmsgGWpZuurJ8MWtF0jTLBiHXWBU5/eTZzXPdAcI3T/O2
	oBfBKEaLY1Q==
X-Gm-Gg: ASbGncuMEnGd+bDxikxUU8TGNHP0ZLjMzfiDqkckHlT3T+TOxWD0drUagqcOW0eT2nI
	ooS15GVcfEMLQ7Iq+KDad71ngf8gtvmT90hoIsg40T4IHOAWjZhjpHt3QDUs4R82teqdf+ixZx/
	kREL+edaJKwILvZgF5peoXiaTQx/vNLLooGOA/wsaBqxwhBK/IWbxfYGIsHlwKVjTBurlLjDRYY
	+6dMkAySmuaS2jP0yoivnIWqwzpMn7WwbXEc8QsWQnvQzYNjCDk3XaC5w+QJRi2ZK9X0gnLgw28
	cGEfrLsVnp/ErtcttYBLuD69L6yJwGmajoB1glAGz2bRlC+/TsKqRTR3KZfyDLKjEdZndfvANhD
	wiSX3kgqLkD2nMW2TM/cKZD8uBt1IkrdBXd91FGvjG+vzPn/76rJrkkSeBdZF8d12bDyWlo6kya
	K/+lc5exYcnqZAxy2/pz/muVerjyOWU2COMA==
X-Google-Smtp-Source: AGHT+IHx03FuYXvELFzKpMaKbaxgNjC/IRcF4XcMpAXdnaRWceclyZ7+QT+bIuyV4EfsXKnTVW3QCA==
X-Received: by 2002:a17:907:26c8:b0:b71:75bd:cf51 with SMTP id a640c23a62f3a-b7265587b30mr239001766b.38.1762341610641;
        Wed, 05 Nov 2025 03:20:10 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724064d25csm455208266b.72.2025.11.05.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:20:10 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	petrm@nvidia.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Subject: [PATCH net v2 1/2] net: bridge: fix use-after-free due to MST port state bypass
Date: Wed,  5 Nov 2025 13:19:18 +0200
Message-ID: <20251105111919.1499702-2-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105111919.1499702-1-razor@blackwall.org>
References: <20251105111919.1499702-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported[1] a use-after-free when deleting an expired fdb. It is
due to a race condition between learning still happening and a port being
deleted, after all its fdbs have been flushed. The port's state has been
toggled to disabled so no learning should happen at that time, but if we
have MST enabled, it will bypass the port's state, that together with VLAN
filtering disabled can lead to fdb learning at a time when it shouldn't
happen while the port is being deleted. VLAN filtering must be disabled
because we flush the port VLANs when it's being deleted which will stop
learning. This fix adds a check for the port's vlan group which is
initialized to NULL when the port is getting deleted, that avoids the port
state bypass. When MST is enabled there would be a minimal new overhead
in the fast-path because the port's vlan group pointer is cache-hot.

[1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
v2: new fix approach using port's vlan group check when MST is enabled
    we rely on the fact that the vlan group gets initialized to NULL
    when the port is getting deleted

 net/bridge/br_forward.c | 2 +-
 net/bridge/br_input.c   | 4 ++--
 net/bridge/br_private.h | 8 +++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 870bdf2e082c..dea09096ad0f 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -25,7 +25,7 @@ static inline int should_deliver(const struct net_bridge_port *p,
 
 	vg = nbp_vlan_group_rcu(p);
 	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
-		(br_mst_is_enabled(p->br) || p->state == BR_STATE_FORWARDING) &&
+		(br_mst_is_enabled(p) || p->state == BR_STATE_FORWARDING) &&
 		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
 }
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 67b4c905e49a..777fa869c1a1 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -94,7 +94,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 
 	br = p->br;
 
-	if (br_mst_is_enabled(br)) {
+	if (br_mst_is_enabled(p)) {
 		state = BR_STATE_FORWARDING;
 	} else {
 		if (p->state == BR_STATE_DISABLED) {
@@ -429,7 +429,7 @@ static rx_handler_result_t br_handle_frame(struct sk_buff **pskb)
 		return RX_HANDLER_PASS;
 
 forward:
-	if (br_mst_is_enabled(p->br))
+	if (br_mst_is_enabled(p))
 		goto defer_stp_filtering;
 
 	switch (p->state) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 16be5d250402..b571d6f61389 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1935,10 +1935,12 @@ static inline bool br_vlan_state_allowed(u8 state, bool learn_allow)
 /* br_mst.c */
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 DECLARE_STATIC_KEY_FALSE(br_mst_used);
-static inline bool br_mst_is_enabled(struct net_bridge *br)
+static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
 {
+	/* check the port's vlan group to avoid racing with port deletion */
 	return static_branch_unlikely(&br_mst_used) &&
-		br_opt_get(br, BROPT_MST_ENABLED);
+	       br_opt_get(p->br, BROPT_MST_ENABLED) &&
+	       rcu_access_pointer(p->vlgrp);
 }
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
@@ -1953,7 +1955,7 @@ int br_mst_fill_info(struct sk_buff *skb,
 int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
 		   struct netlink_ext_ack *extack);
 #else
-static inline bool br_mst_is_enabled(struct net_bridge *br)
+static inline bool br_mst_is_enabled(const struct net_bridge_port *p)
 {
 	return false;
 }
-- 
2.51.0


